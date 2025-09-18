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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 900;
            final card = AuthCard(
              wide: wide,
              left: const AnimatedLeftPanel(bubbleCount: 220),
              right: RightForm(
                title: 'Create Account',
                subtitle: 'Daftar untuk mulai menggunakan aplikasi',
                form: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Wajib diisi' : null,
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
                        validator: (v) =>
                        (v == null || v.length < 6) ? 'Min. 6 karakter' : null,
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
              ),
            );
            return Center(child: Padding(padding: const EdgeInsets.all(20), child: card));
          },
        ),
      ),
    );
  }
}
