import 'package:flutter/material.dart';
import 'package:tes/features/auth/login_screen.dart';
import 'package:tes/features/auth/register_screen.dart';
import 'package:tes/features/auth/splash_screen.dart';
import 'package:tes/features/home/home_screen.dart';
import 'package:tes/features/profile/profile_screen.dart';
import 'package:tes/features/settings/settings_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _mode = ThemeMode.light;

  void rebuildApp() {
    setState(() {});
  }

  void toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final seed = Colors.pink;
    final inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kost',
      themeMode: _mode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        inputDecorationTheme: inputDecorationTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        inputDecorationTheme: inputDecorationTheme,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
