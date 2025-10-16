import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/settings/bloc/settings_bloc.dart';
import 'package:tes/l10n/app_localizations.dart';
import 'package:tes/shared/services/language_service.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

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

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showLanguageDialog(BuildContext context) {
    final languageService = getIt<LanguageService>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Locale>(
              title: const Text('English'),
              value: const Locale('en'),
              groupValue: languageService.locale,
              onChanged: (locale) {
                if (locale != null) languageService.setLocale(locale);
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<Locale>(
              title: const Text('Bahasa Indonesia'),
              value: const Locale('id'),
              groupValue: languageService.locale,
              onChanged: (locale) {
                if (locale != null) languageService.setLocale(locale);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeService = getIt<ThemeService>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionHeader(context, l10n.appearance),
              _buildSettingsCard(
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: themeService,
                      builder: (context, child) {
                        return ListTile(
                          leading: const Icon(Icons.brightness_6_outlined),
                          title: Text(l10n.darkMode),
                          trailing: Switch(
                            value: themeService.isDarkMode,
                            onChanged: (value) => themeService.toggleTheme(),
                          ),
                          onTap: () => themeService.toggleTheme(),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.language_outlined),
                      title: Text(l10n.language),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showLanguageDialog(context),
                    ),
                  ],
                ),
              ),
              _buildSectionHeader(context, l10n.deviceInformation),
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
              _buildSectionHeader(context, l10n.application),
              _buildSettingsCard(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: const Text('Pusat Bantuan'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(AppRoutes.help),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    // PERBAIKAN: Mengarahkan ke halaman AboutAppScreen yang baru.
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(l10n.aboutApp),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(AppRoutes.aboutApp),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: Text(l10n.termsAndConditions),
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
