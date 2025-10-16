import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';

/// Widget ini adalah menu geser (Drawer) kustom yang akan digunakan di seluruh aplikasi.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    final user = authService.currentUser;

    // Jika tidak ada pengguna, tampilkan drawer kosong (seharusnya tidak pernah terjadi jika sudah login)
    if (user == null) {
      return const Drawer();
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header yang menampilkan informasi pengguna
          UserAccountsDrawerHeader(
            accountName: Text(
              user.fullName ?? user.username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text('@${user.username}'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.profileImageUrl != null ? NetworkImage(user.profileImageUrl!) : null,
              child: user.profileImageUrl == null ? const Icon(Icons.person, size: 40) : null,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // --- Menu Utama ---
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit Profil'),
            onTap: () {
              // TODO: Buat halaman Edit Profil terpisah yang berisi ganti gambar, nama, dan password.
              // Untuk saat ini, kita arahkan ke halaman profil yang sudah ada.
              context.push(AppRoutes.profile);
              Navigator.of(context).pop(); // Tutup drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('Riwayat Pembayaran'),
            onTap: () {
              context.push(AppRoutes.paymentHistory);
              Navigator.of(context).pop();
            },
          ),
          const Divider(),

          // --- Menu Bantuan & Informasi ---
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Pusat Bantuan'),
            onTap: () {
              context.push(AppRoutes.help);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Syarat & Ketentuan'),
            onTap: () {
              context.push(AppRoutes.terms);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              context.push(AppRoutes.settings);
              Navigator.of(context).pop();
            },
          ),
          const Divider(),

          // --- Tombol Logout ---
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade700),
            title: Text('Logout', style: TextStyle(color: Colors.red.shade700)),
            onTap: () async {
              await authService.signOut();
              if (context.mounted) {
                // Arahkan ke halaman login dan hapus semua halaman sebelumnya
                context.go(AppRoutes.login);
              }
            },
          ),
        ],
      ),
    );
  }
}
