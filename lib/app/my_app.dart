import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes/features/auth/login_screen.dart';
import 'package:tes/features/auth/register_screen.dart';
import 'package:tes/features/auth/splash_screen.dart';
import 'package:tes/features/home/home_screen.dart';
import 'package:tes/features/notification/notification_screen.dart';
import 'package:tes/features/profile/profile_screen.dart';
import 'package:tes/features/settings/settings_screen.dart';
import 'package:tes/features/complaints/admin_complaint_screen.dart';
import 'package:tes/features/announcements/announcement_screen.dart';
import 'package:tes/features/billing/user_bill_screen.dart'; // Import the new user bill screen

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kost',
      themeMode: _mode,
      theme: lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(lightTheme.textTheme),
      ),
      darkTheme: darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(darkTheme.textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/admin_complaints': (context) => const AdminComplaintScreen(),
        '/announcements': (context) => const AnnouncementScreen(),
        '/user_bills': (context) => const UserBillScreen(), // Add route for UserBillScreen
      },
    );
  }
}
