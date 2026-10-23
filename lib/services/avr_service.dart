import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:voltar/services/avr_engine.dart';

/// Glue code antara mesin AVR dan UI.
///
/// Halaman cukup memanggil [start]/[stop] dan mendengar [watchPin]; tidak ada
/// isolate, timer, atau akses aset di lapisan UI. [AvrEngine] yang memegang
/// siklus hidup CPU, sedangkan kelas ini mengubah callback-nya menjadi stream
/// broadcast dan menyimpan nilai terakhir tiap pin.
class AvrService {
  /// Sketsa uji bawaan: Blink LED pin 13, ATmega328P @16 MHz.
  static const String blinkHexAsset = 'assets/hex/blink.hex';

  /// Pin LED bawaan Arduino Uno (PB5).
  static const int blinkPin = 13;

  final Map<int, StreamController<int>> _pinControllers =
      <int, StreamController<int>>{};
  final Map<int, int> _pinValues = <int, int>{};
  final StreamController<String> _errors = StreamController<String>.broadcast();

  AvrEngine? _engine;
  Future<void>? _startInFlight;
  bool _disposed = false;

  /// `true` saat CPU sedang berjalan.
  bool get isRunning => _engine?.isRunning ?? false;

  /// `true` bila CPU berjalan di isolate, `false` bila memakai timer (web).
  bool get runsInIsolate => !kIsWeb;

  /// Error runtime dari worker (mis. hex rusak). Engine sudah berhenti.
  Stream<String> get errors => _errors.stream;

  /// Nilai pin terakhir yang diketahui, null bila belum pernah berubah.
  int? pinValue(int pinNumber) => _pinValues[pinNumber];

  /// Stream 1 (HIGH) / 0 (LOW), hanya keluar saat nilai pin berubah.
  Stream<int> watchPin(int pinNumber) => _controllerFor(pinNumber).stream;

  /// Muat hex dari aset lalu jalankan simulasi.
  ///
  /// Aman dipanggil berkali-kali: pemanggilan saat start masih berjalan akan
  /// menunggu proses yang sama, bukan memulai mesin kedua.
  Future<void> start({String hexAsset = blinkHexAsset}) {
    final Future<void>? inFlight = _startInFlight;
    if (inFlight != null) {
      return inFlight;
    }
    if (isRunning) {
      return Future<void>.value();
    }
    final Future<void> job = _start(hexAsset);
    _startInFlight = job;
    return job.whenComplete(() => _startInFlight = null);
  }

  Future<void> _start(String hexAsset) async {
    if (_disposed) {
      throw StateError('AvrService sudah di-dispose');
    }
    final String hex = await rootBundle.loadString(hexAsset);
    final AvrEngine engine = _engine ??= AvrEngine(
      onPinChange: _emitPin,
      onError: _emitError,
    );
    await engine.start(hex);
  }

  /// Hentikan CPU. Nilai pin terakhir tetap tersimpan untuk `initialData`.
  void stop() {
    _engine?.stop();
  }

  /// Hentikan CPU dan tutup semua stream. Panggil dari `State.dispose`.
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _engine?.stop();
    _engine = null;
    for (final StreamController<int> controller in _pinControllers.values) {
      await controller.close();
    }
    _pinControllers.clear();
    _pinValues.clear();
    await _errors.close();
  }

  void _emitPin(int pinNumber, int value) {
    if (_pinValues[pinNumber] == value) {
      return;
    }
    _pinValues[pinNumber] = value;
    _pinControllers[pinNumber]?.add(value);
  }

  void _emitError(String message) {
    if (_errors.isClosed) {
      return;
    }
    _errors.add(message);
  }

  StreamController<int> _controllerFor(int pinNumber) {
    return _pinControllers.putIfAbsent(
      pinNumber,
      () => StreamController<int>.broadcast(),
    );
  }
}
