import 'package:flutter/material.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/widgets/auth_ui.dart'; // Untuk gradStart, gradEnd, cardRadius, AnimatedLeftPanel

// VERSI FINAL: Perbaikan untuk masalah layout dan overflow.

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _u = TextEditingController();
  final _p = TextEditingController();
  final _cp = TextEditingController();
  final _name = TextEditingController();
  String _role = 'user';
  bool _hide1 = true, _hide2 = true;
  bool _loading = false;

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
    _cp.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (_p.text != _cp.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak cocok')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await AuthService.register(
        username: _u.text.trim(),
        password: _p.text.trim(),
        role: _role,
        fullName: _name.text.trim().isEmpty ? null : _name.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
        arguments: const {'registered': true},
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // DIUBAH TOTAL: Menggunakan struktur mandiri yang aman untuk scroll dan centering
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Center(
          // SingleChildScrollView dihapus dari sini
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
                child: LayoutBuilder(builder: (context, constraints) {
                  final bool wide = constraints.maxWidth >= 900;
                  if (wide) {
                    return Row(
                      children: [
                        const Expanded(child: AnimatedLeftPanel()),
                        Expanded(child: _buildRightForm()),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(child: AnimatedLeftPanel()),
                        Expanded(
                          child: SingleChildScrollView(
                            child: _buildRightForm(),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk panel formulir kanan
  Widget _buildRightForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 40),
      child: Form(
        key: _formKey,
        child: ListView(
          // ListView di sini akan menangani scroll jika kontennya melebihi tinggi
          shrinkWrap: true, // Penting agar ListView tidak mencoba mengambil tinggi tak terbatas
          children: [
            const Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Daftar untuk mulai menggunakan aplikasi', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 28),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.badge_outlined),
                labelText: 'Nama Lengkap (opsional)',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _u,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Username',
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _p,
              obscureText: _hide1,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _hide1 = !_hide1),
                  icon: Icon(_hide1 ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Min. 6 karakter' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cp,
              obscureText: _hide2,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_reset),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _hide2 = !_hide2),
                  icon: Icon(_hide2 ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (v) => (v != _p.text) ? 'Password tidak sama' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle_outlined),
                labelText: 'Role',
              ),
              items: const [
                DropdownMenuItem(value: 'user', child: Text('User')),
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _role = value);
                }
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : _handleRegister,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('CREATE ACCOUNT'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun?'),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Login di sini'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
