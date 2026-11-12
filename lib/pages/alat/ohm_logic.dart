/// Variabel dalam rumus Hukum Ohm: V = I × R.
enum OhmVariable {
  voltage,
  current,
  resistance;

  String get symbol => switch (this) {
    OhmVariable.voltage => 'V',
    OhmVariable.current => 'I',
    OhmVariable.resistance => 'R',
  };

  String get unit => switch (this) {
    OhmVariable.voltage => 'Volt (V)',
    OhmVariable.current => 'Ampere (A)',
    OhmVariable.resistance => 'Ohm (Ω)',
  };

  String get label => switch (this) {
    OhmVariable.voltage => 'Tegangan (V)',
    OhmVariable.current => 'Arus (I)',
    OhmVariable.resistance => 'Hambatan (R)',
  };
}

/// Hasil evaluasi perhitungan Hukum Ohm.
class OhmCalculationResult {
  const OhmCalculationResult({
    this.targetVariable,
    this.calculatedValue,
    this.formattedValue,
    this.errorMessage,
  });

  final OhmVariable? targetVariable;
  final double? calculatedValue;
  final String? formattedValue;
  final String? errorMessage;

  bool get hasError => errorMessage != null;
  bool get hasResult => calculatedValue != null && errorMessage == null;
}

/// Logika murni perhitungan Hukum Ohm (Pure Dart tanpa dependensi Flutter).
abstract final class OhmCalculator {
  /// Mengonversi teks input pengguna ke double.
  /// Menerima koma (,) dan titik (.), mengabaikan spasi.
  static double? parseInput(String? raw) {
    if (raw == null) return null;
    final String clean = raw.trim().replaceAll(',', '.');
    if (clean.isEmpty || clean == '.' || clean == '-' || clean == '+') {
      return null;
    }
    final double? val = double.tryParse(clean);
    if (val == null || val.isNaN || val.isInfinite || val < 0) {
      return null;
    }
    return val;
  }

  /// Memformat angka floating point ke string yang rapi (maks 4 desimal, tanpa trailing zero).
  static String formatValue(double value) {
    if (value.isNaN || value.isInfinite) return '';
    if (value == 0) return '0';

    final double absVal = value.abs();
    if (absVal >= 1e9 || (absVal < 1e-4 && absVal > 0)) {
      return value.toStringAsExponential(4).replaceAll(RegExp(r'\.?0+e'), 'e');
    }

    final double rounded = double.parse(value.toStringAsFixed(4));
    if (rounded == rounded.truncateToDouble()) {
      return rounded.toInt().toString();
    }

    return rounded.toStringAsFixed(4).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  /// Menghitung variabel ketiga berdasarkan 2 field terisi atau edit history.
  static OhmCalculationResult calculate({
    required double? voltage,
    required double? current,
    required double? resistance,
    List<OhmVariable> editHistory = const <OhmVariable>[],
  }) {
    final bool hasV = voltage != null;
    final bool hasI = current != null;
    final bool hasR = resistance != null;
    final int filledCount = (hasV ? 1 : 0) + (hasI ? 1 : 0) + (hasR ? 1 : 0);

    if (filledCount < 2) {
      return const OhmCalculationResult();
    }

    OhmVariable target;
    if (filledCount == 2) {
      if (!hasV) {
        target = OhmVariable.voltage;
      } else if (!hasI) {
        target = OhmVariable.current;
      } else {
        target = OhmVariable.resistance;
      }
    } else {
      // 3 field terisi: tentukan variabel yang paling lama tidak diedit
      final List<OhmVariable> recent = <OhmVariable>[];
      for (final OhmVariable v in editHistory.reversed) {
        if (!recent.contains(v)) {
          recent.add(v);
          if (recent.length == 2) break;
        }
      }
      target = OhmVariable.values.firstWhere(
        (OhmVariable v) => !recent.contains(v),
        orElse: () => OhmVariable.resistance,
      );
    }

    switch (target) {
      case OhmVariable.voltage:
        final double iVal = current ?? 0;
        final double rVal = resistance ?? 0;
        final double res = iVal * rVal;
        return OhmCalculationResult(
          targetVariable: OhmVariable.voltage,
          calculatedValue: res,
          formattedValue: formatValue(res),
        );

      case OhmVariable.current:
        final double vVal = voltage ?? 0;
        final double rVal = resistance ?? 0;
        if (rVal == 0) {
          return const OhmCalculationResult(
            targetVariable: OhmVariable.current,
            errorMessage: 'Hambatan (R) tidak boleh 0',
          );
        }
        final double res = vVal / rVal;
        return OhmCalculationResult(
          targetVariable: OhmVariable.current,
          calculatedValue: res,
          formattedValue: formatValue(res),
        );

      case OhmVariable.resistance:
        final double vVal = voltage ?? 0;
        final double iVal = current ?? 0;
        if (iVal == 0) {
          return const OhmCalculationResult(
            targetVariable: OhmVariable.resistance,
            errorMessage: 'Arus (I) tidak boleh 0',
          );
        }
        final double res = vVal / iVal;
        return OhmCalculationResult(
          targetVariable: OhmVariable.resistance,
          calculatedValue: res,
          formattedValue: formatValue(res),
        );
    }
  }
}
