import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart'; // <-- IMPORT
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, String> _deviceInfo = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> info = {};

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        info = {
          'Model Perangkat': '${androidInfo.manufacturer.toUpperCase()} ${androidInfo.model}',
          'Sistem Operasi': 'Android ${androidInfo.version.release}',
          'Pabrikan': androidInfo.manufacturer,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        info = {
          'Model Perangkat': iosInfo.name ?? 'N/A',
          'Sistem Operasi': '${iosInfo.systemName} ${iosInfo.systemVersion}',
          'Pabrikan': 'Apple',
        };
      }
    } catch (e) {
      info = {'Error': 'Gagal memuat info perangkat'};
    }

    if (mounted) {
      setState(() {
        _deviceInfo = info;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
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
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader(context, 'Tampilan'),
          _buildSettingsCard(
            child: AnimatedBuilder(
              animation: themeService,
              builder: (context, child) {
                return ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  title: const Text('Mode Gelap'),
                  trailing: Switch(
                    value: themeService.isDarkMode,
                    onChanged: (value) => themeService.toggleTheme(),
                  ),
                  onTap: () => themeService.toggleTheme(),
                );
              },
            ),
          ),

          _buildSectionHeader(context, 'Informasi Perangkat'),
          _buildSettingsCard(
            child: _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: _deviceInfo.entries.map((entry) {
                      return _buildInfoTile(entry.key, entry.value);
                    }).toList(),
                  ),
          ),

          _buildSectionHeader(context, 'Aplikasi'),
          _buildSettingsCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang Aplikasi'),
                  subtitle: const Text('Versi 1.0.0'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Ri-Kost',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2025 Rizma Indra',
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text('Aplikasi manajemen kost sederhana.'),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Syarat & Ketentuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.terms), // <-- GANTI
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _buildInfoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
    );
  }
}
