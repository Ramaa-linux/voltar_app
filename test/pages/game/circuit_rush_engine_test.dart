import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_config.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_engine.dart';

void main() {
  late CircuitRushEngine engine;

  setUp(() {
    engine = CircuitRushEngine(random: math.Random(42));
    engine.setViewport(390, 844);
  });

  tearDown(() => engine.dispose());

  group('CircuitRushEngine lifecycle', () {
    test('starts in ready status', () {
      expect(engine.status, CircuitRushStatus.ready);
      expect(engine.score, 0);
      expect(engine.obstacles, isEmpty);
    });

    test('tap transitions from ready to playing and spawns obstacles', () {
      engine.tap();
      expect(engine.status, CircuitRushStatus.playing);
      expect(engine.obstacles.length, 3);
      expect(engine.playerVy, CircuitRushConfig.tapImpulse);
    });

    test('tap during playing applies impulse', () {
      engine.tap();
      engine.update(0.016);
      final double vyBefore = engine.playerVy;
      engine.tap();
      expect(engine.playerVy, CircuitRushConfig.tapImpulse);
      expect(engine.playerVy, isNot(vyBefore));
    });

    test('pause and resume work', () {
      engine.tap();
      engine.pause();
      expect(engine.status, CircuitRushStatus.paused);
      engine.resume();
      expect(engine.status, CircuitRushStatus.playing);
    });

    test('pause ignored when not playing', () {
      engine.pause();
      expect(engine.status, CircuitRushStatus.ready);
    });

    test('reset clears state', () {
      engine.tap();
      engine.update(0.1);
      engine.reset();
      expect(engine.status, CircuitRushStatus.ready);
      expect(engine.score, 0);
      expect(engine.obstacles, isEmpty);
      expect(engine.trail, isEmpty);
    });

    test('reset with startImmediately goes to playing', () {
      engine.reset(startImmediately: true);
      expect(engine.status, CircuitRushStatus.playing);
      expect(engine.obstacles.length, 3);
    });
  });

  group('CircuitRushEngine physics', () {
    test('gravity increases playerVy over time', () {
      engine.tap();
      final double initialVy = engine.playerVy;
      engine.update(0.1);
      expect(engine.playerVy, greaterThan(initialVy));
    });

    test('playerY moves down with positive vy', () {
      engine.tap();
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 400, vy: 200);
      final double yBefore = engine.playerY;
      engine.update(0.016);
      expect(engine.playerY, greaterThan(yBefore));
    });

    test('playerVy clamped to maxFallSpeed', () {
      engine.tap();
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 300, vy: 600);
      engine.update(0.1);
      expect(engine.playerVy, lessThanOrEqualTo(CircuitRushConfig.maxFallSpeed));
    });

    test('invalid dt ignored', () {
      engine.tap();
      final double yBefore = engine.playerY;
      engine.update(0);
      engine.update(-1);
      engine.update(double.nan);
      engine.update(double.infinity);
      expect(engine.playerY, yBefore);
    });

    test('trail grows during play', () {
      engine.tap();
      engine.update(0.016);
      engine.update(0.016);
      engine.update(0.016);
      expect(engine.trail.length, greaterThan(0));
      expect(engine.trail.length, lessThanOrEqualTo(CircuitRushConfig.maxTrailPoints));
    });

    test('ready state floats player without obstacles', () {
      engine.update(0.5);
      expect(engine.playerY, isNot(422.0));
      expect(engine.status, CircuitRushStatus.ready);
    });
  });

  group('CircuitRushEngine collision', () {
    test('hitting floor triggers gameOver', () {
      engine.tap();
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 843, vy: 100);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[]);
      engine.update(0.016);
      expect(engine.status, CircuitRushStatus.gameOver);
    });

    test('hitting ceiling triggers gameOver', () {
      engine.tap();
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 1, vy: -500);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[]);
      engine.update(0.016);
      expect(engine.status, CircuitRushStatus.gameOver);
    });

    test('colliding with obstacle triggers gameOver', () {
      engine.tap();
      final double px = engine.playerX;
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[
        CircuitObstacle(
          x: px - CircuitRushConfig.obstacleWidth / 2,
          gapCenterY: 100,
          gapHeight: 40,
          kind: ObstacleKind.resistor,
          hasCoin: false,
        ),
      ]);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 422, vy: 0);
      engine.update(0.016);
      expect(engine.status, CircuitRushStatus.gameOver);
    });

    test('passing through gap does not trigger gameOver', () {
      engine.tap();
      final double px = engine.playerX;
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[
        CircuitObstacle(
          x: px - CircuitRushConfig.obstacleWidth / 2,
          gapCenterY: 422,
          gapHeight: CircuitRushConfig.initialGapHeight,
          kind: ObstacleKind.resistor,
          hasCoin: false,
        ),
      ]);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 422, vy: 0);
      engine.update(0.016);
      expect(engine.status, CircuitRushStatus.playing);
    });
  });

  group('CircuitRushEngine scoring', () {
    test('passing obstacle increments score', () {
      engine.tap();
      final double px = engine.playerX;
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[
        CircuitObstacle(
          x: px - CircuitRushConfig.obstacleWidth - CircuitRushConfig.playerRadius - 10,
          gapCenterY: 422,
          gapHeight: CircuitRushConfig.initialGapHeight,
          kind: ObstacleKind.resistor,
          hasCoin: false,
        ),
      ]);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 422, vy: 0);
      engine.update(0.016);
      expect(engine.score, 1);
    });

    test('collecting coin adds bonus score', () {
      engine.tap();
      final double px = engine.playerX;
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[
        CircuitObstacle(
          x: px - CircuitRushConfig.obstacleWidth / 2,
          gapCenterY: 422,
          gapHeight: CircuitRushConfig.initialGapHeight,
          kind: ObstacleKind.resistor,
          hasCoin: true,
        ),
      ]);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 422, vy: 0);
      engine.update(0.016);
      expect(engine.coinsCollected, 1);
      expect(engine.score, CircuitRushConfig.coinBonusScore);
    });

    test('highScore tracks maximum', () {
      engine.tap();
      final double px = engine.playerX;
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetObstacles(<CircuitObstacle>[
        CircuitObstacle(
          x: px - CircuitRushConfig.obstacleWidth - CircuitRushConfig.playerRadius - 10,
          gapCenterY: 422,
          gapHeight: CircuitRushConfig.initialGapHeight,
          kind: ObstacleKind.resistor,
          hasCoin: false,
        ),
      ]);
      // ignore: invalid_use_of_visible_for_testing_member
      engine.debugSetPlayerState(y: 422, vy: 0);
      engine.update(0.016);
      expect(engine.highScore, 1);
      engine.reset();
      expect(engine.highScore, 1);
      expect(engine.score, 0);
    });

    test('scrollSpeed increases with score', () {
      final double baseSpeed = engine.currentScrollSpeed;
      engine.tap();
      final double px = engine.playerX;
      for (int i = 0; i < 5; i++) {
        // ignore: invalid_use_of_visible_for_testing_member
        engine.debugSetObstacles(<CircuitObstacle>[
          CircuitObstacle(
            x: px - CircuitRushConfig.obstacleWidth - CircuitRushConfig.playerRadius - 10,
            gapCenterY: 422,
            gapHeight: CircuitRushConfig.initialGapHeight,
            kind: ObstacleKind.resistor,
            hasCoin: false,
          ),
        ]);
        // ignore: invalid_use_of_visible_for_testing_member
        engine.debugSetPlayerState(y: 422, vy: 0);
        engine.update(0.016);
      }
      expect(engine.currentScrollSpeed, greaterThan(baseSpeed));
    });
  });

  group('CircuitRushEngine viewport', () {
    test('setViewport ignores invalid dimensions', () {
      engine.setViewport(0, 0);
      expect(engine.viewportWidth, 390);
      engine.setViewport(-1, 100);
      expect(engine.viewportWidth, 390);
    });

    test('setViewport adjusts playerY in ready state', () {
      engine.setViewport(400, 600);
      expect(engine.playerY, closeTo(300, 1));
    });
  });

  group('CircuitRushEngine Fase 14D spacing & smooth Y', () {
    test('initial spawn uses playerX + 1.0*W and 1.15*W spacing', () {
      engine.setViewport(400, 800);
      engine.tap();
      final List<CircuitObstacle> obs = engine.obstacles;
      expect(obs.length, 3);
      expect(obs[0].x, closeTo(engine.playerX + 400.0, 1e-6));
      expect(obs[1].x - obs[0].x, closeTo(400.0 * 1.15, 1e-6));
      expect(obs[2].x - obs[1].x, closeTo(400.0 * 1.15, 1e-6));
    });

    test('reset clears lastGapCenterY', () {
      engine.tap();
      // ignore: invalid_use_of_visible_for_testing_member
      expect(engine.lastGapCenterY, isNotNull);
      engine.reset();
      // ignore: invalid_use_of_visible_for_testing_member
      expect(engine.lastGapCenterY, isNull);
    });

    test('1000+ spawns obey spacing, travel time, margin, maxDeltaY', () {
      final CircuitRushEngine sim = CircuitRushEngine(random: math.Random(12345));
      addTearDown(sim.dispose);
      const double w = 390.0;
      const double h = 844.0;
      sim.setViewport(w, h);
      sim.tap();

      int totalSpawned = sim.obstacles.length;
      CircuitObstacle prev = sim.obstacles.first;
      for (int i = 1; i < sim.obstacles.length; i++) {
        final CircuitObstacle curr = sim.obstacles[i];
        expect(curr.x - prev.x,
            greaterThanOrEqualTo(w * CircuitRushConfig.minObstacleSpacingRatio - 1e-4));
        expect((curr.gapCenterY - prev.gapCenterY).abs(),
            lessThanOrEqualTo(sim.computeMaxDeltaY() + 1e-4));
        prev = curr;
      }

      CircuitObstacle lastKnown = sim.obstacles.last;
      while (totalSpawned < 1050) {
        final double maxD = sim.computeMaxDeltaY();
        for (final CircuitObstacle o in sim.obstacles) {
          o.x -= sim.currentScrollSpeed * 0.04;
        }
        // ignore: invalid_use_of_visible_for_testing_member
        sim.debugSetPlayerState(y: sim.obstacles.first.gapCenterY, vy: 0);
        sim.update(0.016);
        for (final CircuitObstacle c in sim.obstacles) {
          if (c.x > lastKnown.x + 1.0) {
            final double spacing = c.x - lastKnown.x;
            expect(spacing,
                greaterThanOrEqualTo(w * CircuitRushConfig.minObstacleSpacingRatio - 1e-3));
            expect(spacing / sim.currentScrollSpeed,
                greaterThanOrEqualTo(CircuitRushConfig.minObstacleTravelTime - 1e-3));
            final double margin = math.max(50.0, 0.08 * h);
            expect(c.gapCenterY,
                inInclusiveRange(margin + c.gapHeight / 2 - 1e-3,
                    h - margin - c.gapHeight / 2 + 1e-3));
            expect((c.gapCenterY - lastKnown.gapCenterY).abs(),
                lessThanOrEqualTo(math.max(maxD, sim.computeMaxDeltaY()) + 1e-3));
            lastKnown = c;
            totalSpawned += 1;
          }
        }
        lastKnown = sim.obstacles.last;
      }
      expect(totalSpawned, greaterThanOrEqualTo(1000));
    });

    test('Bot pemain dengan cooldown >= 0.2s mampu melewati >= 500 rintangan di berbagai seed', () {
      for (final int seed in <int>[1, 7, 42]) {
        final CircuitRushEngine bot = CircuitRushEngine(
          random: math.Random(seed),
        );
        const double w = 390.0;
        const double h = 844.0;
        bot.setViewport(w, h);
        bot.tap();

        const double dt = 0.016;
        const double tapCooldown = 0.20;
        double timeSinceLastTap = tapCooldown;
        int totalPassed = 0;
        int maxSteps = 400000;

        while (totalPassed < 500 &&
            bot.status == CircuitRushStatus.playing &&
            maxSteps > 0) {
          maxSteps--;
          timeSinceLastTap += dt;

          CircuitObstacle? nextObs;
          final double px = bot.playerX;
          for (final CircuitObstacle obs in bot.obstacles) {
            if (obs.x + CircuitRushConfig.obstacleWidth >=
                px - CircuitRushConfig.playerRadius) {
              nextObs = obs;
              break;
            }
          }

          final double targetY = nextObs?.gapCenterY ?? (h * 0.5);
          final double jumpHeight =
              (CircuitRushConfig.tapImpulse * CircuitRushConfig.tapImpulse) /
              (2 * CircuitRushConfig.gravity); // ~65.6 px
          final double safeTop = nextObs != null
              ? (nextObs.topBottomY + CircuitRushConfig.playerRadius + 8.0)
              : 40.0;
          final double safeBottom = nextObs != null
              ? (nextObs.bottomTopY - CircuitRushConfig.playerRadius - 8.0)
              : (h - 40.0);

          final double predictedY = bot.playerY + bot.playerVy * 0.04;
          final bool canSafelyJump = (bot.playerY - jumpHeight) >= safeTop;
          final bool needsJump =
              (predictedY >= targetY + 20.0 || predictedY >= safeBottom - 16.0);

          if (timeSinceLastTap >= tapCooldown && canSafelyJump && needsJump) {
            bot.tap();
            timeSinceLastTap = 0.0;
          }

          final int passedBefore =
              bot.obstacles.where((CircuitObstacle o) => o.passed).length;
          bot.update(dt);
          if (bot.status == CircuitRushStatus.gameOver) {
            // ignore: avoid_print
            print('DIED at passed=$totalPassed, playerY=${bot.playerY}, vy=${bot.playerVy}, nextObs: x=${nextObs?.x}, top=${nextObs?.topBottomY}, bot=${nextObs?.bottomTopY}, gapCenter=${nextObs?.gapCenterY}, gapH=${nextObs?.gapHeight}');
            break;
          }
          final int passedAfter =
              bot.obstacles.where((CircuitObstacle o) => o.passed).length;
          if (passedAfter > passedBefore) {
            totalPassed += passedAfter - passedBefore;
          }
        }

        expect(
          bot.status,
          CircuitRushStatus.playing,
          reason: 'Bot mati pada seed $seed (passed: $totalPassed)',
        );
        expect(totalPassed, greaterThanOrEqualTo(500));
        bot.dispose();
      }
    });
  });
}
