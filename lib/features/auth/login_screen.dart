// ===== 2. HALAMAN LOGIN =====
// Halaman ini berfungsi sebagai gerbang masuk bagi pengguna yang sudah memiliki akun.
// Pengguna memasukkan username dan password, yang kemudian akan diverifikasi oleh `AuthService`.

import 'package:flutter/material.dart';
import 'package:tes/shared/widgets/auth_ui.dart';
import 'package:tes/shared/services/auth_service.dart';

// ===== 7. INHERITANCE (Pewarisan) =====
// `LoginScreen` adalah turunan (subclass) dari `StatefulWidget`.
// Ini berarti `LoginScreen` mewarisi semua sifat dan perilaku dari `StatefulWidget`,
// memungkinkannya untuk memiliki state (data internal) yang bisa berubah seiring waktu.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // GlobalKey digunakan untuk mengidentifikasi Form dan melakukan validasi.
  final _formKey = GlobalKey<FormState>();
  // TextEditingController digunakan untuk mengelola input dari TextFormField.
  final _u = TextEditingController();
  final _p = TextEditingController();
  bool _hide = true; // State untuk menyembunyikan/menampilkan password
  bool _loading = false; // State untuk menampilkan indikator loading saat proses login

  @override
  void dispose() {
    // Penting untuk melepaskan controller saat widget tidak lagi digunakan
    // untuk mencegah kebocoran memori (memory leak).
    _u.dispose();
    _p.dispose();
    super.dispose();
  }

  // Fungsi untuk menangani logika saat tombol LOGIN ditekan
  Future<void> _handleLogin() async {
    // 1. Validasi form: jika ada input yang tidak valid, proses berhenti.
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true); // Tampilkan loading

    try {
      // 2. Panggil service autentikasi untuk memverifikasi kredensial.
      await AuthService.signIn(username: _u.text.trim(), password: _p.text.trim());
      if (!mounted) return;

      // 3. Jika berhasil, arahkan pengguna ke halaman utama ('/home').
      //    `pushNamedAndRemoveUntil` menghapus semua halaman sebelumnya sehingga pengguna
      //    tidak bisa kembali ke halaman login dengan menekan tombol "back".
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      // 4. Jika gagal, tampilkan pesan error menggunakan SnackBar.
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      // 5. Apapun hasilnya (berhasil atau gagal), hentikan loading.
      if (mounted) setState(() => _loading = false);
    }
  }

  // ===== 8. POLYMORPHISM (Polimorfisme) =====
  // Metode `build` ini adalah contoh polimorfisme. `_LoginScreenState` "meng-override"
  // (menimpa) metode `build` yang ada di kelas induknya (`State`).
  // Ini memungkinkan `_LoginScreenState` untuk menyediakan implementasi spesifiknya sendiri
  // tentang bagaimana UI harus dirender, meskipun kerangka dasarnya sama.
  @override
  Widget build(BuildContext context) {
    // ... (kode UI untuk halaman login)
    final isRegistered = ModalRoute.of(context)?.settings.arguments as Map<String, bool>?;
    if (isRegistered?['registered'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
        );
      });
    }

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

  // Widget terpisah untuk membangun form di sisi kanan
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
