import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Tambahkan ini
import 'firebase_options.dart'; // 2. Tambahkan ini
import 'package:voltar/app.dart'; 

void main() async {
  // 3. Wajib dipanggil sebelum inisialisasi Firebase
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // 4. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 5. Jalankan Aplikasi
  runApp(const ProviderScope(child: VoltarApp()));
}