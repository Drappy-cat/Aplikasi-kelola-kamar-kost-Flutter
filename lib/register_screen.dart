import 'package:flutter/material.dart';
import 'auth_ui.dart';

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
  bool _hide1 = true, _hide2 = true;

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
    _cp.dispose();
    super.dispose();
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gradEnd,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(cardRadius / 2),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: simpan akun (API/DB)
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                    (route) => false,
                                arguments: const {'registered': true},
                              );
                            }
                          },
                          child: const Text('CREATE ACCOUNT'),
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
