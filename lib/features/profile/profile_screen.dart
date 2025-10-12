import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/profile/bloc/profile_bloc.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/locator.dart';
import 'package:tes/shared/services/theme_service.dart';

// Halaman wrapper yang menyediakan BLoC
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const ProfileEvent.load()),
      child: const ProfileView(),
    );
  }
}

// Widget yang membangun UI
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      // Listener untuk aksi yang terjadi sekali (navigasi, snackbar)
      listener: (context, state) {
        if (state.loggedOut) {
          context.go(AppRoutes.login);
        }
        if (state.passwordChangeSuccess != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.passwordChangeSuccess!),
            backgroundColor: Colors.green,
          ));
        }
        if (state.passwordChangeError != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.passwordChangeError!),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil Saya'),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.isLoading || state.user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            final user = state.user!;
            return _buildProfileBody(context, user);
          },
        ),
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context, AppUser user) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeService = getIt<ThemeService>();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      children: [
        _buildProfileHeader(context, user, colorScheme),
        const SizedBox(height: 24),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _ProfileMenuTile(
                icon: Icons.edit_outlined,
                title: 'Edit Profil',
                onTap: () => _showEditProfileDialog(context, user.fullName),
              ),
              _ProfileMenuTile(
                icon: Icons.lock_outline,
                title: 'Ubah Password',
                onTap: () => _showChangePasswordDialog(context),
              ),
              _ProfileMenuTile(
                icon: Icons.receipt_long_outlined,
                title: 'Riwayat Pembayaran',
                onTap: () => context.push(AppRoutes.paymentHistory),
              ),
              _ProfileMenuTile(
                icon: Icons.description_outlined,
                title: 'Syarat & Ketentuan',
                onTap: () => context.push(AppRoutes.terms),
              ),
              // ITEM MENU BARU: Pusat Bantuan
              _ProfileMenuTile(
                icon: Icons.help_outline,
                title: 'Pusat Bantuan',
                onTap: () => context.push(AppRoutes.help),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              AnimatedBuilder(
                animation: themeService,
                builder: (context, child) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        themeService.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(themeService.isDarkMode ? 'Mode Terang' : 'Mode Gelap', style: const TextStyle(fontSize: 16)),
                    trailing: Switch(
                      value: themeService.isDarkMode,
                      onChanged: (value) => themeService.toggleTheme(),
                    ),
                    onTap: () => themeService.toggleTheme(),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.1),
              child: const Icon(Icons.logout, color: Colors.red),
            ),
            title: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 16)),
            onTap: () => context.read<ProfileBloc>().add(const ProfileEvent.logout()),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, AppUser user, ColorScheme colorScheme) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showChangePictureDialog(context),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: user.profileImageUrl != null ? CachedNetworkImageProvider(user.profileImageUrl!) : null,
            backgroundColor: user.profileImageUrl == null ? colorScheme.primaryContainer : Colors.transparent,
            child: user.profileImageUrl == null
                ? Icon(Icons.person, size: 50, color: colorScheme.onPrimaryContainer)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(user.fullName ?? user.username, style: Theme.of(context).textTheme.headlineSmall),
        Text('@${user.username}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
      ],
    );
  }

  // --- Dialog-dialog --- //

  Future<void> _showChangePictureDialog(BuildContext context) async {
    final List<String> avatarUrls = [
      'https://i.pravatar.cc/150?img=1',
      'https://i.pravatar.cc/150?img=5',
      'https://i.pravatar.cc/150?img=10',
      'https://i.pravatar.cc/150?img=15',
      'https://i.pravatar.cc/150?img=20',
      'https://i.pravatar.cc/150?img=25',
    ];

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pilih Foto Profil'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: avatarUrls.map((url) {
            return InkWell(
              onTap: () {
                context.read<ProfileBloc>().add(ProfileEvent.updateProfilePicture(url));
                context.pop();
              },
              child: CircleAvatar(radius: 30, backgroundImage: CachedNetworkImageProvider(url)),
            );
          }).toList(),
        ),
        actions: [TextButton(onPressed: () => context.pop(), child: const Text('Batal'))],
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context, String? currentName) async {
    final nameController = TextEditingController(text: currentName ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Nama Lengkap'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Nama Lengkap'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('Batal')),
          FilledButton(
            onPressed: () => context.pop(true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    ) ?? false;

    if (ok && nameController.text.isNotEmpty) {
      context.read<ProfileBloc>().add(ProfileEvent.updateFullName(nameController.text.trim()));
    }
  }

  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final oldPasswordCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah Password'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: oldPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password Lama'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: newPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password Baru'),
                validator: (v) => (v == null || v.length < 6) ? 'Min. 6 karakter' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: confirmPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Konfirmasi Password Baru'),
                validator: (v) => (v != newPasswordCtrl.text) ? 'Password tidak cocok' : null,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
          BlocBuilder<ProfileBloc, ProfileState>(
            bloc: context.read<ProfileBloc>(),
            builder: (context, state) {
              return FilledButton(
                onPressed: state.isPasswordChangeLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          context.read<ProfileBloc>().add(ProfileEvent.changePassword(
                                oldPassword: oldPasswordCtrl.text,
                                newPassword: newPasswordCtrl.text,
                              ));
                        }
                      },
                child: state.isPasswordChangeLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Simpan'),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget kustom untuk menu di halaman profil
class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(icon, color: colorScheme.onPrimaryContainer),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
