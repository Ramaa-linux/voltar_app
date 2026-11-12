import 'dart:math' as math;
import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';
import 'package:voltar/pages/game/circuit_rush/circuit_rush_config.dart';

/// Status siklus permainan Sirkuit Kilat.
enum CircuitRushStatus { ready, playing, paused, gameOver }

/// Jenis visual rintangan elektronika.
enum ObstacleKind { resistor, capacitor }

/// Satu gerbang rintangan vertikal dengan celah di tengah dan koin opsional.
class CircuitObstacle {
  CircuitObstacle({
    required this.x,
    required this.gapCenterY,
    required this.gapHeight,
    required this.kind,
    this.passed = false,
    this.hasCoin = true,
    this.coinCollected = false,
  });

  double x;
  final double gapCenterY;
  final double gapHeight;
  final ObstacleKind kind;
  bool passed;
  final bool hasCoin;
  bool coinCollected;

  double get topBottomY => gapCenterY - gapHeight / 2;
  double get bottomTopY => gapCenterY + gapHeight / 2;
  double get centerX => x + CircuitRushConfig.obstacleWidth / 2;
}

/// Mesin fisika, rintangan, tabrakan, dan skor untuk mini-game Sirkuit Kilat.
class CircuitRushEngine extends ChangeNotifier {
  CircuitRushEngine({math.Random? random}) : _random = random ?? math.Random();

  final math.Random _random;

  CircuitRushStatus _status = CircuitRushStatus.ready;
  CircuitRushStatus get status => _status;

  double _viewportWidth = 390.0;
  double _viewportHeight = 844.0;
  double get viewportWidth => _viewportWidth;
  double get viewportHeight => _viewportHeight;

  double _playerY = 422.0;
  double get playerY => _playerY;

  double _playerVy = 0.0;
  double get playerVy => _playerVy;

  double get playerX => _viewportWidth * CircuitRushConfig.playerXRatio;

  int _score = 0;
  int get score => _score;

  int _highScore = 0;
  int get highScore => _highScore;

  int _coinsCollected = 0;
  int get coinsCollected => _coinsCollected;

  double _elapsedTime = 0.0;
  double get elapsedTime => _elapsedTime;

  final List<CircuitObstacle> _obstacles = <CircuitObstacle>[];
  List<CircuitObstacle> get obstacles =>
      List<CircuitObstacle>.unmodifiable(_obstacles);

  final List<Offset> _trail = <Offset>[];
  List<Offset> get trail => List<Offset>.unmodifiable(_trail);

  double? _lastGapCenterY;

  @visibleForTesting
  double? get lastGapCenterY => _lastGapCenterY;

  double get currentScrollSpeed => math.min(
    CircuitRushConfig.maxScrollSpeed,
    CircuitRushConfig.initialScrollSpeed +
        _score * CircuitRushConfig.speedPerScore,
  );

  /// Jarak horizontal antar rintangan berdasarkan lebar layar dan kecepatan.
  double get currentObstacleSpacing {
    final double ratio = math.max(
      CircuitRushConfig.minObstacleSpacingRatio,
      CircuitRushConfig.initialObstacleSpacingRatio -
          _score * CircuitRushConfig.obstacleSpacingShrinkPerScore,
    );
    final double ratioSpacing = ratio * _viewportWidth;
    final double minTimeSpacing =
        currentScrollSpeed * CircuitRushConfig.minObstacleTravelTime;
    return math.max(ratioSpacing, minTimeSpacing);
  }

  /// Menghitung perubahan vertikal maksimum yang diizinkan antar dua celah
  /// berurutan berdasarkan batas desain dan fisika waktu tempuh.
  double computeMaxDeltaY({
    double? spacing,
    double? speed,
    double? viewportHeight,
  }) {
    final double effectiveSpacing = spacing ?? currentObstacleSpacing;
    final double effectiveSpeed = math.max(1.0, speed ?? currentScrollSpeed);
    final double effectiveHeight = viewportHeight ?? _viewportHeight;
    final double cleanDistance = math.max(
      10.0,
      effectiveSpacing - CircuitRushConfig.obstacleWidth,
    );
    final double travelTime = cleanDistance / effectiveSpeed;
    // ponytail: estimasi jarak jatuh/naik maksimum linier terhadap maxFallSpeed; upgrade ke integrasi kinematika penuh bila kurva gravitasi diubah.
    final double physicsLimit =
        CircuitRushConfig.maxFallSpeed *
        travelTime *
        CircuitRushConfig.physicsDeltaSafetyFactor;
    final double designLimit =
        CircuitRushConfig.maxGapDeltaHeightRatio * effectiveHeight;
    return math.max(24.0, math.min(designLimit, physicsLimit));
  }

  void setViewport(double width, double height) {
    if (width <= 0 || height <= 0) return;
    final bool changed =
        (_viewportWidth - width).abs() > 0.5 ||
        (_viewportHeight - height).abs() > 0.5;
    _viewportWidth = width;
    _viewportHeight = height;
    if (_status == CircuitRushStatus.ready) {
      _playerY = height * 0.5;
    }
    if (changed) notifyListeners();
  }

  void reset({bool startImmediately = false}) {
    _status = startImmediately
        ? CircuitRushStatus.playing
        : CircuitRushStatus.ready;
    _playerY = _viewportHeight * 0.5;
    _playerVy = startImmediately ? CircuitRushConfig.tapImpulse : 0.0;
    _score = 0;
    _coinsCollected = 0;
    _elapsedTime = 0.0;
    _lastGapCenterY = null;
    _obstacles.clear();
    _trail.clear();
    if (startImmediately) _seedInitialObstacles();
    notifyListeners();
  }

  void tap() {
    if (_status == CircuitRushStatus.ready) {
      _status = CircuitRushStatus.playing;
      _playerVy = CircuitRushConfig.tapImpulse;
      _seedInitialObstacles();
      notifyListeners();
      return;
    }
    if (_status == CircuitRushStatus.playing) {
      _playerVy = CircuitRushConfig.tapImpulse;
      notifyListeners();
    }
  }

  void pause() {
    if (_status == CircuitRushStatus.playing) {
      _status = CircuitRushStatus.paused;
      notifyListeners();
    }
  }

  void resume() {
    if (_status == CircuitRushStatus.paused) {
      _status = CircuitRushStatus.playing;
      notifyListeners();
    }
  }

  void update(double dt) {
    if (!dt.isFinite || dt <= 0) return;
    final double clampedDt = math.min(dt, CircuitRushConfig.maxDeltaTime);
    _elapsedTime += clampedDt;

    if (_status == CircuitRushStatus.ready) {
      _playerY = (_viewportHeight * 0.5) + math.sin(_elapsedTime * 3.5) * 8.0;
      notifyListeners();
      return;
    }

    if (_status != CircuitRushStatus.playing) return;

    _playerVy = math.min(
      CircuitRushConfig.maxFallSpeed,
      _playerVy + CircuitRushConfig.gravity * clampedDt,
    );
    _playerY += _playerVy * clampedDt;

    final double speed = currentScrollSpeed;
    for (int i = 0; i < _trail.length; i++) {
      _trail[i] = Offset(_trail[i].dx - speed * clampedDt, _trail[i].dy);
    }
    _trail.insert(0, Offset(playerX, _playerY));
    if (_trail.length > CircuitRushConfig.maxTrailPoints) {
      _trail.removeRange(CircuitRushConfig.maxTrailPoints, _trail.length);
    }

    const double r = CircuitRushConfig.playerRadius;
    if (_playerY - r <= 0 || _playerY + r >= _viewportHeight) {
      _playerY = _playerY.clamp(r, _viewportHeight - r);
      _triggerGameOver();
      return;
    }

    final double px = playerX;
    for (final CircuitObstacle obs in _obstacles) {
      obs.x -= speed * clampedDt;

      if (obs.hasCoin && !obs.coinCollected) {
        final double dx = px - obs.centerX;
        final double dy = _playerY - obs.gapCenterY;
        const double hitDist =
            CircuitRushConfig.playerRadius + CircuitRushConfig.coinRadius;
        if (dx * dx + dy * dy <= hitDist * hitDist) {
          obs.coinCollected = true;
          _coinsCollected += 1;
          _addScore(CircuitRushConfig.coinBonusScore);
        }
      }

      if (!obs.passed && obs.x + CircuitRushConfig.obstacleWidth < px - r) {
        obs.passed = true;
        _addScore(1);
      }

      if (_collidesWithObstacle(px, _playerY, r, obs)) {
        _triggerGameOver();
        return;
      }
    }

    _obstacles.removeWhere(
      (CircuitObstacle obs) => obs.x + CircuitRushConfig.obstacleWidth < -40,
    );
    _ensureObstacles();

    notifyListeners();
  }

  @visibleForTesting
  void debugSetObstacles(List<CircuitObstacle> obstacles) {
    _obstacles
      ..clear()
      ..addAll(obstacles);
    notifyListeners();
  }

  @visibleForTesting
  void debugSetPlayerState({required double y, double vy = 0.0}) {
    _playerY = y;
    _playerVy = vy;
    notifyListeners();
  }

  void _addScore(int delta) {
    _score += delta;
    if (_score > _highScore) _highScore = _score;
  }

  void _triggerGameOver() {
    _status = CircuitRushStatus.gameOver;
    if (_score > _highScore) _highScore = _score;
    notifyListeners();
  }

  bool _collidesWithObstacle(
    double cx,
    double cy,
    double radius,
    CircuitObstacle obs,
  ) {
    final double effectiveRadius = math.max(2.0, radius - 2.0);
    final double left = obs.x;
    final double right = obs.x + CircuitRushConfig.obstacleWidth;

    if (_circleIntersectsRect(
      cx,
      cy,
      effectiveRadius,
      left,
      0,
      right,
      obs.topBottomY,
    )) {
      return true;
    }

    if (_circleIntersectsRect(
      cx,
      cy,
      effectiveRadius,
      left,
      obs.bottomTopY,
      right,
      _viewportHeight,
    )) {
      return true;
    }

    return false;
  }

  static bool _circleIntersectsRect(
    double cx,
    double cy,
    double r,
    double left,
    double top,
    double right,
    double bottom,
  ) {
    if (bottom <= top || right <= left) return false;
    final double closestX = cx.clamp(left, right);
    final double closestY = cy.clamp(top, bottom);
    final double dx = cx - closestX;
    final double dy = cy - closestY;
    return (dx * dx + dy * dy) < (r * r);
  }

  void _seedInitialObstacles() {
    _obstacles.clear();
    _lastGapCenterY = null;
    final double firstX =
        playerX + _viewportWidth * CircuitRushConfig.firstObstacleOffsetRatio;
    final double spacing = currentObstacleSpacing;
    for (int i = 0; i < 3; i++) {
      final double x = i == 0 ? firstX : _obstacles.last.x + spacing;
      _obstacles.add(_createObstacleAt(x, i));
    }
  }

  void _ensureObstacles() {
    while (_obstacles.length < 4) {
      final double spacing = currentObstacleSpacing;
      final double nextX = _obstacles.isEmpty
          ? playerX +
                _viewportWidth * CircuitRushConfig.firstObstacleOffsetRatio
          : _obstacles.last.x + spacing;
      _obstacles.add(
        _createObstacleAt(nextX, _obstacles.length + _score),
      );
    }
  }

  CircuitObstacle _createObstacleAt(double x, int seedIndex) {
    final double gapHeight = math.max(
      CircuitRushConfig.minGapHeight,
      CircuitRushConfig.initialGapHeight -
          _score * CircuitRushConfig.gapShrinkPerScore,
    );
    final double verticalMargin = math.max(
      CircuitRushConfig.minGapVerticalMargin,
      CircuitRushConfig.gapVerticalMarginRatio * _viewportHeight,
    );
    final double minCenter = verticalMargin + gapHeight / 2;
    final double maxCenter = _viewportHeight - verticalMargin - gapHeight / 2;

    final double centerY;
    if (maxCenter <= minCenter) {
      centerY = _viewportHeight * 0.5;
    } else if (_lastGapCenterY == null) {
      centerY = minCenter + _random.nextDouble() * (maxCenter - minCenter);
    } else {
      final double maxDelta = computeMaxDeltaY();
      final double low = math.max(minCenter, _lastGapCenterY! - maxDelta);
      final double high = math.min(maxCenter, _lastGapCenterY! + maxDelta);
      centerY = high > low
          ? low + _random.nextDouble() * (high - low)
          : (low + high) * 0.5;
    }
    _lastGapCenterY = centerY;

    final ObstacleKind kind = seedIndex.isEven
        ? ObstacleKind.resistor
        : ObstacleKind.capacitor;

    return CircuitObstacle(
      x: x,
      gapCenterY: centerY,
      gapHeight: gapHeight,
      kind: kind,
      hasCoin: _random.nextDouble() < 0.65,
    );
  }
}
