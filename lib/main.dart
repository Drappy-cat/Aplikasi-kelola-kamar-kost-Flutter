import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';
import 'package:tes/shared/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(const MyApp());
}
