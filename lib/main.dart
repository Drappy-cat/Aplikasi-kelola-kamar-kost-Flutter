import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/language_service.dart'; // <-- IMPORT BARU
import 'package:tes/shared/services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi service locator Anda
  await setupLocator();

  // PERBAIKAN: Muat preferensi bahasa yang tersimpan
  getIt<LanguageService>().loadSavedLocale();

  // Jalankan aplikasi
  runApp(const MyApp());
}
