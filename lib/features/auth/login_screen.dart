import 'package:flutter/material.dart';
import 'package:tes/shared/widgets/auth_ui.dart';
import 'package:tes/shared/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _u = TextEditingController();
  final _p = TextEditingController();
  bool _hide = true;
  bool _loading = false;
  // DIUBAH: Menambahkan state untuk switch pilihan peran
  bool _loginAsAdmin = false;

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final user = await AuthService.signIn(username: _u.text.trim(), password: _p.text.trim());
      if (!mounted) return;

      // DIUBAH: Logika navigasi berdasarkan pilihan peran
      if (_loginAsAdmin) {
        if (user.role == 'admin') {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          // Jika mencoba login sebagai admin tapi bukan admin, tampilkan error dan logout
          await AuthService.signOut();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Anda tidak memiliki akses admin.'), backgroundColor: Colors.red),
          );
        }
      } else {
        // Login sebagai user biasa
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRegistered = ModalRoute.of(context)?.settings.arguments as Map<String, bool>?;
    if (isRegistered?['registered'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
        );
      });
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 900;
            final card = AuthCard(
              wide: wide,
              left: const AnimatedLeftPanel(),
              right: RightForm(
                title: 'Welcome Back',
                subtitle: 'Login untuk melanjutkan',
                form: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),
                      // DIUBAH: Menambahkan SwitchListTile untuk memilih peran
                      SwitchListTile(
                        title: const Text('Login sebagai Admin'),
                        value: _loginAsAdmin,
                        onChanged: (bool value) {
                          setState(() {
                            _loginAsAdmin = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _handleLogin,
                          child: _loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Text('LOGIN'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum punya akun?'),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            child: const Text('Daftar di sini'),
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
