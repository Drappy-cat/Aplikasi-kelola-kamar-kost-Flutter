import 'package:flutter/material.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Gunakan AnimatedBuilder agar UI-nya update saat tema berganti
                AnimatedBuilder(
                  animation: themeService,
                  builder: (context, child) {
                    return ListTile(
                      title: const Text('Mode Tema'),
                      subtitle: Text(themeService.isDarkMode ? 'Dark Mode' : 'Light Mode'),
                      trailing: IconButton(
                        icon: Icon(
                          themeService.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        // Panggil toggleTheme dari service
                        onPressed: () => themeService.toggleTheme(),
                      ),
                    );
                  },
                ),
                const Divider(),

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'by Rizma Indra © 2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
