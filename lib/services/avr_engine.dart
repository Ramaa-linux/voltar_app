import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:voltar/services/avr_machine.dart';
import 'package:voltar/services/avr_program.dart';
import 'package:voltar/services/avr_worker.dart';

/// Pemilik siklus hidup mesin AVR.
///
/// Native: CPU hidup di isolate sendiri lewat [avrWorkerMain]. Web: Dart tidak
/// punya isolate, jadi loop dipindah ke isolate utama dengan kuota cycle per
/// tick. Kelas ini tidak menyentuh UI dan tidak menyimpan stream; semua hasil
/// dikirim balik lewat [onPinChange] dan [onError], lalu [AvrService] yang
/// meneruskannya ke UI.
class AvrEngine {
  AvrEngine({required this.onPinChange, required this.onError});

  /// Tick loop lokal (web) ~60 Hz.
  static const Duration tickInterval = Duration(milliseconds: 16);

  /// Batas kerja per tick supaya frame web tidak tersendat.
  static const int maxCyclesPerTick = 200000;

  /// Dipanggil tiap status pin digital berubah: 1 = HIGH, 0 = LOW.
  final void Function(int pinNumber, int value) onPinChange;

  /// Dipanggil saat worker gagal (mis. hex rusak). Engine sudah berhenti.
  final void Function(String message) onError;

  Isolate? _isolate;
  ReceivePort? _messages;
  Timer? _ticker;
  Stopwatch? _clock;
  bool _running = false;

  bool get isRunning => _running;

  /// `true` bila CPU berjalan di isolate terpisah (native/desktop/mobile).
  bool get runsInIsolate => !kIsWeb;

  /// Jalankan [hex] dari kondisi reset. Abaikan bila sudah berjalan.
  Future<void> start(String hex) async {
    if (_running) {
      return;
    }
    _running = true;
    try {
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
    } catch (_) {
      _teardown();
      rethrow;
    }
  }

  /// Hentikan CPU. Mesin kembali ke kondisi reset saat [start] dipanggil lagi.
  void stop() {
    _teardown();
  }

  void _startLocal(String hex) {
    final AvrMachine machine = AvrMachine(
      AvrProgram.parseIntelHex(hex),
      onPinChange: onPinChange,
    );
    final Stopwatch clock = Stopwatch()..start();
    _clock = clock;
    _ticker = Timer.periodic(tickInterval, (Timer _) {
      final int target = clock.elapsedMicroseconds * machine.cpuHz ~/ 1000000;
      final int limit = machine.cycles + maxCyclesPerTick;
      machine.advanceTo(target < limit ? target : limit);
    });
  }

  void _handleMessage(Object? message) {
    if (message is List<int> && message.length == 3) {
      onPinChange(message[1], message[2]);
      return;
    }
    // Pesan `onError` isolate: [error, stackTrace].
    if (message is List && message.isNotEmpty) {
      _teardown();
      onError('${message.first}');
    }
  }

  void _teardown() {
    _ticker?.cancel();
    _ticker = null;
    _clock?.stop();
    _clock = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _messages?.close();
    _messages = null;
    _running = false;
  }
}
