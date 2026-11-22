import 'dart:convert';
import 'dart:io';

/// Terjemahkan materi keys dari app_id.arb ke app_en.arb.
/// Jalankan: `dart run tool/translate_materi.dart`
void main() {
  final idMap = jsonDecode(File('lib/l10n/app_id.arb').readAsStringSync())
      as Map<String, dynamic>;
  final enMap = jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
      as Map<String, dynamic>;

  final result = <String, dynamic>{};
  int translated = 0, skipped = 0;

  idMap.forEach((key, value) {
    final enValue = enMap[key];
    if (key.startsWith('@')) {
      result[key] = value; // metadata as-is
      return;
    }
    if (!key.startsWith('materi')) {
      result[key] = (enValue is String && enValue.isNotEmpty)
          ? enValue
          : '';
      return;
    }
    final idText = value as String?;
    if (idText == null || idText.isEmpty) {
      result[key] = '';
      skipped++;
      return;
    }
    result[key] = _translate(idText);
    translated++;
  });

  final lines = <String>['{'];
  final keys = idMap.keys.toList();
  for (var i = 0; i < keys.length; i++) {
    final key = keys[i];
    final comma = i < keys.length - 1 ? ',' : '';
    lines.add('  "$key": ${jsonEncode(result[key])}$comma');
  }
  lines.add('}');
  File('lib/l10n/app_en.arb').writeAsStringSync('${lines.join('\n')}\n');

  print('=== Selesai ===');
  print('Diterjemahkan: $translated kunci materi');
  print('Dilewati: $skipped');
}

/// Kamus frasa Indonesia → Inggris (domain elektronika/Arduino).
/// Urutan panjang→pendek agar frasa cocok dulu sebelum kata bagian.
final List<MapEntry<String, String>> _phrases = [
  MapEntry("Ohm's Law", "Ohm's Law"),
  MapEntry('Hukum Ohm', "Ohm's Law"),
  MapEntry('berbanding lurus dengan', 'directly proportional to'),
  MapEntry('berbanding terbalik dengan', 'inversely proportional to'),
  MapEntry('berbanding lurus', 'directly proportional'),
  MapEntry('berbanding terbalik', 'inversely proportional'),
  MapEntry('Poin penting', 'Key points'),
  MapEntry('Contoh soal', 'Example problem'),
  MapEntry('Contoh pertama', 'First example'),
  MapEntry('Contoh kedua', 'Second example'),
  MapEntry('Rentang nilai', 'Value range'),
  MapEntry('dari pF hingga F', 'from pF to F'),
  MapEntry('berpolaritas', 'polarized'),
  MapEntry('pasang sesuai kaki', 'install according to lead'),
  MapEntry('kaki positif dan negatif', 'positive and negative leads'),
  MapEntry('Variable capacitor', 'Variable capacitor'),
  MapEntry('penyetelan frekuensi radio', 'radio frequency tuning'),
  MapEntry('Jenis keramik', 'Ceramic type'),
  MapEntry('Jenis poliester', 'Polyester type'),
  MapEntry('kapasitansi kecil dan frekuensi tinggi',
      'small capacitance and high frequency'),
  MapEntry('bahan dielektrik di antaranya', 'dielectric material between them'),
  MapEntry('dua pelat logam', 'two metal plates'),
  MapEntry('menyimpan dan melepaskan energi listrik',
      'stores and releases electrical energy'),
  MapEntry('dengan jenis yang ditentukan oleh',
      'with type determined by'),
  MapEntry('bahan dielektriknya', 'its dielectric material'),
  MapEntry('Tersedia tipe 400 dan 830 pin', 'Available in 400 and 830 pin types'),
  MapEntry('Gunakan avometer mode continuity', 'Use multimeter continuity mode'),
  MapEntry('untuk menguji koneksi', 'to test connection'),
  MapEntry('Pin berdekatan belum tentu terhubung',
      'Adjacent pins are not necessarily connected'),
  MapEntry('periksa polanya', 'check the pattern'),
  MapEntry('celah tengah memisahkan dua sisi', 'middle gap separates two sides'),
  MapEntry('cocok untuk memasang IC', 'suitable for mounting IC'),
  MapEntry('Jalur biru dan merah menandai baris yang terhubung',
      'Blue and red tracks mark connected rows'),
  MapEntry('Memahami pola koneksinya penting',
      'Understanding its connection pattern is important'),
  MapEntry('agar rangkaian tidak salah sambung',
      'so the circuit is not miswired'),
  MapEntry('Breadboard adalah alat prototipe untuk merangkai rangkaian elektronik tanpa menyolder',
      'Breadboard is a prototyping tool for assembling electronic circuits without soldering'),
  MapEntry('Breadboard adalah papan untuk merangkai komponen elektronik tanpa solder',
      'Breadboard is a board for assembling electronic components without solder'),
  MapEntry('dengan pola koneksi pin yang sudah ditentukan',
      'with predetermined pin connection pattern'),
  MapEntry('Hukum Ohm menghubungkan arus, tegangan, dan hambatan dalam rangkaian listrik',
      "Ohm's Law connects current, voltage, and resistance in an electrical circuit"),
  MapEntry('Rumus dasarnya: I = V / R.', 'Basic formula: I = V / R.'),
  MapEntry('Arus berbanding lurus dengan tegangan.',
      'Current is directly proportional to voltage.'),
  MapEntry('Arus berbanding terbalik dengan hambatan.',
      'Current is inversely proportional to resistance.'),
  MapEntry('Satuan: I (ampere), V (volt), R (ohm).',
      'Units: I (ampere), V (volt), R (ohm).'),
  MapEntry(
      'Dapat dipakai untuk menghitung salah satu nilai jika dua lainnya diketahui.',
      'Can be used to calculate one value if the other two are known.'),
  MapEntry(
      'Kapasitor menyimpan dan melepaskan energi listrik.',
      'Capacitor stores and releases electrical energy.'),
  MapEntry(
      'Fungsinya antara lain menjaga kestabilan tegangan, menyaring sinyal, dan penyetelan frekuensi.',
      'Its functions include maintaining voltage stability, filtering signals, and frequency tuning.'),
  MapEntry(
      'Kapasitor adalah komponen yang menyimpan dan melepaskan energi listrik dengan cepat, dengan jenis yang ditentukan oleh bahan dielektriknya.',
      'Capacitor is a component that stores and releases electrical energy quickly, with type determined by its dielectric material.'),
  MapEntry(
      'Breadboard terdiri dari deretan pin yang terhubung secara internal dengan pola tertentu.',
      'Breadboard consists of a series of pins connected internally with a certain pattern.'),
  MapEntry(
      'Jalur berwarna biru dan merah menunjukkan baris yang saling terhubung.',
      'Blue and red tracks show mutually connected rows.'),
  MapEntry(
      'Terdapat dua tipe breadboard dengan jumlah pin berbeda, sekitar 400 pin dan 830 pin, tetapi prinsip kerjanya sama.',
      'There are two breadboard types with different pin counts, about 400 and 830 pins, but working principle is the same.'),
];

/// Kamus kata dasar Indonesia → Inggris untuk fallback per kata.
final Map<String, String> _words = {
  'adalah': 'is',
  'dan': 'and',
  'atau': 'or',
  'dengan': 'with',
  'yang': 'that/which',
  'dalam': 'in',
  'untuk': 'for',
  'dapat': 'can',
  'tidak': 'not',
  'tidak ada': 'none',
  'ada': 'there is/are',
  'di': 'at/in',
  'ke': 'to',
  'dari': 'from',
  'pada': 'on/at',
  'jika': 'if',
  'maka': 'then',
  'namun': 'however',
  'tetapi': 'but',
  'karena': 'because',
  'seperti': 'like',
  'sudah': 'already',
  'belum': 'not yet',
  'tidak tentu': 'not certain',
  'berdekatan': 'adjacent',
  'seluruh': 'all',
  'setiap': 'each',
  'salah satu': 'one of',
  'dua': 'two',
  'tiga': 'three',
  'empat': 'four',
  'lima': 'five',
  'pertama': 'first',
  'kedua': 'second',
  'ketiga': 'third',
  'contoh': 'example',
  'langkah': 'step',
  'cara': 'way/method',
  'rumus': 'formula',
  'hitung': 'calculate',
  'menghitung': 'calculating',
  'dibutuhkan': 'needed',
  'digunakan': 'used',
  'membuat': 'making',
  'mengatur': 'setting',
  'mengontrol': 'controlling',
  'membaca': 'reading',
  'menghasilkan': 'producing',
  'menampilkan': 'displaying',
  'menyalakan': 'turning on',
  'mematikan': 'turning off',
  'nyala': 'on',
  'mati': 'off',
  'knob': 'knob',
  'diputar': 'turned',
  'lebih banyak': 'more',
  'konversi': 'conversion',
  'nilai': 'value',
};

String _translate(String idText) {
  var result = idText;
  // Pass 1: frasa (panjang dulu). Kata yang tidak ada kamus biarkan as-is.
  for (final e in _phrases) {
    result = result.replaceAll(e.key, e.value);
  }
  return result;
}