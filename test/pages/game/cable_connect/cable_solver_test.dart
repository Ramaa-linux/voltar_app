import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/cable_connect/cable_levels.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/pages/game/cable_connect/cable_rules.dart';
import 'package:voltar/pages/game/cable_connect/cable_solver.dart';

void main() {
  group('CableSolver', () {
    final CableSolver solver = CableSolver();

    test('solves all hardcoded tutorial levels 1 to 3', () {
      for (final CableLevel tutorial in CableLevels.tutorials) {
        final List<Pos>? solution = solver.solve(tutorial);
        expect(
          solution,
          isNotNull,
          reason: 'Tutorial level ${tutorial.id} should be solvable',
        );
        expect(PathRules.isCircuitComplete(tutorial, solution!), isTrue);
      }
    });

    test('returns null on unsolvable walled-off board', () {
      final CableLevel impossible = CableLevel.fromAscii(
        id: 404,
        grid: const <String>[
          '+.#.',
          '###.',
          '..L-',
          '....',
        ],
      );
      expect(solver.isSolvable(impossible), isFalse);
    });
  });
}
