import 'package:flutter/material.dart';
import 'package:tes/app/my_app.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Opsi Tema
          ListTile(
            title: const Text('Mode Tema'),
            subtitle: Text(Theme.of(context).brightness == Brightness.dark ? 'Dark Mode' : 'Light Mode'),
            trailing: IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () => MyApp.of(context)?.toggleTheme(),
            ),
          ),
          const Divider(),

          // Informasi Aplikasi
          ListTile(
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Versi 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Aplikasi Kost',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Nama Anda', // Ganti dengan nama Anda
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text('Aplikasi manajemen kost sederhana.'),
                  ),
                ],
              );
            },
          ),
          const Divider(),

          // Placeholder untuk pengaturan lainnya
          const ListTile(
            title: Text('Pengaturan Notifikasi'),
            subtitle: Text('Atur preferensi notifikasi Anda'),
            // TODO: Implementasi pengaturan notifikasi
          ),
          const Divider(),
          const ListTile(
            title: Text('Bantuan & Dukungan'),
            subtitle: Text('Hubungi kami atau lihat FAQ'),
            // TODO: Implementasi bantuan
          ),
          const Divider(),
        ],
      ),
    );
  }
}
