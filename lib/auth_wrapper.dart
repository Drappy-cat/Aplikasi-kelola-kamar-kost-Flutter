import 'package:flutter/material.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // nanti kalau sudah ada auth beneran, ganti logika ini
    return const LoginScreen();
  }
}
