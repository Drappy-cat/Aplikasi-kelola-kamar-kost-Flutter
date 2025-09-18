import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';
import 'dummy_service.dart';

class AuthService {
  static const _kUsers = 'auth_users';
  static const _kCurrent = 'auth_current_user';

  static List<AppUser> _users = [
    AppUser(username: 'admin', password: 'admin123', role: 'admin', fullName: 'Pemilik Kost'),
  ];

  static AppUser? currentUser;

  static Future<void> init() async {
    final sp = await SharedPreferences.getInstance();
    final usersStr = sp.getString(_kUsers);
    if (usersStr != null) {
      final list = (jsonDecode(usersStr) as List).cast<Map<String, dynamic>>();
      _users = list.map(AppUser.fromJson).toList();
    }
    final currStr = sp.getString(_kCurrent);
    if (currStr != null) {
      currentUser = AppUser.fromJson(jsonDecode(currStr));
    }
  }

  static Future<void> _persist() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kUsers, jsonEncode(_users.map((e) => e.toJson()).toList()));
    if (currentUser != null) {
      await sp.setString(_kCurrent, jsonEncode(currentUser!.toJson()));
    } else {
      await sp.remove(_kCurrent);
    }
  }

  static Future<void> signOut() async {
    currentUser = null;
    await _persist();
  }

  static Future<AppUser> register({
    required String username,
    required String password,
    required String role,
    String? fullName,
  }) async {
    final exists = _users.any((u) => u.username.toLowerCase() == username.toLowerCase());
    if (exists) {
      throw Exception('Username sudah dipakai');
    }
    final user = AppUser(
      username: username,
      password: password,
      role: role,
      fullName: fullName,
    );
    _users.add(user);
    await _persist();
    return user;
  }

  static Future<AppUser> signIn({
    required String username,
    required String password,
  }) async {
    final user = _users.firstWhere(
          (u) => u.username.toLowerCase() == username.toLowerCase() && u.password == password,
      orElse: () => throw Exception('Username / password salah'),
    );
    currentUser = user;
    await _persist();
    DummyService.userName = user.fullName?.isNotEmpty == true ? user.fullName : user.username;
    return user;
  }

  static Future<void> updateProfile({String? fullName}) async {
    if (currentUser == null) return;
    final updatedUser = AppUser(
      username: currentUser!.username,
      password: currentUser!.password,
      role: currentUser!.role,
      fullName: fullName,
      profileImageUrl: currentUser!.profileImageUrl, // Pertahankan gambar profil
    );
    final userIndex = _users.indexWhere((u) => u.username == currentUser!.username);
    if (userIndex != -1) {
      _users[userIndex] = updatedUser;
    }
    currentUser = updatedUser;
    await _persist();
    if (fullName != null && fullName.isNotEmpty) {
      DummyService.userName = fullName;
    } else {
      DummyService.userName = currentUser!.username;
    }
  }

  static Future<void> changePassword({required String oldPassword, required String newPassword}) async {
    if (currentUser == null) {
      throw Exception('Tidak ada pengguna yang sedang login');
    }
    if (currentUser!.password != oldPassword) {
      throw Exception('Password lama salah');
    }
    final userIndex = _users.indexWhere((u) => u.username == currentUser!.username);
    if (userIndex != -1) {
      final oldUser = _users[userIndex];
      _users[userIndex] = AppUser(
        username: oldUser.username,
        password: newPassword,
        role: oldUser.role,
        fullName: oldUser.fullName,
        profileImageUrl: oldUser.profileImageUrl, // Pertahankan gambar profil
      );
      currentUser = _users[userIndex];
      await _persist();
    } else {
      throw Exception('Pengguna tidak ditemukan');
    }
  }

  // DIUBAH: Menambahkan fungsi ganti foto profil
  static Future<void> updateProfilePicture(String imageUrl) async {
    if (currentUser == null) return;

    final updatedUser = AppUser(
      username: currentUser!.username,
      password: currentUser!.password,
      role: currentUser!.role,
      fullName: currentUser!.fullName,
      profileImageUrl: imageUrl, // Ganti dengan URL gambar baru
    );

    final userIndex = _users.indexWhere((u) => u.username == currentUser!.username);
    if (userIndex != -1) {
      _users[userIndex] = updatedUser;
    }
    currentUser = updatedUser;
    await _persist();
  }
}
