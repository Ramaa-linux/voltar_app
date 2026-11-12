import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/guess_component/resistor_code.dart';

void main() {
  group('ResistorCode Calculator & Formatter', () {
    test('resistorOhms computes correct values for 4-band codes', () {
      expect(
        resistorOhms(ResistorBand.red, ResistorBand.red, ResistorBand.brown),
        equals(220.0),
      );
      expect(
        resistorOhms(ResistorBand.brown, ResistorBand.black, ResistorBand.red),
        equals(1000.0),
      );
      expect(
        resistorOhms(
          ResistorBand.brown,
          ResistorBand.black,
          ResistorBand.orange,
        ),
        equals(10000.0),
      );
      expect(
        resistorOhms(
          ResistorBand.yellow,
          ResistorBand.violet,
          ResistorBand.red,
        ),
        equals(4700.0),
      );
      expect(
        resistorOhms(
          ResistorBand.brown,
          ResistorBand.black,
          ResistorBand.green,
        ),
        equals(1000000.0),
      );
    });

    test('formatOhm formats Indonesian style correctly', () {
      expect(formatOhm(220), equals('220 Ω'));
      expect(formatOhm(4700), equals('4,7 kΩ'));
      expect(formatOhm(10000), equals('10 kΩ'));
      expect(formatOhm(1000000), equals('1 MΩ'));
      expect(formatOhm(100), equals('100 Ω'));
    });

    test('buildResistorDistractors produces 3 unique options excluding correct', () {
      final List<String> distractors220 = buildResistorDistractors(220);
      expect(distractors220.length, equals(3));
      expect(distractors220.contains('220 Ω'), isFalse);
      expect(distractors220.toSet().length, equals(3));

      final List<String> distractors1k = buildResistorDistractors(1000);
      expect(distractors1k.length, equals(3));
      expect(distractors1k.contains('1 kΩ'), isFalse);
      expect(distractors1k.toSet().length, equals(3));
    });
  });
}
