import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tes/app/app_router.dart'; // Import router baru

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

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
      inputDecorationTheme: inputDecorationTheme,
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      inputDecorationTheme: inputDecorationTheme,
    );

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        // Menggunakan MaterialApp.router untuk integrasi dengan go_router
        return MaterialApp.router(
          routerConfig: appRouter, // Menggunakan konfigurasi dari app_router.dart
          debugShowCheckedModeBanner: false,
          title: 'Aplikasi Kost',
          themeMode: _mode,
          theme: lightTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(lightTheme.textTheme),
          ),
          darkTheme: darkTheme.copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(darkTheme.textTheme),
          ),
        );
      },
    );
  }
}
