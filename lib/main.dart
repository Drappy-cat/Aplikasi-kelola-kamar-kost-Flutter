import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi service locator Anda
  await setupLocator();

  // Jalankan aplikasi
  runApp(const MyApp());
}
