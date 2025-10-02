import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tes/app/app_router.dart'; // Import router baru
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dapatkan instance ThemeService dari locator
    final themeService = getIt<ThemeService>();

    // Gunakan AnimatedBuilder untuk mendengarkan perubahan pada ThemeService
    return AnimatedBuilder(
      animation: themeService,
      builder: (context, child) {
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
            return MaterialApp.router(
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              title: 'Aplikasi Kost',
              // Gunakan themeMode dari ThemeService
              themeMode: themeService.themeMode,
              theme: lightTheme.copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(lightTheme.textTheme),
              ),
              darkTheme: darkTheme.copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(darkTheme.textTheme),
              ),
            );
          },
        );
      },
    );
  }
}
