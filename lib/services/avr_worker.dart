import 'dart:async';
import 'dart:isolate';

import 'package:voltar/services/avr_machine.dart';
import 'package:voltar/services/avr_program.dart';

/// Tipe pesan worker -> isolate utama: `[messagePin, digitalPin, value]`.
const int messagePin = 0;

/// Tick simulasi di worker (~60 Hz).
const Duration _tickInterval = Duration(milliseconds: 16);

/// Batas cycle per tick agar satu tick tidak pernah menahan isolate lama.
const int _maxCyclesPerTick = 400000;

/// Entry point isolate simulasi (native saja - web tidak punya isolate).
///
/// [args] = `[SendPort isolate utama, String hex]`. Worker langsung berjalan
/// sampai di-kill oleh `AvrService.stop()`, jadi tidak perlu kanal masuk.
@pragma('vm:entry-point')
void avrWorkerMain(List<Object> args) {
  final SendPort toMain = args[0] as SendPort;
  final String hex = args[1] as String;

  final Stopwatch wallClock = Stopwatch()..start();
  final AvrMachine machine = AvrMachine(
    AvrProgram.parseIntelHex(hex),
    onPinChange: (int digitalPin, int value) =>
        toMain.send(<int>[messagePin, digitalPin, value]),
  );

  Timer.periodic(_tickInterval, (Timer _) {
    // Jalankan sebanyak cycle yang seharusnya sudah lewat di waktu nyata.
    final int target = wallClock.elapsedMicroseconds * machine.cpuHz ~/ 1000000;
    final int limit = machine.cycles + _maxCyclesPerTick;
    machine.advanceTo(target < limit ? target : limit);
  });
}
