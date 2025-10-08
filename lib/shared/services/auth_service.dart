import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/locator.dart';

class AuthService {
  static const String _loggedInUserKey = 'loggedInUsername';

  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  set currentUser(AppUser? user) {
    _currentUser = user;
  }

  Future<void> init() async {
    final prefs = getIt<SharedPreferences>();
    final username = prefs.getString(_loggedInUserKey);
    if (username != null) {
      try {
        _currentUser = _users.firstWhere((user) => user.username == username);
      } catch (e) {
        _currentUser = null;
      }
    }
  }

  Future<void> signIn({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final user = _users.firstWhere((u) => u.username == username && u.password == password);
      _currentUser = user;

      final prefs = getIt<SharedPreferences>();
      await prefs.setString(_loggedInUserKey, user.username);
    } catch (e) {
      throw 'Username atau password salah.';
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    final prefs = getIt<SharedPreferences>();
    await prefs.remove(_loggedInUserKey);
  }

  // --- FUNGSI REGISTER YANG DIPERBAIKI ---
  Future<void> register({required String username, required String password, required String fullName}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.any((u) => u.username == username)) {
      throw 'Username sudah digunakan.';
    }
    
    // PERBAIKAN: Membuat dan menambahkan user baru ke dalam list
    final newUser = AppUser(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}', 
      username: username, 
      password: password, // Di aplikasi nyata, password harus di-hash
      fullName: fullName, 
      role: 'user', // Role default untuk user baru
    );
    _users.add(newUser);
  }

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

  // Mengubah dari final menjadi non-final agar bisa ditambahkan
  static final List<AppUser> _users = [
    AppUser(id: 'admin', username: 'admin', password: 'admin', fullName: 'Admin Ri-Kost', role: 'admin'),
    AppUser(id: 'user1', username: 'budi', password: 'password', fullName: 'Budi Santoso', role: 'tenant', roomId: 'A-101'),
    AppUser(id: 'user2', username: 'siti', password: 'password', fullName: 'Siti Aminah', role: 'tenant', roomId: 'A-103'),
    AppUser(id: 'user3', username: 'charlie', password: 'password', fullName: 'Charlie', role: 'tenant', roomId: 'B-201'),
    AppUser(id: 'user4', username: 'diana', password: 'password', fullName: 'Diana', role: 'tenant', roomId: 'B-202'),
    AppUser(id: 'user5', username: 'eko', password: 'password', fullName: 'Eko', role: 'user'),
  ];
}
