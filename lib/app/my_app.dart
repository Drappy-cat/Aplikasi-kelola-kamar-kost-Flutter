import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tes/app/app_router.dart';
import 'package:tes/l10n/app_localizations.dart';
import 'package:tes/shared/services/language_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final languageService = getIt<LanguageService>();

    return AnimatedBuilder(
      animation: Listenable.merge([themeService, languageService]),
      builder: (context, child) {
        const seedColor = Color(0xFF3D9970);
        final inputDecorationTheme = InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        );

        const appBarTheme = AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        );

        final lightTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F6FA),
          appBarTheme: appBarTheme.copyWith(
            foregroundColor: Colors.black87,
          ),
          inputDecorationTheme: inputDecorationTheme,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300, width: 0.8),
            ),
          ),
        );

        final darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: appBarTheme.copyWith(
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: inputDecorationTheme,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          cardTheme: CardThemeData(
            elevation: 0,
            color: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade800, width: 0.8),
            ),
          ),
        );

        return ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return MaterialApp.router(
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              title: 'Aplikasi Kost',
              themeMode: themeService.themeMode,
              theme: lightTheme.copyWith(
                textTheme: GoogleFonts.interTextTheme(lightTheme.textTheme),
              ),
              darkTheme: darkTheme.copyWith(
                textTheme: GoogleFonts.interTextTheme(darkTheme.textTheme),
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English
                Locale('id', ''), // Indonesian
              ],
              locale: languageService.locale,
            );
          },
        );
      },
    );
  }
}
