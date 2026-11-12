import 'dart:math' as math;

/// Standard 4-band resistor color code enum.
enum ResistorBand {
  black(0, 1.0, 'Hitam', 0xFF1F2937),
  brown(1, 10.0, 'Cokelat', 0xFF78350F),
  red(2, 100.0, 'Merah', 0xFFDC2626),
  orange(3, 1000.0, 'Oranye', 0xFFEA580C),
  yellow(4, 10000.0, 'Kuning', 0xFFEAB308),
  green(5, 100000.0, 'Hijau', 0xFF16A34A),
  blue(6, 1000000.0, 'Biru', 0xFF2563EB),
  violet(7, 10000000.0, 'Ungu', 0xFF7C3AED),
  grey(8, 100000000.0, 'Abu-abu', 0xFF6B7280),
  white(9, 1000000000.0, 'Putih', 0xFFF9FAFB),
  gold(-1, 0.1, 'Emas', 0xFFD97706),
  silver(-1, 0.01, 'Perak', 0xFF9CA3AF);

  const ResistorBand(this.digit, this.multiplier, this.labelId, this.argb);

  /// Digit value (0–9) or -1 for tolerance-only bands (gold/silver).
  final int digit;

  /// Multiplier factor when used as the 3rd band.
  final double multiplier;

  /// Indonesian color name.
  final String labelId;

  /// ARGB hex value for custom painting.
  final int argb;
}

/// Calculates resistance in Ohms from 4 bands:
/// `(band1.digit * 10 + band2.digit) * multiplier.multiplier`.
double resistorOhms(
  ResistorBand band1,
  ResistorBand band2,
  ResistorBand multiplier,
) {
  assert(band1.digit >= 0 && band2.digit >= 0, 'Digit bands must be 0-9');
  final int base = band1.digit * 10 + band2.digit;
  return base * multiplier.multiplier;
}

/// Formats an Ohm value into Indonesian notation (comma decimal, Ω / kΩ / MΩ).
/// Examples:
/// - 220 -> "220 Ω"
/// - 4700 -> "4,7 kΩ"
/// - 10000 -> "10 kΩ"
/// - 1000000 -> "1 MΩ"
String formatOhm(double ohms) {
  String fmtNum(double val) {
    final double rounded = (val * 100).roundToDouble() / 100;
    if (rounded == rounded.roundToDouble()) {
      return rounded.toInt().toString();
    }
    return rounded.toString().replaceAll('.', ',');
  }

  if (ohms >= 1000000) {
    return '${fmtNum(ohms / 1000000)} MΩ';
  }
  if (ohms >= 1000) {
    return '${fmtNum(ohms / 1000)} kΩ';
  }
  return '${fmtNum(ohms)} Ω';
}

/// Standard E12 base values (10 to 82) for generating realistic distractors.
const List<int> _e12Bases = <int>[
  10,
  12,
  15,
  18,
  22,
  27,
  33,
  39,
  47,
  56,
  68,
  82,
];

/// Generates 3 unique, deterministic distractor Ohm strings for a given target
/// resistance value, ensuring no duplicates with the correct answer.
List<String> buildResistorDistractors(double correctOhms) {
  final String correctStr = formatOhm(correctOhms);
  final Set<String> distractors = <String>{};

  // Candidate multipliers relative to the target value.
  final List<double> candidateFactors = <double>[
    0.1,
    10.0,
    0.47,
    2.2,
    0.22,
    4.7,
    0.5,
    2.0,
  ];

  // Try E12 neighbors at the same decade and adjacent decades first.
  final int decadeExp = correctOhms > 0
      ? (math.log(correctOhms) / math.ln10).floor() - 1
      : 0;
  final double decadeScale = math.pow(10, decadeExp).toDouble();

  // Deterministic offset based on correctOhms hash
  final int startIdx = (correctOhms.round() * 7) % _e12Bases.length;
  for (int i = 0; i < _e12Bases.length && distractors.length < 3; i++) {
    final int base = _e12Bases[(startIdx + i) % _e12Bases.length];
    final double candidate = base * decadeScale;
    if (candidate > 0) {
      final String formatted = formatOhm(candidate);
      if (formatted != correctStr) {
        distractors.add(formatted);
      }
    }
  }

  // Fallback decade shifts if still fewer than 3.
  for (final double factor in candidateFactors) {
    if (distractors.length >= 3) break;
    final String formatted = formatOhm(correctOhms * factor);
    if (formatted != correctStr) {
      distractors.add(formatted);
    }
  }

  return distractors.take(3).toList();
}