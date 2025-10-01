import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart'; // Import GetWidget
import 'package:go_router/go_router.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _showChangePictureDialog() async {
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
      builder: (context) => AlertDialog(
        title: const Text('Pilih Foto Profil'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: avatarUrls.map((url) {
            return InkWell(
              onTap: () async {
                await AuthService.updateProfilePicture(url);
                setState(() {}); // Refresh UI untuk menampilkan gambar baru
                context.pop();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(url), // Menggunakan CachedNetworkImageProvider
              ),
            );
          }).toList(),
        ),
        actions: [TextButton(onPressed: () => context.pop(), child: const Text('Batal'))],
      ),
    );
  }

  Future<void> _showEditProfileDialog() async {
    final nameController = TextEditingController(text: AuthService.currentUser?.fullName ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
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
      await AuthService.updateProfile(fullName: nameController.text.trim());
      setState(() {}); // Refresh UI untuk menampilkan nama baru
    }
  }

  Future<void> _showChangePasswordDialog() async {
    final formKey = GlobalKey<FormState>();
    final oldPasswordCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                validator: (v) => (v != newPasswordCtrl.text) ? 'Password tidak sama' : null,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
          FilledButton(
            child: const Text('Simpan'),
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              try {
                await AuthService.changePassword(oldPassword: oldPasswordCtrl.text, newPassword: newPasswordCtrl.text);
                if (mounted) context.pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password berhasil diubah'), backgroundColor: Colors.green));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppUser? user = AuthService.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text('Pengguna tidak ditemukan.')));

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          // --- BAGIAN HEADER PROFIL ---
          Column(
            children: [
              GestureDetector(
                onTap: _showChangePictureDialog,
                child: GFAvatar(
                  radius: 50,
                  backgroundImage: user.profileImageUrl != null ? CachedNetworkImageProvider(user.profileImageUrl!) : null,
                  child: user.profileImageUrl == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Text(user.fullName ?? user.username, style: Theme.of(context).textTheme.headlineSmall),
              Text('@${user.username}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 24),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.edit_outlined, color: colorScheme.onPrimaryContainer),
                  ),
                  title: const Text('Edit Profil', style: TextStyle(fontSize: 16)),
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: _showEditProfileDialog,
                ),
                GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.lock_outline, color: colorScheme.onPrimaryContainer),
                  ),
                  title: const Text('Ubah Password', style: TextStyle(fontSize: 16)),
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: _showChangePasswordDialog,
                ),
                GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.receipt_long_outlined, color: colorScheme.onPrimaryContainer),
                  ),
                  title: const Text('Riwayat Pembayaran', style: TextStyle(fontSize: 16)),
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => context.push('/payment_history'),
                ),
                GFListTile(
                  avatar: GFAvatar(
                    backgroundColor: colorScheme.primaryContainer,
                    child: Icon(Icons.description_outlined, color: colorScheme.onPrimaryContainer),
                  ),
                  title: const Text('Syarat & Ketentuan', style: TextStyle(fontSize: 16)),
                  icon: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => context.push('/terms'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- BAGIAN LOGOUT ---
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: GFListTile(
              avatar: GFAvatar(
                backgroundColor: Colors.red.withOpacity(0.1),
                child: const Icon(Icons.logout, color: Colors.red),
              ),
              title: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 16)),
              onTap: () async {
                await AuthService.signOut();
                if (mounted) context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
