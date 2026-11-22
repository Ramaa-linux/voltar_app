import 'dart:convert';
import 'dart:io';

/// Self-check: verifikasi kunci lokalisasi yang dihasilkan [MateriRepository]
/// cocok dengan kunci yang ada di `lib/l10n/app_id.arb` (hasil Act 1).
///
/// Jalankan: `dart run test/materi_keys_check.dart`
void main() {
  final arb = File('lib/l10n/app_id.arb').readAsStringSync();
  final arbMap = jsonDecode(arb) as Map<String, dynamic>;

  int checked = 0;
  int missing = 0;

  void expectKey(String key) {
    checked++;
    if (!arbMap.containsKey(key)) {
      missing++;
      print('MISSING di app_id.arb: $key');
    }
  }

  // 1. Level files: materiL{level}{StepIdCamel}{Field}
  expectKey('materiL1L1KomLedTitle');
  expectKey('materiL1L1KomLedDescription');
  expectKey('materiL1L1KomLedEstimatedTime');
  expectKey('materiL1L1KomLedContent0Text');
  expectKey('materiL1L1KomLedContent1Text');
  expectKey('materiL1L1KomLedVideoSummary0Heading');
  expectKey('materiL1L1KomLedVideoSummary1Text');
  expectKey('materiL2L2ArrayPointerTitle');
  expectKey('materiL3L3AdcTitle');
  expectKey('materiL4L4DebouncingTitle');
  expectKey('materiL5L5M1Title');

  // 2. Pretest / posttest questions: Q{qCamel}Question / Option{n}
  expectKey('materiL1L1PretestQQ1Question');
  expectKey('materiL1L1PretestQQ1Option0');
  expectKey('materiL1L1PretestQQ4Option3');
  expectKey('materiL1L1PosttestQQ1Question');

  // 3. Komponen: materiKomponen{StepIdCamel}{Field}
  expectKey('materiKomponenL1KomLedTitle');
  expectKey('materiKomponenL1KomLedDescription');

  print('=== Self-check selesai ===');
  print('Diperiksa: $checked kunci');
  print('Hilang: $missing kunci');
  if (missing > 0) exit(1);
}
