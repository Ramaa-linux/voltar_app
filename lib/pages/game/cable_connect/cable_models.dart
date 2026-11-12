import 'package:flutter/foundation.dart';

/// Posisi 2D pada kisi grid (baris, kolom).
@immutable
class Pos {
  const Pos(this.r, this.c);

  final int r;
  final int c;

  Pos get up => Pos(r - 1, c);
  Pos get down => Pos(r + 1, c);
  Pos get left => Pos(r, c - 1);
  Pos get right => Pos(r, c + 1);

  List<Pos> get neighbors => <Pos>[up, down, left, right];

  int manhattanDistanceTo(Pos other) =>
      (r - other.r).abs() + (c - other.c).abs();

  bool isAdjacentTo(Pos other) => manhattanDistanceTo(other) == 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pos &&
          runtimeType == other.runtimeType &&
          r == other.r &&
          c == other.c;

  @override
  int get hashCode => Object.hash(r, c);

  @override
  String toString() => 'Pos($r, $c)';
}

/// Jenis sel di dalam kisi puzzle kabel.
enum CellType {
  empty,
  startTerminal, // Kutub positif (+) baterai
  endTerminal, // Kutub negatif (-) baterai
  wall, // Blok isolator tidak bisa dilalui
  resistor, // Komponen resistor (beban wajib)
  led, // Komponen LED (beban wajib)
}

/// Hasil validasi langkah kabel.
enum MoveResult {
  valid,
  retract,
  invalidOutOfBounds,
  invalidWall,
  invalidLoop,
  invalidPrematureEnd,
  complete,
}

/// Model level puzzle Sambung Kabel.
class CableLevel {
  const CableLevel({
    required this.id,
    required this.width,
    required this.height,
    required this.startPos,
    required this.endPos,
    required this.walls,
    required this.components,
    this.targetSteps = 0,
    this.witnessPath,
    this.hint,
  });

  final int id;
  final int width;
  final int height;
  final Pos startPos;
  final Pos endPos;
  final Set<Pos> walls;

  /// Peta komponen beban wajib (resistor / led) di kisi.
  final Map<Pos, CellType> components;

  final int targetSteps;
  final List<Pos>? witnessPath;
  final String? hint;

  bool isInside(Pos p) => p.r >= 0 && p.r < height && p.c >= 0 && p.c < width;

  bool isWall(Pos p) => walls.contains(p);

  CellType cellTypeAt(Pos p) {
    if (p == startPos) return CellType.startTerminal;
    if (p == endPos) return CellType.endTerminal;
    if (walls.contains(p)) return CellType.wall;
    return components[p] ?? CellType.empty;
  }

  /// Membuat level dari representasi ASCII:
  /// `+`: start terminal
  /// `-`: end terminal
  /// `#`: wall
  /// `R`: resistor
  /// `L`: LED
  /// `.`: empty
  factory CableLevel.fromAscii({
    required int id,
    required List<String> grid,
    int? targetSteps,
    List<Pos>? witnessPath,
    String? hint,
  }) {
    final int height = grid.length;
    final int width = grid.first.length;
    Pos? start;
    Pos? end;
    final Set<Pos> walls = <Pos>{};
    final Map<Pos, CellType> components = <Pos, CellType>{};

    for (int r = 0; r < height; r++) {
      final String row = grid[r];
      for (int c = 0; c < width; c++) {
        final Pos pos = Pos(r, c);
        final String char = row[c];
        switch (char) {
          case '+':
            start = pos;
            break;
          case '-':
            end = pos;
            break;
          case '#':
            walls.add(pos);
            break;
          case 'R':
            components[pos] = CellType.resistor;
            break;
          case 'L':
            components[pos] = CellType.led;
            break;
          case '.':
          default:
            break;
        }
      }
    }

    if (start == null || end == null) {
      throw ArgumentError(
        'Grid ASCII harus memuat start (+) dan end (-) terminal.',
      );
    }

    return CableLevel(
      id: id,
      width: width,
      height: height,
      startPos: start,
      endPos: end,
      walls: walls,
      components: components,
      targetSteps: targetSteps ?? (witnessPath?.length ?? 0),
      witnessPath: witnessPath,
      hint: hint,
    );
  }
}
