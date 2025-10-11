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
        // PERUBAHAN: Mengganti seed color ke Opsi 2 (Hijau Sage/Mint)
        final seed = const Color(0xFF3D9970); // Hijau Sage/Mint

        final inputDecorationTheme = InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        );

        final lightTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.light,
          ),
          inputDecorationTheme: inputDecorationTheme,
          // Tambahan: Kustomisasi kecil untuk konsistensi
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // PERBAIKAN: Menggunakan CardThemeData, bukan CardTheme
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        final darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.dark,
          ),
          inputDecorationTheme: inputDecorationTheme,
          // Tambahan: Kustomisasi kecil untuk konsistensi
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // PERBAIKAN: Menggunakan CardThemeData, bukan CardTheme
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
