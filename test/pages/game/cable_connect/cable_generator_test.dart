import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/cable_connect/cable_generator.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/pages/game/cable_connect/cable_rules.dart';
import 'package:voltar/pages/game/cable_connect/cable_solver.dart';

void main() {
  group('CableGenerator & SeededRng', () {
    test('SeededRng is deterministic for identical seeds', () {
      final SeededRng rng1 = SeededRng(42);
      final SeededRng rng2 = SeededRng(42);

      for (int i = 0; i < 20; i++) {
        expect(rng1.nextUint32(), rng2.nextUint32());
      }
    });

    test('CableBalance scales grid size and detects breather levels', () {
      final CableBalance b4 = CableBalance.forLevel(4);
      final CableBalance b5 = CableBalance.forLevel(5);
      final CableBalance b15 = CableBalance.forLevel(15);
      final CableBalance b32 = CableBalance.forLevel(32);

      expect(b4.gridSize, 6);
      expect(b4.isBreather, isFalse);
      expect(b5.isBreather, isTrue);
      expect(b15.isBreather, isTrue);
      expect(b32.gridSize, 10);
    });

    test('generates identical level for same levelId and seed', () {
      final CableGenerator generator = CableGenerator();
      final CableLevel l1 = generator.generate(7, seed: 999);
      final CableLevel l2 = generator.generate(7, seed: 999);

      expect(l1.startPos, l2.startPos);
      expect(l1.endPos, l2.endPos);
      expect(l1.walls, l2.walls);
      expect(l1.components, l2.components);
      expect(l1.witnessPath, l2.witnessPath);
    });

    test('property test: 20 generated levels (4..23) are valid and solvable', () {
      final CableGenerator generator = CableGenerator();
      final CableSolver solver = CableSolver();

      for (int levelId = 4; levelId <= 23; levelId++) {
        final CableLevel level = generator.generate(levelId);

        expect(level.id, levelId);
        expect(level.components, isNotEmpty);
        expect(level.witnessPath, isNotNull);
        expect(
          PathRules.isCircuitComplete(level, level.witnessPath!),
          isTrue,
          reason: 'Generated level $levelId witness path must be complete',
        );
        expect(
          solver.isSolvable(level),
          isTrue,
          reason: 'Generated level $levelId must be verified solvable',
        );
      }
    });
  });
}
