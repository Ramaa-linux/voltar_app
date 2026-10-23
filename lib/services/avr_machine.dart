import 'package:avr8_dart/avr8_dart.dart';
import 'package:voltar/services/avr_program.dart';

/// Callback saat pin digital berubah.
///
/// [digitalPin] memakai nomor pin Arduino Uno (0-19), [value] 1 = HIGH,
/// 0 = LOW.
typedef AvrPinListener = void Function(int digitalPin, int value);

/// Satu mesin AVR lengkap: CPU ATmega328P + clock + 3 timer + GPIO.
///
/// Tidak menyentuh Flutter/async sama sekali, jadi bisa hidup di isolate mana
/// pun dan dites langsung tanpa `Timer` atau widget.
class AvrMachine {
  AvrMachine(AvrProgram program, {this.cpuHz = 16000000, this.onPinChange})
    : cpu = CPU(program.words) {
    // Port dibuat lebih dulu supaya timer bisa resolve clock eksternal lewat
    // cpu.gpioByPort, dan listener sudah terpasang sebelum program berjalan.
    final AVRIOPort portB = AVRIOPort(cpu, portBConfig);
    final AVRIOPort portC = AVRIOPort(cpu, portCConfig);
    final AVRIOPort portD = AVRIOPort(cpu, portDConfig);

    clock = AVRClock(cpu, cpuHz);
    timers.add(AVRTimer(cpu, timer0Config)); // millis()/delay() Arduino
    timers.add(AVRTimer(cpu, timer1Config));
    timers.add(AVRTimer(cpu, timer2Config));

    _watchPort(portB, _firstPinB, 6); // D8-D13 -> PB0-PB5
    _watchPort(portC, _firstPinC, 6); // A0-A5 -> PC0-PC5
    _watchPort(portD, _firstPinD, 8); // D0-D7 -> PD0-PD7
  }

  /// Pemetaan pin Arduino Uno ke port ATmega328P.
  static const int _firstPinD = 0;
  static const int _firstPinB = 8;
  static const int _firstPinC = 14;

  /// Jumlah pin digital yang dilacak (D0-D13 + A0-A5, plus ruang cadangan).
  static const int _trackedPins = 24;

  final CPU cpu;
  final int cpuHz;
  final AvrPinListener? onPinChange;

  /// Clock dan timer disimpan agar nanti bisa dipakai UI (frekuensi, PWM).
  late final AVRClock clock;
  final List<AVRTimer> timers = <AVRTimer>[];

  /// Nilai terakhir tiap pin digital; -1 = belum pernah dibaca.
  final List<int> _pinCache = List<int>.filled(_trackedPins, -1);

  /// Jumlah cycle CPU sejak reset.
  int get cycles => cpu.cycles;

  /// Waktu simulasi (ms) dihitung dari cycle, bukan jam dinding.
  int get millis => (cpu.cycles * 1000) ~/ cpuHz;

  /// Nilai pin digital terakhir (1/0), null bila pin di luar pemetaan.
  int? pinValue(int digitalPin) {
    if (digitalPin < 0 || digitalPin >= _pinCache.length) {
      return null;
    }
    final int cached = _pinCache[digitalPin];
    return cached < 0 ? null : cached;
  }

  /// Jalankan CPU sampai [targetCycles] tercapai.
  void advanceTo(int targetCycles) {
    while (cpu.cycles < targetCycles) {
      avrInstruction(cpu);
      cpu.tick();
    }
  }

  void _watchPort(AVRIOPort port, int firstDigitalPin, int bitCount) {
    port.addListener(
      (int value, int oldValue) =>
          _refreshPins(port, firstDigitalPin, bitCount),
    );
    // Nilai awal dicatat tanpa notifikasi: halaman sudah default LOW.
    _refreshPins(port, firstDigitalPin, bitCount, notify: false);
  }

  /// Baca ulang semua bit port, laporkan hanya yang berubah.
  ///
  /// Nilai diambil dari [AVRIOPort.pinState] (memperhitungkan DDR), bukan bit
  /// PORT mentah - `digitalWrite` Arduino menulis PORT sebelum DDR.
  void _refreshPins(
    AVRIOPort port,
    int firstDigitalPin,
    int bitCount, {
    bool notify = true,
  }) {
    for (int bit = 0; bit < bitCount; bit++) {
      final int digitalPin = firstDigitalPin + bit;
      final int value = switch (port.pinState(bit)) {
        PinState.High => 1,
        PinState.InputPullUp => 1,
        PinState.Low => 0,
        PinState.Input => 0,
      };
      if (_pinCache[digitalPin] == value) {
        continue;
      }
      _pinCache[digitalPin] = value;
      if (notify) {
        onPinChange?.call(digitalPin, value);
      }
    }
  }
}
