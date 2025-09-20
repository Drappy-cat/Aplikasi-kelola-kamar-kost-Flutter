import 'package:flutter/material.dart';
import 'package:tes/shared/widgets/auth_ui.dart'; // Untuk gradStart, gradEnd, cardRadius, AnimatedLeftPanel
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
      await AuthService.signIn(username: _u.text.trim(), password: _p.text.trim());
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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

  Widget _buildRightForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 40, 36, 40),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome Back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Login untuk melanjutkan', style: TextStyle(color: Colors.grey)),
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
              validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 24),
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
    );
  }
}
