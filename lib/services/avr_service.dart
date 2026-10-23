import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:voltar/services/avr_machine.dart';
import 'package:voltar/services/avr_program.dart';
import 'package:voltar/services/avr_worker.dart';

/// Pengendali mesin AVR untuk halaman simulasi.
///
/// Native (Android/iOS/desktop): CPU jalan di isolate terpisah, UI tidak
/// pernah tersendat. Web: Dart tidak punya isolate, jadi loop dipindah ke
/// isolate utama dengan kuota cycle terbatas per tick.
class AvrService {
  /// Sketsa uji bawaan: Blink LED pin 13, ATmega328P @16 MHz.
  static const String blinkHexAsset = 'assets/hex/blink.hex';

  static const Duration _tickInterval = Duration(milliseconds: 16);
  static const int _maxCyclesPerTick = 200000;

  final Map<int, StreamController<int>> _pinControllers =
      <int, StreamController<int>>{};
  final Map<int, int> _pinValues = <int, int>{};
  final StreamController<String> _errors = StreamController<String>.broadcast();

  Isolate? _isolate;
  ReceivePort? _messages;
  Timer? _localTicker;
  Stopwatch? _localClock;
  bool _running = false;

  bool get isRunning => _running;

  /// Error runtime dari isolate simulasi (mis. hex rusak).
  Stream<String> get errors => _errors.stream;

  /// Nilai pin terakhir yang diketahui, null bila belum pernah berubah.
  int? pinValue(int pinNumber) => _pinValues[pinNumber];

  /// Stream 1 (HIGH) / 0 (LOW) pin digital, hanya saat nilainya berubah.
  Stream<int> watchPin(int pinNumber) => _controllerFor(pinNumber).stream;

  /// Muat hex lalu jalankan simulasi. Aman dipanggil berkali-kali.
  Future<void> start() async {
    if (_running) {
      return;
    }
    _running = true;
    try {
      final String hex = await rootBundle.loadString(blinkHexAsset);
      if (kIsWeb) {
        _startLocal(hex);
        return;
      }
      final ReceivePort messages = ReceivePort();
      _messages = messages;
      messages.listen(_handleMessage);
      _isolate = await Isolate.spawn(
        avrWorkerMain,
        <Object>[messages.sendPort, hex],
        onError: messages.sendPort,
        errorsAreFatal: true,
        debugName: 'voltar-avr',
      );
    } catch (error) {
      _running = false;
      rethrow;
    }
  }

  /// Hentikan simulasi. CPU kembali ke kondisi reset saat `start()` lagi.
  void stop() {
    _localTicker?.cancel();
    _localTicker = null;
    _localClock?.stop();
    _localClock = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _messages?.close();
    _messages = null;
    _running = false;
  }

  /// Hentikan simulasi dan tutup semua stream. Panggil dari `State.dispose`.
  Future<void> dispose() async {
    stop();
    for (final StreamController<int> controller in _pinControllers.values) {
      await controller.close();
    }
    _pinControllers.clear();
    _pinValues.clear();
    await _errors.close();
  }

  void _startLocal(String hex) {
    final AvrMachine machine = AvrMachine(
      AvrProgram.parseIntelHex(hex),
      onPinChange: _emitPin,
    );
    final Stopwatch clock = Stopwatch()..start();
    _localClock = clock;
    _localTicker = Timer.periodic(_tickInterval, (Timer _) {
      final int target = clock.elapsedMicroseconds * machine.cpuHz ~/ 1000000;
      final int limit = machine.cycles + _maxCyclesPerTick;
      machine.advanceTo(target < limit ? target : limit);
    });
  }

  void _handleMessage(Object? message) {
    if (message is List<int> && message.length == 3) {
      _emitPin(message[1], message[2]);
      return;
    }
    // Pesan `onError` isolate: [error, stackTrace].
    if (message is List && message.isNotEmpty) {
      _stopAfterWorkerError('${message.first}');
    }
  }

  void _stopAfterWorkerError(String message) {
    _running = false;
    _isolate = null;
    _messages?.close();
    _messages = null;
    if (!_errors.isClosed) {
      _errors.add(message);
    }
  }

  void _emitPin(int pinNumber, int value) {
    if (_pinValues[pinNumber] == value) {
      return;
    }
    _pinValues[pinNumber] = value;
    _pinControllers[pinNumber]?.add(value);
  }

  StreamController<int> _controllerFor(int pinNumber) {
    return _pinControllers.putIfAbsent(
      pinNumber,
      () => StreamController<int>.broadcast(),
    );
  }
}
