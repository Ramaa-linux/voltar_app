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

  // 4. Verify all JSON _en fields (title_en, description_en, data_en, question_en, options_en)
  final files = [
    for (int i = 1; i <= 5; i++) 'assets/data/level_$i.json',
    'assets/data/materi_komponen_level_1.json',
  ];
  for (final path in files) {
    final list = jsonDecode(File(path).readAsStringSync()) as List<dynamic>;
    void checkStep(Map<String, dynamic> step) {
      final id = step['id'];
      assert((step['title_en'] as String?)?.isNotEmpty == true, '$path:$id missing title_en');
      assert((step['description_en'] as String?)?.isNotEmpty == true, '$path:$id missing description_en');
      for (final b in (step['content'] as List<dynamic>? ?? const [])) {
        final map = b as Map<String, dynamic>;
        if (map['type'] != 'code') {
          assert((map['data_en'] as String?)?.isNotEmpty == true, '$path:$id content missing data_en');
        }
      }
      for (final b in (step['videoSummary'] as List<dynamic>? ?? const [])) {
        final map = b as Map<String, dynamic>;
        assert((map['data_en'] as String?)?.isNotEmpty == true, '$path:$id videoSummary missing data_en');
      }
      for (final q in (step['questions'] as List<dynamic>? ?? const [])) {
        final map = q as Map<String, dynamic>;
        assert((map['question_en'] as String?)?.isNotEmpty == true, '$path:$id question missing question_en');
        final opts = map['options'] as List<dynamic>;
        final optsEn = map['options_en'] as List<dynamic>?;
        assert(optsEn != null && optsEn.length == opts.length, '$path:$id question missing options_en');
      }
      for (final sub in (step['subMateri'] as List<dynamic>? ?? const [])) {
        checkStep(sub as Map<String, dynamic>);
      }
    }

    for (final item in list) {
      checkStep(item as Map<String, dynamic>);
    }
  }

  print('=== Self-check selesai ===');
  print('Diperiksa: $checked kunci');
  print('Hilang: $missing kunci');
  if (missing > 0) exit(1);
}
