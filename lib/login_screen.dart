import 'package:flutter/material.dart';
import 'auth_ui.dart';

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
  bool _registeredToastShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_registeredToastShown) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args['registered'] == true) {
        _registeredToastShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi berhasil. Silakan login.')),
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _u.dispose();
    _p.dispose();
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
                title: 'Sign In',
                subtitle: 'Masuk untuk melanjutkan',
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
                              // TODO: validasi akun (API/DB)
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: const Text('CONTINUE'),
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
