import 'component_bank.dart';
import 'component_question.dart';
import 'resistor_code.dart';

export 'component_bank.dart';
export 'component_sampler.dart';

export 'component_question.dart';

final List<ComponentQuestion> tierBQuestions = <ComponentQuestion>[
  ComponentQuestion.resistor(
    id: 'b_220',
    band1: ResistorBand.red,
    band2: ResistorBand.red,
    multiplier: ResistorBand.brown,
  ),
  ComponentQuestion.resistor(
    id: 'b_1k',
    band1: ResistorBand.brown,
    band2: ResistorBand.black,
    multiplier: ResistorBand.red,
  ),
  ComponentQuestion.resistor(
    id: 'b_10k',
    band1: ResistorBand.brown,
    band2: ResistorBand.black,
    multiplier: ResistorBand.orange,
  ),
  ComponentQuestion.resistor(
    id: 'b_330',
    band1: ResistorBand.orange,
    band2: ResistorBand.orange,
    multiplier: ResistorBand.brown,
  ),
  ComponentQuestion.resistor(
    id: 'b_470',
    band1: ResistorBand.yellow,
    band2: ResistorBand.violet,
    multiplier: ResistorBand.brown,
  ),
  ComponentQuestion.resistor(
    id: 'b_4k7',
    band1: ResistorBand.yellow,
    band2: ResistorBand.violet,
    multiplier: ResistorBand.red,
  ),
  ComponentQuestion.resistor(
    id: 'b_100',
    band1: ResistorBand.brown,
    band2: ResistorBand.black,
    multiplier: ResistorBand.brown,
  ),
  ComponentQuestion.resistor(
    id: 'b_100k',
    band1: ResistorBand.brown,
    band2: ResistorBand.black,
    multiplier: ResistorBand.yellow,
  ),
  ComponentQuestion.resistor(
    id: 'b_1m',
    band1: ResistorBand.brown,
    band2: ResistorBand.black,
    multiplier: ResistorBand.green,
  ),
  ComponentQuestion.resistor(
    id: 'b_560',
    band1: ResistorBand.green,
    band2: ResistorBand.blue,
    multiplier: ResistorBand.brown,
  ),
];

const List<ComponentQuestion> tierCQuestions = <ComponentQuestion>[
  ComponentQuestion(
    id: 'c_ohm',
    question: 'Tegangan 5 V terhubung resistor 250 Ω. Berapa arus listriknya?',
    options: <String>['20 mA', '50 mA', '2 mA', '1250 mA'],
    correctIndex: 0,
    hint: 'Hukum Ohm I = V / R.',
    explanation: 'I = 5/250 = 0,02 A = 20 mA.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_daya',
    question: 'Rumus daya listrik (Watt) pada komponen arus I & tegangan V:',
    options: <String>['P = V × I', 'P = V / I', 'P = I / V', 'P = V + I'],
    correctIndex: 0,
    hint: 'Daya adalah hasil kali tegangan dan arus.',
    explanation: 'P = V × I.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_emas',
    question: 'Gelang ke-4 berwarna emas menunjukkan toleransi...',
    options: <String>['±5%', '±10%', '±1%', '±20%'],
    correctIndex: 0,
    hint: 'Emas = 5%, Perak = 10%.',
    explanation: 'Gelang emas menandakan toleransi 5%.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_pullup',
    question: 'Fungsi resistor pull-up pada tombol mikrokontroler adalah...',
    options: <String>[
      'Cegah floating pin',
      'Percepat clock',
      'Turunkan tegangan',
      'Ubah sinyal',
    ],
    correctIndex: 0,
    hint: 'Mencegah status input mengambang.',
    explanation: 'Pull-up menjaga logika HIGH saat terbuka.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_farad',
    question: 'Satuan standar internasional (SI) untuk kapasitansi:',
    options: <String>['Farad (F)', 'Henry (H)', 'Tesla (T)', 'Coulomb (C)'],
    correctIndex: 0,
    hint: 'Nama Michael Faraday.',
    explanation: 'Satuan kapasitansi adalah Farad.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_led_r',
    question: 'Mengapa LED dipasang seri dengan resistor pada 5 V?',
    options: <String>[
      'Batasi arus aman',
      'Naikkan kedip',
      'Otomatis polaritas',
      'Simpan arus',
    ],
    correctIndex: 0,
    hint: 'Mencegah arus berlebih merusak LED.',
    explanation: 'Resistor membatasi arus kerja LED.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_seri',
    question: 'Dua resistor 100 Ω dan 220 Ω dirangkai SERI. Hambatan total:',
    options: <String>['320 Ω', '68,75 Ω', '120 Ω', '22000 Ω'],
    correctIndex: 0,
    hint: 'Rtotal = R1 + R2.',
    explanation: 'Rtotal = 100 + 220 = 320 Ω.',
    difficulty: 'C',
  ),
  ComponentQuestion(
    id: 'c_breadboard',
    question: 'Jalur lubang di sepanjang tepi horizontal breadboard adalah...',
    options: <String>[
      'Jalur bus daya (+/-)',
      'Grup 5 lubang',
      'Diagonal',
      'Terisolasi',
    ],
    correctIndex: 0,
    hint: 'Menghubungkan suplai dari ujung ke ujung.',
    explanation: 'Power rails menghubungkan jalur VCC & GND.',
    difficulty: 'C',
  ),
];

final List<ComponentQuestion> componentQuestionBank = <ComponentQuestion>[
  ...tierAQuestions,
  ...tierBQuestions,
  ...tierCQuestions,
];
