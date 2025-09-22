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
      // --- PERUBAHAN STRUKTUR BODY ---
      // Menggunakan Column agar bisa menempatkan copyright di bawah ListView
      body: Column(
        children: [
          // Expanded memastikan ListView mengambil semua ruang yang tersedia
          Expanded(
            child: ListView(
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
                      applicationName: 'Ri-Kost', // Nama aplikasi diupdate
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2025 Rizma Indra', // Copyright diupdate
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
              ],
            ),
          ),

          // --- BAGIAN COPYRIGHT DI SINI ---
          // Padding untuk memberi sedikit ruang
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'by Rizma Indra © 2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600], // Warna abu-abu agar tidak terlalu mencolok
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
