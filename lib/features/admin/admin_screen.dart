import 'package:flutter/material.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/auth_service.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil semua daftar pengguna
    final List<AppUser> users = AuthService.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.fullName ?? user.username),
            subtitle: Text('${user.username} (${user.role})'), // Tampilkan peran juga
          );
        },
      ),
    );
  }
}
