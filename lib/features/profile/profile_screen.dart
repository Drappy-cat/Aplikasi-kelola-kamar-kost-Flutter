import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/profile/bloc/profile_bloc.dart';
import 'package:tes/shared/models/app_user.dart';

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

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
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
          title: const Text('Profil'),
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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      children: [
        _buildProfileHeader(context, user),
        const SizedBox(height: 24),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _ProfileMenuTile(
                icon: Icons.badge_outlined,
                title: 'Ubah Nama Lengkap',
                onTap: () => _showEditProfileDialog(context, user.fullName),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _ProfileMenuTile(
                icon: Icons.contact_page_outlined,
                title: 'Ubah Info Kontak',
                onTap: () => _showEditContactDialog(context, user),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _ProfileMenuTile(
                icon: Icons.image_outlined,
                title: 'Ubah Foto Profil',
                onTap: () => _showChangePictureDialog(context),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _ProfileMenuTile(
                icon: Icons.lock_outline,
                title: 'Ubah Password',
                onTap: () => _showChangePasswordDialog(context),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              // DIPERBAIKI: Menggunakan rute 'settings' yang benar
              _ProfileMenuTile(
                icon: Icons.settings_outlined,
                title: 'Pengaturan & Info',
                onTap: () => context.go(AppRoutes.settings),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, AppUser user) {
    ImageProvider? backgroundImage;
    if (user.profileImageUrl != null) {
      if (user.profileImageUrl!.startsWith('/')) {
        backgroundImage = FileImage(File(user.profileImageUrl!));
      } else {
        backgroundImage = CachedNetworkImageProvider(user.profileImageUrl!);
      }
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => _showChangePictureDialog(context),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: backgroundImage,
            backgroundColor: backgroundImage == null ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
            child: backgroundImage == null
                ? Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.onPrimaryContainer)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(user.fullName ?? user.username, style: Theme.of(context).textTheme.headlineSmall),
        Text('@${user.username}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
      ],
    );
  }

  // --- Dialog-dialog (tidak ada perubahan di sini) ---

  Future<void> _showChangePictureDialog(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  _pickImage(context, ImageSource.gallery);
                  Navigator.of(builderContext).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Ambil Foto'),
                onTap: () {
                  _pickImage(context, ImageSource.camera);
                  Navigator.of(builderContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        context.read<ProfileBloc>().add(ProfileEvent.updateProfilePicture(image.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil gambar: $e'), backgroundColor: Colors.red),
        );
      }
    }
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

  Future<void> _showEditContactDialog(BuildContext context, AppUser user) async {
    final addressController = TextEditingController(text: user.address ?? '');
    final phoneController = TextEditingController(text: user.phoneNumber ?? '');
    final formKey = GlobalKey<FormState>();

    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ubah Info Kontak'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat Asal'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('Batal')),
          FilledButton(
            onPressed: () => context.pop(true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (ok == true) {
      context.read<ProfileBloc>().add(ProfileEvent.updateContactInfo(
            address: addressController.text.trim(),
            phoneNumber: phoneController.text.trim(),
          ));
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

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
