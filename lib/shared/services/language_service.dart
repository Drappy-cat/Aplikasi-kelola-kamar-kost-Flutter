import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Kunci privat yang digunakan untuk menyimpan kode bahasa di SharedPreferences.
const String _kLanguageCodeKey = 'language_code';

/// Service ini mengelola status bahasa aplikasi (misalnya, 'id' atau 'en').
/// Menggunakan `ChangeNotifier` agar widget lain (seperti `MyApp`) dapat mendengarkan
/// perubahan bahasa dan secara otomatis membangun ulang UI.
class LanguageService with ChangeNotifier {
  final SharedPreferences _prefs;

  // State internal untuk menyimpan locale (bahasa) saat ini.
  // Default bahasa aplikasi adalah Indonesia ('id').
  late Locale _locale = const Locale('id');

  LanguageService(this._prefs);

  // Getter publik untuk mengetahui bahasa yang sedang aktif.
  Locale get locale => _locale;

  /// Memuat preferensi bahasa yang tersimpan dari SharedPreferences saat aplikasi dimulai.
  void loadSavedLocale() {
    final savedLanguageCode = _prefs.getString(_kLanguageCodeKey);
    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode);
    }
    // Tidak perlu `notifyListeners()` di sini karena ini dipanggil sekali saat inisialisasi,
    // sebelum UI utama dibangun.
  }

  /// Mengubah bahasa aplikasi, menyimpannya ke SharedPreferences, dan memperbarui UI.
  Future<void> setLocale(Locale newLocale) async {
    // Jika bahasa yang dipilih sama dengan yang sekarang, tidak perlu melakukan apa-apa.
    if (_locale == newLocale) return;

    _locale = newLocale;
    // Simpan kode bahasa baru (misal, 'en') ke SharedPreferences untuk persistensi.
    await _prefs.setString(_kLanguageCodeKey, newLocale.languageCode);
    // Beri tahu semua pendengar (listeners) bahwa bahasa telah berubah agar UI diperbarui.
    notifyListeners();
  }
}
