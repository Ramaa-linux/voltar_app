import 'cable_models.dart';
import 'cable_rules.dart';

/// Solver DFS dengan pruning (floodfill reachability) untuk memastikan
/// level bisa diselesaikan dan menghasilkan jalur saksi (witness path).
class CableSolver {
  CableSolver({this.maxNodesExplored = 20000});

  /// Batas eksplorasi node agar deterministik dan cepat.
  final int maxNodesExplored;

  /// Menemukan satu solusi valid (jalur tertutup + semua komponen).
  /// Mengembalikan null jika tidak ditemukan dalam batas eksplorasi.
  List<Pos>? solve(CableLevel level) {
    final List<Pos> path = <Pos>[level.startPos];
    final Set<Pos> visitedComponents = <Pos>{};
    int nodesExplored = 0;

    List<Pos>? dfs(Pos current) {
      if (nodesExplored > maxNodesExplored) return null;
      nodesExplored++;

      if (PathRules.isCircuitComplete(level, path)) {
        return List<Pos>.from(path);
      }

      // Urutkan kandidat: heuristic Manhattan ke endPos + sisa komponen.
      final List<Pos> candidates = _orderedCandidates(level, current, path);

      for (final Pos next in candidates) {
        final MoveResult result = PathRules.validateMove(
          level: level,
          currentPath: path,
          nextPos: next,
        );
        if (result == MoveResult.invalidOutOfBounds ||
            result == MoveResult.invalidWall ||
            result == MoveResult.invalidLoop ||
            result == MoveResult.invalidPrematureEnd) {
          continue;
        }

        // Commit step.
        path.add(next);
        final bool addedComp = level.components.containsKey(next);
        if (addedComp) visitedComponents.add(next);

        // Pruning: cek reachability dari next ke endPos dan komponen tersisa.
        if (_isPromising(level, next, path, visitedComponents)) {
          final List<Pos>? found = dfs(next);
          if (found != null) return found;
        }

        // Backtrack.
        path.removeLast();
        if (addedComp) visitedComponents.remove(next);
      }
      return null;
    }

    return dfs(level.startPos);
  }

  /// Cepat mengecek apakah level *bisa* diselesaikan (boolean saja).
  bool isSolvable(CableLevel level) => solve(level) != null;

  List<Pos> _orderedCandidates(
    CableLevel level,
    Pos current,
    List<Pos> path,
  ) {
    final List<Pos> candidates = current.neighbors
        .where(level.isInside)
        .where((p) => !level.isWall(p))
        .where((p) => !path.contains(p))
        .toList();

    // Heuristic: prioritaskan arah ke endPos dan komponen belum dikunjungi.
    candidates.sort((a, b) {
      final int hA = _heuristic(level, a, path);
      final int hB = _heuristic(level, b, path);
      return hA.compareTo(hB);
    });
    return candidates;
  }

  int _heuristic(CableLevel level, Pos p, List<Pos> path) {
    // Jarak ke endPos.
    int h = p.manhattanDistanceTo(level.endPos);

    // Tambah penalti untuk komponen yang belum tercapai.
    for (final Pos comp in level.components.keys) {
      if (!path.contains(comp)) {
        h += p.manhattanDistanceTo(comp);
      }
    }
    return h;
  }

  /// Floodfill reachability: apakah endPos dan semua komponen tersisa
  /// masih terjangkau dari `pos` tanpa menyentuh dinding atau path.
  bool _isPromising(
    CableLevel level,
    Pos pos,
    List<Pos> path,
    Set<Pos> visitedComponents,
  ) {
    final Set<Pos> blocked = <Pos>{...level.walls, ...path};
    blocked.remove(pos); // current pos not blocked for BFS
    final Set<Pos> remainingComponents = level.components.keys.toSet()
      ..removeAll(visitedComponents);

    // Target nodes = endPos + remaining components.
    final List<Pos> targets = <Pos>[level.endPos, ...remainingComponents];

    // BFS dari pos.
    final Set<Pos> seen = <Pos>{pos};
    final List<Pos> queue = <Pos>[pos];
    int foundTargets = 0;

    while (queue.isNotEmpty) {
      final Pos cur = queue.removeAt(0);
      if (targets.contains(cur)) {
        foundTargets++;
        if (foundTargets == targets.length) return true;
      }
      for (final Pos nb in cur.neighbors) {
        if (level.isInside(nb) &&
            !blocked.contains(nb) &&
            seen.add(nb)) {
          queue.add(nb);
        }
      }
    }
    return false;
  }
}