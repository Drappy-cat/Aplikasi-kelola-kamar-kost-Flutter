// ===== 3. HOME SCREEN (ROUTER) =====
// Ini adalah halaman utama setelah pengguna berhasil login.
// Fungsinya bukan untuk menampilkan UI secara langsung, melainkan sebagai "router" atau "pemandu".
// Berdasarkan peran (role) pengguna yang sedang login, halaman ini akan memutuskan
// untuk menampilkan `AdminPanel` atau `UserHomePage`.

import 'package:flutter/material.dart';
import 'package:tes/features/home/admin_panel.dart';
import 'package:tes/features/home/user_home_page.dart';
import 'package:tes/shared/services/auth_service.dart';

// ===== 7. INHERITANCE (Pewarisan) =====
// `HomeScreen` adalah turunan dari `StatelessWidget`.
// Berbeda dengan `StatefulWidget`, `StatelessWidget` tidak memiliki state internal.
// Ini cocok untuk `HomeScreen` karena tugasnya hanya mengarahkan, tidak menyimpan data yang berubah.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ===== 8. POLYMORPHISM (Polimorfisme) =====
  // Metode `build` ini juga merupakan contoh polimorfisme.
  // `HomeScreen` menyediakan implementasinya sendiri tentang apa yang harus dirender.
  @override
  Widget build(BuildContext context) {
    // 1. Periksa peran (role) pengguna yang saat ini login dari `AuthService`.
    final bool isAdmin = AuthService.currentUser?.role == 'admin';

    // 2. Gunakan logika kondisional (if-else) untuk menentukan widget yang akan ditampilkan.
    if (isAdmin) {
      // Jika pengguna adalah admin, tampilkan AdminPanel.
      return const AdminPanel();
    } else {
      // Jika bukan admin (yaitu, pengguna biasa), tampilkan UserHomePage.
      return const UserHomePage();
    }
  }
}
