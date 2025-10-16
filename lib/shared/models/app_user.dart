import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// Model data untuk merepresentasikan seorang pengguna aplikasi.
/// Bisa berupa admin, penghuni (tenant), atau pengguna biasa (tamu).
@freezed
class AppUser with _$AppUser {
  // Constructor privat diperlukan oleh Freezed untuk menambahkan metode kustom seperti getter.
  const AppUser._();

  const factory AppUser({
    // ID unik untuk setiap pengguna.
    required String id,
    // Username yang digunakan untuk login.
    required String username,
    // Password pengguna (di aplikasi nyata, ini harus di-hash).
    required String password,
    // Peran pengguna: "admin", "tenant", atau "user".
    required String role,
    // Nama lengkap pengguna.
    String? fullName,
    // URL ke gambar profil pengguna.
    String? profileImageUrl,
    // Kode kamar yang dihuni oleh pengguna (jika mereka adalah penghuni).
    // Nilai ini null jika pengguna bukan penghuni.
    String? roomId,
  }) = _AppUser;

  /// Getter kustom untuk mendapatkan nama tampilan pengguna.
  /// Jika nama lengkap ada, gunakan itu. Jika tidak, gunakan username sebagai fallback.
  String get name => fullName ?? username;

  /// Factory constructor untuk membuat instance AppUser dari JSON.
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
