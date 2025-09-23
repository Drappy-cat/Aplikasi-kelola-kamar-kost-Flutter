import 'package:flutter/material.dart';
import 'package:tes/shared/widgets/auth_ui.dart';
import 'package:tes/shared/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _u = TextEditingController();
  final _p = TextEditingController();
  final _p2 = TextEditingController();
  bool _hide = true;
  bool _loading = false;

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
    _p2.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      // Panggil fungsi register dengan parameter yang sudah diperbaiki
      await AuthService.register(
        username: _u.text.trim(),
        password: _p.text.trim(),
        fullName: _u.text.trim(), // Default fullName diisi dengan username
      );
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
        arguments: {'registered': true},
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Center(
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

  Widget _buildRightForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 40),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Buat Akun Baru', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Isi data untuk mendaftar', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 28),
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
              obscureText: _hide,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _hide = !_hide),
                  icon: Icon(_hide ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Password minimal 6 karakter' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _p2,
              obscureText: _hide,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Konfirmasi Password',
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Wajib diisi';
                if (v != _p.text) return 'Password tidak cocok';
                return null;
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
                    : const Text('DAFTAR'),
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
