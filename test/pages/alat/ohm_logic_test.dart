import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/alat/ohm_logic.dart';

void main() {
  group('OhmCalculator Logic Tests', () {
    test('parseInput handles dots, commas, spaces and invalid input', () {
      expect(OhmCalculator.parseInput('12'), 12.0);
      expect(OhmCalculator.parseInput(' 12.5 '), 12.5);
      expect(OhmCalculator.parseInput('12,5'), 12.5);
      expect(OhmCalculator.parseInput('0,05'), 0.05);
      expect(OhmCalculator.parseInput(''), isNull);
      expect(OhmCalculator.parseInput('.'), isNull);
      expect(OhmCalculator.parseInput(','), isNull);
      expect(OhmCalculator.parseInput('-5'), isNull);
      expect(OhmCalculator.parseInput('abc'), isNull);
    });

    test('formatValue trims trailing zeros and fixes float artifacts', () {
      expect(OhmCalculator.formatValue(12.0), '12');
      expect(OhmCalculator.formatValue(12.500), '12.5');
      expect(OhmCalculator.formatValue(12.34567), '12.3457');
      // Float artifact 0.1 + 0.2
      final double sum = 0.1 + 0.2;
      expect(OhmCalculator.formatValue(sum), '0.3');
    });

    test('calculate V = I * R with integer and decimal values', () {
      final OhmCalculationResult res = OhmCalculator.calculate(
        voltage: null,
        current: 2.0,
        resistance: 100.0,
      );
      expect(res.targetVariable, OhmVariable.voltage);
      expect(res.calculatedValue, 200.0);
      expect(res.formattedValue, '200');
      expect(res.hasError, isFalse);

      final OhmCalculationResult res2 = OhmCalculator.calculate(
        voltage: null,
        current: 0.02,
        resistance: 220.0,
      );
      expect(res2.calculatedValue, 4.4);
      expect(res2.formattedValue, '4.4');
    });

    test('calculate I = V / R with integer and decimal values', () {
      final OhmCalculationResult res = OhmCalculator.calculate(
        voltage: 12.0,
        current: null,
        resistance: 4.0,
      );
      expect(res.targetVariable, OhmVariable.current);
      expect(res.calculatedValue, 3.0);
      expect(res.formattedValue, '3');
      expect(res.hasError, isFalse);

      final OhmCalculationResult res2 = OhmCalculator.calculate(
        voltage: 5.0,
        current: null,
        resistance: 220.0,
      );
      expect(res2.formattedValue, '0.0227');
    });

    test('calculate R = V / I with integer and decimal values', () {
      final OhmCalculationResult res = OhmCalculator.calculate(
        voltage: 9.0,
        current: 0.03,
        resistance: null,
      );
      expect(res.targetVariable, OhmVariable.resistance);
      expect(res.calculatedValue, 300.0);
      expect(res.formattedValue, '300');
      expect(res.hasError, isFalse);
    });

    test(
      'Division by zero produces error message instead of Infinity or NaN',
      () {
        // I = V / R with R = 0
        final OhmCalculationResult resI = OhmCalculator.calculate(
          voltage: 12.0,
          current: null,
          resistance: 0.0,
        );
        expect(resI.hasError, isTrue);
        expect(resI.errorMessage, 'Hambatan (R) tidak boleh 0');
        expect(resI.calculatedValue, isNull);

        // R = V / I with I = 0
        final OhmCalculationResult resR = OhmCalculator.calculate(
          voltage: 12.0,
          current: 0.0,
          resistance: null,
        );
        expect(resR.hasError, isTrue);
        expect(resR.errorMessage, 'Arus (I) tidak boleh 0');
        expect(resR.calculatedValue, isNull);
      },
    );

    test('Less than 2 fields returns empty result', () {
      final OhmCalculationResult res1 = OhmCalculator.calculate(
        voltage: 12.0,
        current: null,
        resistance: null,
      );
      expect(res1.targetVariable, isNull);
      expect(res1.hasResult, isFalse);

      final OhmCalculationResult res0 = OhmCalculator.calculate(
        voltage: null,
        current: null,
        resistance: null,
      );
      expect(res0.targetVariable, isNull);
      expect(res0.hasResult, isFalse);
    });

    test('3 fields filled recalculates the least recently edited field', () {
      // Suppose user edited V, then I. Resistance R should be recalculated.
      final OhmCalculationResult res1 = OhmCalculator.calculate(
        voltage: 10.0,
        current: 2.0,
        resistance: 99.0,
        editHistory: <OhmVariable>[OhmVariable.voltage, OhmVariable.current],
      );
      expect(res1.targetVariable, OhmVariable.resistance);
      expect(res1.calculatedValue, 5.0);
      expect(res1.formattedValue, '5');

      // Now user edited R. Recent are I and R. Voltage V should be recalculated.
      final OhmCalculationResult res2 = OhmCalculator.calculate(
        voltage: 99.0,
        current: 3.0,
        resistance: 4.0,
        editHistory: <OhmVariable>[
          OhmVariable.voltage,
          OhmVariable.current,
          OhmVariable.resistance,
        ],
      );
      expect(res2.targetVariable, OhmVariable.voltage);
      expect(res2.calculatedValue, 12.0);
      expect(res2.formattedValue, '12');
    });
  });
}
