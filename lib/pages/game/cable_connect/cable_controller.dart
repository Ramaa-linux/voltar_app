import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'cable_generator.dart';
import 'cable_levels.dart';
import 'cable_models.dart';
import 'cable_rules.dart';

enum CableGameStatus { playing, won, gameOver }

class CableConnectController extends ChangeNotifier {
  CableConnectController({
    CableGenerator? generator,
    int initialLevel = 1,
    this.initialSeconds = 60,
    bool autoStartTimer = true,
  }) : _generator = generator ?? CableGenerator(),
       _levelNumber = initialLevel,
       _secondsLeft = initialSeconds {
    _loadLevel(_levelNumber);
    if (autoStartTimer) startTimer();
  }

  final CableGenerator _generator;
  final int initialSeconds;
  late CableLevel _level;
  int _levelNumber;
  final List<Pos> _path = <Pos>[];
  CableGameStatus _status = CableGameStatus.playing;
  int _score = 0;
  int _streak = 0;
  int _secondsLeft;
  String? _feedback;
  Timer? _timer;
  bool _isPaused = false;

  CableLevel get level => _level;
  int get levelNumber => _levelNumber;
  List<Pos> get path => List<Pos>.unmodifiable(_path);
  CableGameStatus get status => _status;
  int get score => _score;
  int get streak => _streak;
  int get secondsLeft => _secondsLeft;
  String? get feedback => _feedback;
  bool get isTimerActive => _timer != null && _timer!.isActive;
  Set<Pos> get visitedComponents => PathRules.visitedComponents(_level, _path);
  bool get isComplete => _status == CableGameStatus.won;

  void _loadLevel(int number) {
    _level = number <= CableLevels.tutorials.length
        ? CableLevels.tutorials[number - 1]
        : _generator.generate(number);
    _path
      ..clear()
      ..add(_level.startPos);
    _status = CableGameStatus.playing;
    _feedback = _level.hint;
  }

  void startTimer() {
    _timer?.cancel();
    _isPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused && _status == CableGameStatus.playing) tickSecond();
    });
  }

  void pauseTimer() => _isPaused = true;
  void resumeTimer() => _isPaused = false;

  void tickSecond() {
    if (_status != CableGameStatus.playing) return;
    if (_secondsLeft > 0) {
      _secondsLeft--;
      if (_secondsLeft <= 0) {
        _secondsLeft = 0;
        _status = CableGameStatus.gameOver;
      }
      notifyListeners();
    }
  }

  MoveResult stepTo(Pos target) {
    if (_status != CableGameStatus.playing) {
      return MoveResult.invalidOutOfBounds;
    }
    if (_path.isEmpty) {
      if (target == _level.startPos) {
        _path.add(_level.startPos);
        notifyListeners();
        return MoveResult.valid;
      }
      return MoveResult.invalidOutOfBounds;
    }

    final MoveResult result = PathRules.validateMove(
      level: _level,
      currentPath: _path,
      nextPos: target,
    );

    switch (result) {
      case MoveResult.valid:
        _path.add(target);
        _feedback = _level.hint;
        notifyListeners();
        break;
      case MoveResult.retract:
        _path.removeLast();
        _feedback = _level.hint;
        notifyListeners();
        break;
      case MoveResult.complete:
        _path.add(target);
        _status = CableGameStatus.won;
        _streak++;
        _score += 100 + (_secondsLeft * 2) + (_streak * 10);
        _secondsLeft += 10;
        _feedback = 'Rangkaian tertutup sempurna!';
        notifyListeners();
        break;
      case MoveResult.invalidPrematureEnd:
        _feedback = 'Hubungkan semua Resistor & LED dulu sebelum ke (-)!';
        notifyListeners();
        break;
      case MoveResult.invalidWall:
      case MoveResult.invalidLoop:
      case MoveResult.invalidOutOfBounds:
        break;
    }
    return result;
  }

  void handleBoardPointer(Offset localPosition, Size boardSize) {
    if (_status != CableGameStatus.playing || boardSize.isEmpty) return;
    final double cellW = boardSize.width / _level.width;
    final double cellH = boardSize.height / _level.height;
    final int c = (localPosition.dx / cellW).floor();
    final int r = (localPosition.dy / cellH).floor();
    final Pos target = Pos(r, c);
    if (!_level.isInside(target)) return;

    if (_path.isEmpty) {
      stepTo(target);
      return;
    }

    final Pos head = _path.last;
    if (head == target) return;

    final int existingIdx = _path.indexOf(target);
    if (existingIdx != -1 && existingIdx < _path.length - 1) {
      _path.removeRange(existingIdx + 1, _path.length);
      notifyListeners();
      return;
    }

    final int dist = head.manhattanDistanceTo(target);
    if (dist == 1) {
      stepTo(target);
    } else if (dist <= 3) {
      _interpolateStepsTo(target);
    }
  }

  void _interpolateStepsTo(Pos target) {
    for (int step = 0; step < 3; step++) {
      if (_status != CableGameStatus.playing) break;
      final Pos head = _path.last;
      if (head == target) break;

      final int dr = target.r - head.r;
      final int dc = target.c - head.c;
      Pos? candidate;
      if (dr.abs() >= dc.abs() && dr != 0) {
        candidate = Pos(head.r + dr.sign, head.c);
      } else if (dc != 0) {
        candidate = Pos(head.r, head.c + dc.sign);
      }
      if (candidate == null) break;
      final MoveResult res = stepTo(candidate);
      if (res != MoveResult.valid && res != MoveResult.complete) break;
    }
  }

  void resetPath() {
    if (_status != CableGameStatus.playing) return;
    _path
      ..clear()
      ..add(_level.startPos);
    _feedback = _level.hint;
    notifyListeners();
  }

  void nextLevel() {
    _levelNumber++;
    _loadLevel(_levelNumber);
    notifyListeners();
  }

  void retryGame() {
    _secondsLeft = initialSeconds;
    _streak = 0;
    _loadLevel(_levelNumber);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
