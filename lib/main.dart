import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/locator.dart'; // Import locator

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Service Locator
  await setupLocator(); // Menunggu setup selesai
  
  runApp(const MyApp());
}
