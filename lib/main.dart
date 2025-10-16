import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/language_service.dart';
import 'package:tes/shared/services/locator.dart';

Future<void> main() async {
  // Pastikan semua binding Flutter siap sebelum menjalankan kode.
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi semua service (seperti DummyService, AuthService, dll.)
  //    agar siap digunakan di seluruh aplikasi.
  await setupLocator();

  // 2. Muat preferensi bahasa yang terakhir disimpan oleh pengguna.
  getIt<LanguageService>().loadSavedLocale();

  // 3. Jalankan widget utama aplikasi.
  runApp(const MyApp());
}
