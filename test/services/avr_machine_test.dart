import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/services/avr_machine.dart';
import 'package:voltar/services/avr_program.dart';

void main() {
  test('blink.hex menyalakan dan mematikan pin 13 bergantian', () {
    final List<int> pin13 = <int>[];
    final AvrMachine machine = AvrMachine(
      AvrProgram.parseIntelHex(File('assets/hex/blink.hex').readAsStringSync()),
      onPinChange: (int digitalPin, int value) {
        if (digitalPin == 13) {
          pin13.add(value);
        }
      },
    );

    // 1 detik simulasi = 16 juta cycle; jalankan bertahap sampai 2,5 detik.
    const int step = 500000;
    for (int target = step; target <= 40000000; target += step) {
      machine.advanceTo(target);
      if (pin13.contains(0) && pin13.contains(1)) {
        break;
      }
    }

    expect(pin13.length, greaterThanOrEqualTo(2));
    for (int i = 1; i < pin13.length; i++) {
      expect(pin13[i], isNot(pin13[i - 1]), reason: 'LED harus bergantian');
    }
    expect(machine.millis, greaterThan(0));
  });
}
