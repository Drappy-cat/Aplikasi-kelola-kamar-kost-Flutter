import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/settings/bloc/settings_bloc.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

// Halaman wrapper yang menyediakan BLoC
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(const SettingsEvent.loadDeviceInfo()),
      child: const SettingsView(),
    );
  }
}

// Widget yang membangun UI
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
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
                child: state.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : state.error != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: Text(state.error!)),
                          )
                        : Column(
                            children: state.deviceInfo.entries.map((entry) {
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
                      onTap: () => context.push(AppRoutes.terms),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
