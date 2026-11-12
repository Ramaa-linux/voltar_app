import 'cable_models.dart';

/// Kumpulan level tutorial terkurasi (Level 1-3) dan fakta edukasi fisika.
abstract final class CableLevels {
  /// Fakta edukasi singkat saat menyelesaikan level.
  static const List<String> physicsFacts = <String>[
    'Arus listrik konvensional mengalir dari kutub positif (+) menuju kutub negatif (-) dalam rangkaian tertutup.',
    'Resistor berfungsi membatasi arus listrik agar komponen sensitif seperti LED tidak terbakar karena kelebihan arus.',
    'Rangkaian harus tertutup tanpa putus dan melewati beban agar energi listrik berubah menjadi cahaya pada LED.',
    'Menyambungkan kutub (+) langsung ke (-) tanpa beban (resistor/LED) menyebabkan hubungan arus pendek (korsleting)!',
    'Dalam rangkaian seri, arus yang mengalir melewati setiap resistor dan LED memiliki besar yang sama.',
  ];

  static String factForLevel(int levelId) =>
      physicsFacts[(levelId - 1) % physicsFacts.length];

  /// Level 1 (6x6): Pengenalan dasar arus dari (+) -> Resistor -> LED -> (-).
  static final CableLevel level1 = CableLevel.fromAscii(
    id: 1,
    grid: const <String>[
      '+..#..',
      '.R.#..',
      '...#..',
      '.#....',
      '.#.L..',
      '...#.-',
    ],
    witnessPath: const <Pos>[
      Pos(0, 0),
      Pos(1, 0),
      Pos(1, 1),
      Pos(2, 1),
      Pos(2, 2),
      Pos(3, 2),
      Pos(3, 3),
      Pos(4, 3),
      Pos(4, 4),
      Pos(5, 4),
      Pos(5, 5),
    ],
    hint: 'Tarik kabel dari (+) melewati Resistor & LED menuju (-).',
  );

  /// Level 2 (7x7): Rangkaian seri 1 Resistor + 2 LED dengan belokan tembok.
  static final CableLevel level2 = CableLevel.fromAscii(
    id: 2,
    grid: const <String>[
      '+..#...',
      '.R.#.L.',
      '.....#.',
      '.###.#.',
      '.L.....',
      '.#.###.',
      '.....-.',
    ],
    witnessPath: const <Pos>[
      Pos(0, 0),
      Pos(1, 0),
      Pos(1, 1),
      Pos(2, 1),
      Pos(2, 2),
      Pos(2, 3),
      Pos(2, 4),
      Pos(1, 4),
      Pos(1, 5),
      Pos(0, 5),
      Pos(0, 6),
      Pos(1, 6),
      Pos(2, 6),
      Pos(3, 6),
      Pos(4, 6),
      Pos(4, 5),
      Pos(4, 4),
      Pos(4, 3),
      Pos(4, 2),
      Pos(4, 1),
      Pos(4, 0),
      Pos(5, 0),
      Pos(6, 0),
      Pos(6, 1),
      Pos(6, 2),
      Pos(6, 3),
      Pos(6, 4),
      Pos(6, 5),
    ],
    hint: 'Rangkaian seri: nyalakan kedua LED dengan satu jalur utuh!',
  );

  /// Level 3 (8x8): 2 Resistor dan 2 LED dengan labirin PCB.
  static final CableLevel level3 = CableLevel.fromAscii(
    id: 3,
    grid: const <String>[
      '+.#.#...',
      '.#..#.R.',
      '.R..#...',
      '.#..##..',
      '.#.L....',
      '.###.##.',
      '.....L..',
      '..#...-.',
    ],
    witnessPath: const <Pos>[
      Pos(0, 0),
      Pos(1, 0),
      Pos(2, 0),
      Pos(2, 1),
      Pos(2, 2),
      Pos(1, 2),
      Pos(1, 3),
      Pos(2, 3),
      Pos(3, 3),
      Pos(4, 3),
      Pos(4, 4),
      Pos(4, 5),
      Pos(4, 6),
      Pos(3, 6),
      Pos(2, 6),
      Pos(1, 6),
      Pos(1, 7),
      Pos(2, 7),
      Pos(3, 7),
      Pos(4, 7),
      Pos(5, 7),
      Pos(6, 7),
      Pos(6, 6),
      Pos(6, 5),
      Pos(7, 5),
      Pos(7, 6),
    ],
    hint: 'Pastikan semua Resistor dan LED terhubung sebelum ke (-).',
  );

  static final List<CableLevel> tutorials = <CableLevel>[
    level1,
    level2,
    level3,
  ];
}

