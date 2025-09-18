import 'package:flutter/material.dart';
import 'package:tes/shared/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    final user = AuthService.currentUser;
    String initialName = '';
    if (user != null) {
      if (user.role == 'admin') {
        initialName = 'Admin Indra';
      } else {
        initialName = user.fullName ?? user.username;
      }
    }
    _nameCtrl = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _showChangePasswordDialog() async {
    final formKey = GlobalKey<FormState>();
    final oldPasswordCtrl = TextEditingController();
    final newPasswordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Simpan'),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);

                try {
                  await AuthService.changePassword(
                    oldPassword: oldPasswordCtrl.text,
                    newPassword: newPasswordCtrl.text,
                  );
                  navigator.pop(); // Tutup dialog
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Password berhasil diubah'), backgroundColor: Colors.green),
                  );
                } catch (e) {
                  navigator.pop(); // Tutup dialog
                  messenger.showSnackBar(
                    SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: "Nama"),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () async {
                    await AuthService.updateProfile(fullName: _nameCtrl.text.trim());
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profil diperbarui")),
                    );
                  },
                  child: const Text("Simpan Nama"),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.lock_outline),
                  label: const Text("Ubah Password"),
                  onPressed: _showChangePasswordDialog,
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await AuthService.signOut();
                    navigator.pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
