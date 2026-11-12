import 'cable_models.dart';

/// Aturan logika sambungan jalur kabel fisika rangkaian tertutup.
abstract final class PathRules {
  /// Memeriksa apakah semua komponen beban (resistor, led) sudah dilalui jalur.
  static bool areAllComponentsVisited(CableLevel level, Iterable<Pos> path) {
    if (level.components.isEmpty) return true;
    final Set<Pos> pathSet = path.toSet();
    for (final Pos compPos in level.components.keys) {
      if (!pathSet.contains(compPos)) return false;
    }
    return true;
  }

  /// Menghitung komponen yang sudah dilalui.
  static Set<Pos> visitedComponents(CableLevel level, Iterable<Pos> path) {
    final Set<Pos> pathSet = path.toSet();
    return level.components.keys.where(pathSet.contains).toSet();
  }

  /// Mengecek apakah rangkaian sudah tertutup sempurna dari (+) ke (-)
  /// dan seluruh komponen beban terpasang.
  static bool isCircuitComplete(CableLevel level, List<Pos> path) {
    if (path.isEmpty) return false;
    if (path.first != level.startPos) return false;
    if (path.last != level.endPos) return false;
    return areAllComponentsVisited(level, path);
  }

  /// Memvalidasi langkah berikutnya dari ujung kabel aktif.
  static MoveResult validateMove({
    required CableLevel level,
    required List<Pos> currentPath,
    required Pos nextPos,
  }) {
    if (currentPath.isEmpty) {
      return nextPos == level.startPos
          ? MoveResult.valid
          : MoveResult.invalidOutOfBounds;
    }

    final Pos head = currentPath.last;

    // Mundur / retract satu langkah bila mengusap kembali ke sel sebelum kepala.
    if (currentPath.length >= 2 && nextPos == currentPath[currentPath.length - 2]) {
      return MoveResult.retract;
    }

    // Tidak boleh loncat atau diagonal.
    if (!head.isAdjacentTo(nextPos)) {
      return MoveResult.invalidOutOfBounds;
    }

    // Tidak boleh keluar papan.
    if (!level.isInside(nextPos)) {
      return MoveResult.invalidOutOfBounds;
    }

    // Tidak boleh menembus dinding hambatan.
    if (level.isWall(nextPos)) {
      return MoveResult.invalidWall;
    }

    // Tidak boleh bersilangan atau berputar melingkar ke diri sendiri.
    if (currentPath.contains(nextPos)) {
      return MoveResult.invalidLoop;
    }

    // Menghubung ke kutub negatif (-).
    if (nextPos == level.endPos) {
      // Hukum Fisika Rangkaian Tertutup: Harus mengaliri semua beban dulu
      // sebelum menyambung ke kutub negatif agar tidak korsleting / short circuit.
      final Set<Pos> candidateVisited = visitedComponents(level, currentPath);
      if (candidateVisited.length < level.components.length) {
        return MoveResult.invalidPrematureEnd;
      }
      return MoveResult.complete;
    }

    return MoveResult.valid;
  }
}
