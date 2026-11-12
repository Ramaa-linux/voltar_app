import 'dart:math' as math;
import 'cable_models.dart';
import 'cable_solver.dart';

/// PRNG deterministic 32-bit (xorshift32) agar level prosedural reproducible.
class SeededRng {
  SeededRng(int seed) : _state = seed == 0 ? 0x12345678 : seed & 0xFFFFFFFF;

  int _state;

  /// Menghasilkan integer 32-bit tak bertanda positif.
  int nextUint32() {
    int x = _state;
    x ^= (x << 13) & 0xFFFFFFFF;
    x ^= (x >> 17) & 0xFFFFFFFF;
    x ^= (x << 5) & 0xFFFFFFFF;
    _state = x & 0xFFFFFFFF;
    return _state;
  }

  /// Menghasilkan double di rentang [0.0, 1.0).
  double nextDouble() => (nextUint32() & 0x7FFFFFFF) / 0x80000000;

  /// Menghasilkan integer di rentang [min, max] inklusif.
  int nextIntRange(int min, int max) {
    if (min >= max) return min;
    return min + (nextUint32() % (max - min + 1));
  }

  /// Memilih elemen acak dari list.
  T pick<T>(List<T> list) => list[nextUint32() % list.length];
}

/// Konfigurasi keseimbangan level prosedural berdasarkan tingkat kesulitan.
class CableBalance {
  const CableBalance({
    required this.gridSize,
    required this.minPathLength,
    required this.resistorCount,
    required this.ledCount,
    required this.wallCount,
    required this.isBreather,
  });

  final int gridSize;
  final int minPathLength;
  final int resistorCount;
  final int ledCount;
  final int wallCount;
  final bool isBreather;

  factory CableBalance.forLevel(int level) {
    final bool isBreather = level > 3 && (level % 5 == 0);

    // Skala ukuran grid.
    final int gridSize = switch (level) {
      <= 6 => 6,
      <= 12 => 7,
      <= 20 => 8,
      <= 30 => 9,
      _ => 10,
    };

    // Jumlah komponen beban.
    final int resistorCount = isBreather
        ? 1
        : switch (level) {
            < 10 => 1,
            < 22 => 2,
            _ => 3,
          };

    final int ledCount = isBreather
        ? 1
        : switch (level) {
            < 8 => 1,
            < 18 => 2,
            _ => 3,
          };

    // Target panjang jalur kabel minimum.
    final int baseMinLength = gridSize * 2 + (level ~/ 4) * 2;
    final int minPathLength = isBreather
        ? (baseMinLength * 0.75).round()
        : math.min(baseMinLength, (gridSize * gridSize * 0.45).round());

    // Jumlah dinding hambatan.
    final int maxWalls = (gridSize * gridSize * 0.18).round();
    final int wallCount = isBreather
        ? (maxWalls * 0.4).round()
        : math.min(maxWalls, 3 + (level ~/ 3));

    return CableBalance(
      gridSize: gridSize,
      minPathLength: minPathLength,
      resistorCount: resistorCount,
      ledCount: ledCount,
      wallCount: wallCount,
      isBreather: isBreather,
    );
  }
}

/// Generator level prosedural dengan witness path dan jaminan solvabilitas.
class CableGenerator {
  CableGenerator({CableSolver? solver}) : _solver = solver ?? CableSolver();

  final CableSolver _solver;

  /// Menghasilkan level prosedural deterministik untuk level id tertentu.
  CableLevel generate(int levelId, {int? seed}) {
    final int effectiveSeed = seed ?? (levelId * 1337 + 0xACE1);
    final SeededRng rng = SeededRng(effectiveSeed);
    final CableBalance balance = CableBalance.forLevel(levelId);

    for (int attempt = 0; attempt < 20; attempt++) {
      final CableLevel? candidate = _tryGenerateCandidate(
        levelId: levelId,
        rng: rng,
        balance: balance,
      );
      if (candidate != null && _solver.isSolvable(candidate)) {
        return candidate;
      }
    }

    // ponytail: fallback snake walk 0 dinding menjamin puzzle tidak pernah macet.
    return _generateSafeFallback(levelId, rng, balance);
  }

  CableLevel? _tryGenerateCandidate({
    required int levelId,
    required SeededRng rng,
    required CableBalance balance,
  }) {
    final int size = balance.gridSize;
    final Pos start = Pos(
      rng.nextIntRange(0, 1) == 0 ? 0 : size - 1,
      rng.nextIntRange(0, size - 1),
    );

    final List<Pos>? path = _generateSelfAvoidingWalk(
      start: start,
      size: size,
      targetLength: balance.minPathLength,
      rng: rng,
    );

    if (path == null || path.length < balance.minPathLength) {
      return null;
    }

    final Pos end = path.last;
    final Set<Pos> pathSet = path.toSet();
    final int totalComponents = balance.resistorCount + balance.ledCount;
    if (path.length - 2 < totalComponents) return null;

    final Map<Pos, CellType> components = <Pos, CellType>{};
    final List<int> availableIndices = <int>[
      for (int i = 1; i < path.length - 1; i++) i,
    ];

    final double step = availableIndices.length / (totalComponents + 1);
    final List<int> chosenIndices = <int>[];
    for (int i = 1; i <= totalComponents; i++) {
      final int baseIdx = (i * step).round().clamp(1, path.length - 2);
      if (!chosenIndices.contains(baseIdx)) chosenIndices.add(baseIdx);
    }
    for (final int idx in availableIndices) {
      if (chosenIndices.length == totalComponents) break;
      if (!chosenIndices.contains(idx)) chosenIndices.add(idx);
    }

    int compCount = 0;
    for (final int idx in chosenIndices) {
      final Pos p = path[idx];
      components[p] = compCount < balance.resistorCount
          ? CellType.resistor
          : CellType.led;
      compCount++;
    }

    final List<Pos> wallCandidates = <Pos>[];
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        final Pos p = Pos(r, c);
        if (!pathSet.contains(p)) wallCandidates.add(p);
      }
    }

    final Set<Pos> walls = <Pos>{};
    final int wallsToPlace = math.min(balance.wallCount, wallCandidates.length);
    for (int i = 0; i < wallsToPlace; i++) {
      if (wallCandidates.isEmpty) break;
      final int pickIdx = rng.nextIntRange(0, wallCandidates.length - 1);
      walls.add(wallCandidates.removeAt(pickIdx));
    }

    return CableLevel(
      id: levelId,
      width: size,
      height: size,
      startPos: start,
      endPos: end,
      walls: walls,
      components: components,
      targetSteps: path.length,
      witnessPath: path,
      hint: balance.isBreather ? 'Level santai! Susun jalur yang pas.' : null,
    );
  }

  List<Pos>? _generateSelfAvoidingWalk({
    required Pos start,
    required int size,
    required int targetLength,
    required SeededRng rng,
  }) {
    for (int walkAttempt = 0; walkAttempt < 15; walkAttempt++) {
      final List<Pos> walk = <Pos>[start];
      final Set<Pos> visited = <Pos>{start};
      Pos cur = start;

      while (walk.length < targetLength) {
        final List<Pos> neighbors = cur.neighbors
            .where((p) => p.r >= 0 && p.r < size && p.c >= 0 && p.c < size)
            .where((p) => !visited.contains(p))
            .toList();

        if (neighbors.isEmpty) break;
        final Pos next = rng.pick(neighbors);
        walk.add(next);
        visited.add(next);
        cur = next;
      }

      if (walk.length >= targetLength) return walk;
    }
    return null;
  }

  CableLevel _generateSafeFallback(
    int levelId,
    SeededRng rng,
    CableBalance balance,
  ) {
    final int size = balance.gridSize;
    final List<Pos> path = <Pos>[];

    for (int r = 0; r < size; r++) {
      if (r.isEven) {
        for (int c = 0; c < size; c++) {
          path.add(Pos(r, c));
        }
      } else {
        for (int c = size - 1; c >= 0; c--) {
          path.add(Pos(r, c));
        }
      }
    }

    final Pos start = path.first;
    final Pos end = path.last;
    final Map<Pos, CellType> components = <Pos, CellType>{};
    final int totalComponents = balance.resistorCount + balance.ledCount;
    final int step = path.length ~/ (totalComponents + 1);

    for (int i = 1; i <= totalComponents; i++) {
      final Pos p = path[i * step];
      components[p] = i <= balance.resistorCount
          ? CellType.resistor
          : CellType.led;
    }

    return CableLevel(
      id: levelId,
      width: size,
      height: size,
      startPos: start,
      endPos: end,
      walls: <Pos>{},
      components: components,
      targetSteps: path.length,
      witnessPath: path,
    );
  }
}

