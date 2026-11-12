import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/cable_connect/cable_levels.dart';
import 'package:voltar/pages/game/cable_connect/cable_models.dart';
import 'package:voltar/pages/game/cable_connect/cable_rules.dart';

void main() {
  group('PathRules & CableLevel', () {
    final CableLevel level = CableLevel.fromAscii(
      id: 99,
      grid: const <String>[
        '+.R',
        '.#.',
        '..-',
      ],
    );

    test('parses ASCII grid accurately', () {
      expect(level.width, 3);
      expect(level.height, 3);
      expect(level.startPos, const Pos(0, 0));
      expect(level.endPos, const Pos(2, 2));
      expect(level.walls, contains(const Pos(1, 1)));
      expect(level.components[const Pos(0, 2)], CellType.resistor);
    });

    test('allows valid orthogonal move and rejects diagonal or jump', () {
      final List<Pos> path = <Pos>[const Pos(0, 0)];

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(0, 1),
        ),
        MoveResult.valid,
      );

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(1, 1), // diagonal
        ),
        MoveResult.invalidOutOfBounds,
      );

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(0, 2), // jump
        ),
        MoveResult.invalidOutOfBounds,
      );
    });

    test('rejects wall and out-of-bounds moves', () {
      final List<Pos> path = <Pos>[const Pos(0, 0), const Pos(1, 0)];

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(1, 1), // wall
        ),
        MoveResult.invalidWall,
      );

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(1, -1), // out of bounds
        ),
        MoveResult.invalidOutOfBounds,
      );
    });

    test('supports retract to previous cell and rejects self-loop', () {
      final List<Pos> path = <Pos>[
        const Pos(0, 0),
        const Pos(0, 1),
        const Pos(0, 2),
        const Pos(1, 2),
      ];

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: const Pos(0, 2), // previous cell -> retract
        ),
        MoveResult.retract,
      );

      final CableLevel openLevel = CableLevel.fromAscii(
        id: 100,
        grid: const <String>[
          '+..',
          '...',
          '..-',
        ],
      );
      final List<Pos> loopPath = <Pos>[
        const Pos(0, 0),
        const Pos(0, 1),
        const Pos(1, 1),
        const Pos(1, 0),
      ];
      expect(
        PathRules.validateMove(
          level: openLevel,
          currentPath: loopPath,
          nextPos: const Pos(0, 0), // loop to start
        ),
        MoveResult.invalidLoop,
      );
    });

    test('prevents short circuit to (-) before visiting all components', () {
      // Path bypasses resistor at (0, 2)
      final List<Pos> bypassPath = <Pos>[
        const Pos(0, 0),
        const Pos(1, 0),
        const Pos(2, 0),
        const Pos(2, 1),
      ];

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: bypassPath,
          nextPos: const Pos(2, 2), // (-) terminal
        ),
        MoveResult.invalidPrematureEnd,
      );
    });

    test('completes circuit when all components visited and reaching (-)', () {
      final List<Pos> validPath = <Pos>[
        const Pos(0, 0),
        const Pos(0, 1),
        const Pos(0, 2), // Resistor visited!
        const Pos(1, 2),
      ];

      expect(
        PathRules.validateMove(
          level: level,
          currentPath: validPath,
          nextPos: const Pos(2, 2),
        ),
        MoveResult.complete,
      );
    });

    test('tutorial levels 1-3 have valid complete witness paths', () {
      for (final CableLevel tutorial in CableLevels.tutorials) {
        final List<Pos>? witness = tutorial.witnessPath;
        expect(witness, isNotNull, reason: 'Level ${tutorial.id} witness null');
        expect(
          PathRules.isCircuitComplete(tutorial, witness!),
          isTrue,
          reason: 'Level ${tutorial.id} witness not complete',
        );
      }
    });
  });
}
