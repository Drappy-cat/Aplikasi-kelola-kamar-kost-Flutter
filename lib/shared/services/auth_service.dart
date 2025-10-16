import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/locator.dart';

/// Service ini mengelola semua logika yang berkaitan dengan autentikasi pengguna.
/// Termasuk login, logout, registrasi, dan manajemen sesi pengguna saat ini.
class AuthService {
  // Kunci untuk menyimpan username pengguna yang login di SharedPreferences.
  static const String _loggedInUserKey = 'loggedInUsername';

  // Menyimpan data pengguna yang sedang login saat aplikasi berjalan.
  AppUser? _currentUser;

  // Getter publik untuk mengakses data pengguna saat ini dari luar kelas.
  AppUser? get currentUser => _currentUser;
  // Setter untuk memungkinkan perubahan pada data pengguna (misalnya, saat menyewa kamar).
  set currentUser(AppUser? user) {
    _currentUser = user;
  }

  // Getter untuk mengekspos daftar semua pengguna ke service lain (misal, untuk membuat tagihan).
  List<AppUser> get allUsers => _users;

  /// Inisialisasi service, dipanggil saat aplikasi pertama kali dimulai.
  /// Memeriksa apakah ada sesi login yang tersimpan di SharedPreferences.
  Future<void> init() async {
    final prefs = getIt<SharedPreferences>();
    final username = prefs.getString(_loggedInUserKey);
    if (username != null) {
      try {
        // Jika ada username tersimpan, cari data lengkap pengguna dari daftar statis.
        _currentUser = _users.firstWhere((user) => user.username == username);
      } catch (e) {
        // Jika pengguna tidak ditemukan (misal, data korup), hapus sesi.
        _currentUser = null;
      }
    }
  }

  /// Mencari pengguna berdasarkan ID.
  AppUser? findUserById(String userId) {
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  /// Memproses permintaan login dari pengguna.
  Future<void> signIn({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi jeda jaringan.
    try {
      // Cari pengguna dengan username dan password yang cocok.
      final user = _users.firstWhere((u) => u.username == username && u.password == password);
      _currentUser = user;

      // Simpan username ke SharedPreferences untuk menjaga sesi login.
      final prefs = getIt<SharedPreferences>();
      await prefs.setString(_loggedInUserKey, user.username);
    } catch (e) {
      // Jika tidak ditemukan, lempar error.
      throw 'Username atau password salah.';
    }
  }

  /// Memproses permintaan logout.
  Future<void> signOut() async {
    _currentUser = null;
    final prefs = getIt<SharedPreferences>();
    // Hapus data sesi dari SharedPreferences.
    await prefs.remove(_loggedInUserKey);
  }

  /// Memproses permintaan registrasi pengguna baru.
  Future<void> register({required String username, required String password, required String fullName}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi jeda jaringan.
    if (_users.any((u) => u.username == username)) {
      throw 'Username sudah digunakan.';
    }
    
    final newUser = AppUser(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}', 
      username: username, 
      password: password, // Di aplikasi nyata, password harus di-hash dengan aman.
      fullName: fullName, 
      role: 'user', // Role default untuk pengguna baru.
    );
    _users.add(newUser);
  }

  // --- Metode untuk Manajemen Profil ---

  Future<void> updateProfilePicture(String url) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(profileImageUrl: url);
    }
  }

  Future<void> updateProfile({required String fullName}) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(fullName: fullName);
    }
  }

  Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    if (_currentUser == null || _currentUser!.password != oldPassword) {
      throw 'Password lama salah.';
    }
    _currentUser = _currentUser!.copyWith(password: newPassword);
  }

  // Daftar pengguna statis yang bertindak sebagai database pengguna palsu.
  static final List<AppUser> _users = [
    AppUser(id: 'admin', username: 'admin', password: 'admin123', fullName: 'Admin Ri-Kost', role: 'admin'),
    AppUser(id: 'user1', username: 'budi', password: 'password', fullName: 'Budi Santoso', role: 'tenant', roomId: 'A-101'),
    AppUser(id: 'user2', username: 'siti', password: 'password', fullName: 'Siti Aminah', role: 'tenant', roomId: 'A-103'),
    AppUser(id: 'user3', username: 'charlie', password: 'password', fullName: 'Charlie', role: 'tenant', roomId: 'B-201'),
    AppUser(id: 'user4', username: 'diana', password: 'password', fullName: 'Diana', role: 'tenant', roomId: 'B-202'),
    AppUser(id: 'user5', username: 'eko', password: 'password', fullName: 'Eko', role: 'user'),
  ];
}
