# VoltAR

Aplikasi pembelajaran elektronika (Arduino/ESP) untuk siswa SMK. Dibangun dengan
Flutter, offline-first: font dan ikon dibundel, tanpa fetch aset saat runtime.

## Status

| Fase | Isi | Status |
| --- | --- | --- |
| 0 | Fondasi proyek, font offline, target Windows 390x844 | Selesai |
| 1 | Token desain (warna, spacing, tipografi, border) | Selesai |
| 2 | Komponen dasar (ikon Lucide, tombol, kartu, chip, nav bar) | Selesai |
| 3 | Navigasi 4 tab + halaman dengan data dummy | Selesai |
| 4 | Dashboard simulasi + editor placeholder | Selesai |
| 5 | Mesin simulasi AVR native + rangkaian 2D | Berjalan |
| 6 | Materi interaktif + detail materi | Rencana |
| 7 | Mode AR | Rencana |

Fase 5A berjalan: `avr8_dart` menjalankan `assets/hex/blink.hex` di isolate
terpisah, hasilnya bisa dilihat di route `/debug-avr`, dan rangkaian 2D-nya di
`/debug-canvas` (papan, kabel, LED yang berkedip mengikuti pin 13). Belum ada
backend, AR, atau Wokwi. Semua angka dan daftar project adalah data contoh di
`lib/pages/`. Editor simulasi masih placeholder sampai editor rangkaian masuk.

## Struktur

```
lib/
  app.dart              MaterialApp.router + tema global
  router/               app_router.dart (4 branch), app_routes.dart
  shell/app_shell.dart  satu Scaffold + VoltFloatingNavBar
  pages/                home, materi, simulasi (dashboard + editor + debug AVR +
                        debug canvas), profil
  services/             parser Intel HEX, AvrMachine, AvrEngine (siklus hidup
                        isolate/timer), AvrService (stream pin + aset hex)
  theme/                token: colors, spacing, typography, borders, gradients
  widgets/              AppIcon, VoltButton, VoltCard, VoltChip, nav bar,
                        PressScale, DashedBorderBox, CircuitCanvas
  utils/                feedback SnackBar
assets/
  fonts/                Plus Jakarta Sans (OFL)
  hex/                  program AVR uji coba (blink.hex)
  icons/                Lucide 24x24 (ISC)
  licenses/             teks lisensi
```

## Menjalankan

```powershell
flutter pub get
flutter run -d windows
flutter analyze
flutter test
```

Ukuran jendela acuan 390x844 (rasio ponsel). Screenshot tiap fase ada di
`docs/screenshots/`.

