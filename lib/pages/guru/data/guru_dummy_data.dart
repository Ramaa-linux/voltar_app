/// Status tugas untuk Guru.
enum StatusTugas {
  aktif,
  selesai,
}

/// Data dummy kelas untuk Guru.
class KelasDummy {
  const KelasDummy({
    required this.id,
    required this.nama,
    required this.jumlahSiswa,
    required this.siswa,
  });

  final String id;
  final String nama;
  final int jumlahSiswa;
  final List<String> siswa;
}

/// Data dummy tugas untuk Guru.
class TugasDummy {
  const TugasDummy({
    required this.judul,
    required this.deadline,
    required this.status,
  });

  final String judul;
  final DateTime deadline;
  final StatusTugas status;
}

/// Data dummy aktivitas untuk Guru.
class AktivitasDummy {
  const AktivitasDummy({
    required this.teks,
    required this.waktu,
  });

  final String teks;
  final DateTime waktu;
}

/// Daftar kelas dummy (3 kelas, total 90 siswa).
/// Catatan: Statistik di Dashboard (2 kelas, 60 siswa) bersifat display-only
/// dan akan diselaraskan saat integrasi Fase 28+.
/// TODO(fase-integrasi): Sinkronkan dengan data real dari Firestore.
final List<KelasDummy> dummyKelasList = <KelasDummy>[
  KelasDummy(
    id: 'kelas_1',
    nama: 'X TKJ 1',
    jumlahSiswa: 30,
    siswa: <String>[
      'Ahmad Fauzi',
      'Budi Santoso',
      'Citra Dewi',
      'Dewi Sartika',
      'Eko Prasetyo',
      'Fitri Handayani',
      'Gunawan Wibowo',
      'Hana Putri',
      'Iwan Setiawan',
      'Joko Susilo',
      'Kartika Sari',
      'Lukman Hakim',
      'Maya Indah',
      'Nanda Pratama',
      'Oki Firmansyah',
      'Putri Ayu',
      'Qori Ananda',
      'Rizky Ramadhan',
      'Siti Nurhaliza',
      'Taufik Hidayat',
      'Ulfa Maharani',
      'Vina Oktaviani',
      'Wahyu Pratama',
      'Xaverius Adi',
      'Yuni Shinta',
      'Zaki Mubarok',
      'Adi Nugroho',
      'Bella Ramadhani',
      'Candra Wijaya',
      'Dinda Permata',
      'Eka Putra',
    ],
  ),
  KelasDummy(
    id: 'kelas_2',
    nama: 'X TKJ 2',
    jumlahSiswa: 30,
    siswa: <String>[
      'Fajar Sidiq',
      'Gita Kirana',
      'Hendra Wijaya',
      'Indah Permata',
      'Joko Widodo',
      'Karina Putri',
      'Lintang Buana',
      'Muhammad Rizki',
      'Nabila Azzahra',
      'Oscar Pratama',
      'Priska Dewi',
      'Qonita Salma',
      'Rafa Alfian',
      'Salma Hayati',
      'Tegar Prasetyo',
      'Ulya Rahma',
      'Viktor Aditya',
      'Wulan Sari',
      'Yusuf Abdullah',
      'Zahra Amalia',
      'Arif Rahman',
      'Bunga Citra',
      'Dimas Aditya',
      'Eri Yanto',
      'Farah Diba',
      'Gilang Ramadhan',
      'Hanafi Rizky',
      'Ika Putri',
      'Jefri Sanjaya',
      'Kezia Putri',
    ],
  ),
  KelasDummy(
    id: 'kelas_3',
    nama: 'XI RPL 1',
    jumlahSiswa: 30,
    siswa: <String>[
      'Larasati Dewi',
      'Muhammad Fadil',
      'Novianti Putri',
      'Omar Hakim',
      'Pandu Wicaksono',
      'Quraisy Alif',
      'Raden Pangeran',
      'Sekar Ayu',
      'Tito Wibowo',
      'Ummi Kalsum',
      'Vidi Aldiano',
      'Winda Pratiwi',
      'Xenia Putri',
      'Yudha Pratama',
      'Zaskia Mecca',
      'Alfian Dwi',
      'Bintang Pusaka',
      'Cahya Gemilang',
      'Dewi Sartika',
      'Eko Yulianto',
      'Fira Basuki',
      'Guntur Adi',
      'Hesti Rahayu',
      'Iqbal Permana',
      'Jasmine Putri',
      'Krisna Wijaya',
      'Lutfia Rahma',
      'Mawar Merah',
      'Nanda Kusuma',
      'Oki Pratama',
      'Putri Malika',
    ],
  ),
];

/// Daftar tugas dummy (4 tugas: 3 aktif, 1 selesai).
final List<TugasDummy> dummyTugasList = <TugasDummy>[
  TugasDummy(
    judul: 'Tugas 1: Pengenalan Jaringan Komputer',
    deadline: DateTime(2025, 1, 20, 23, 59),
    status: StatusTugas.aktif,
  ),
  TugasDummy(
    judul: 'Tugas 2: Konfigurasi Router Dasar',
    deadline: DateTime(2025, 1, 25, 23, 59),
    status: StatusTugas.aktif,
  ),
  TugasDummy(
    judul: 'Tugas 3: Subnetting IPv4',
    deadline: DateTime(2025, 2, 1, 23, 59),
    status: StatusTugas.aktif,
  ),
  TugasDummy(
    judul: 'Tugas 4: Praktikum Kabel UTP (Selesai)',
    deadline: DateTime(2025, 1, 10, 23, 59),
    status: StatusTugas.selesai,
  ),
];

/// Daftar aktivitas dummy (5+ item).
final List<AktivitasDummy> dummyAktivitasList = <AktivitasDummy>[
  AktivitasDummy(
    teks: 'Membuat kelas "X TKJ 1"',
    waktu: DateTime(2025, 1, 5, 9, 30),
  ),
  AktivitasDummy(
    teks: 'Menambahkan 30 siswa ke X TKJ 1',
    waktu: DateTime(2025, 1, 5, 10, 15),
  ),
  AktivitasDummy(
    teks: 'Membuat tugas "Pengenalan Jaringan Komputer"',
    waktu: DateTime(2025, 1, 6, 14, 20),
  ),
  AktivitasDummy(
    teks: 'Mengunggah materi "Dasar-Dasar Jaringan"',
    waktu: DateTime(2025, 1, 7, 8, 45),
  ),
  AktivitasDummy(
    teks: 'Mengatur jadwal absensi minggu ini',
    waktu: DateTime(2025, 1, 8, 16, 0),
  ),
  AktivitasDummy(
    teks: 'Membuat kelas "XI RPL 1"',
    waktu: DateTime(2025, 1, 9, 11, 10),
  ),
];

/// Format tanggal ke Bahasa Indonesia (contoh: "Senin, 20 Januari 2025").
/// Tanpa dependency intl - pure Dart implementation.
String formatTanggalIndonesia(DateTime date) {
  const List<String> hari = <String>[
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];
  const List<String> bulan = <String>[
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  final String namaHari = hari[date.weekday % 7];
  final String namaBulan = bulan[date.month - 1];
  return '$namaHari, ${date.day} $namaBulan ${date.year}';
}

/// Format waktu singkat (contoh: "09:30").
String formatWaktuSingkat(DateTime date) {
  final String jam = date.hour.toString().padLeft(2, '0');
  final String menit = date.minute.toString().padLeft(2, '0');
  return '$jam:$menit';
}