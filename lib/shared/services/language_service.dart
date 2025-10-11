import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Kunci untuk menyimpan kode bahasa di SharedPreferences
const String _kLanguageCodeKey = 'language_code';

class LanguageService extends ChangeNotifier {
  final SharedPreferences _prefs;

  LanguageService(this._prefs);

  // Locale default adalah Bahasa Indonesia
  late Locale _locale = const Locale('id');

  Locale get locale => _locale;

  // Metode untuk memuat locale yang tersimpan saat aplikasi dimulai
  void loadSavedLocale() {
    final savedLanguageCode = _prefs.getString(_kLanguageCodeKey);
    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode);
    }
    // Tidak perlu notifyListeners() di sini karena ini dipanggil saat init
  }

  // Metode untuk mengubah dan menyimpan locale baru
  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return; // Tidak ada perubahan, jangan lakukan apa-apa

    _locale = newLocale;
    await _prefs.setString(_kLanguageCodeKey, newLocale.languageCode);
    
    // Beri tahu semua pendengar (seperti MyApp) bahwa locale telah berubah
    notifyListeners();
  }
}
