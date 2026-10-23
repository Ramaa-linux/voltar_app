import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/services/avr_program.dart';

void main() {
  final String blinkHex = File('assets/hex/blink.hex').readAsStringSync();

  test('parse blink.hex jadi memori flash 16-bit', () {
    final AvrProgram program = AvrProgram.parseIntelHex(blinkHex);

    expect(program.words.length, AvrProgram.flashWords);
    // Reset vector ATmega328P: 0x0C 0x94 (JMP) -> word 0x940C.
    expect(program.words[0] & 0xff, 0x0c);
    expect(program.words[0] >> 8, 0x94);
  });

  test('menolak checksum yang salah', () {
    expect(
      () => AvrProgram.parseIntelHex(
        ':100000000C945C000C946E000C946E000C946E00CB\n:00000001FF',
      ),
      throwsFormatException,
    );
  });

  test('menolak file tanpa record EOF', () {
    expect(
      () => AvrProgram.parseIntelHex(
        ':100000000C945C000C946E000C946E000C946E00CA',
      ),
      throwsFormatException,
    );
  });
}
