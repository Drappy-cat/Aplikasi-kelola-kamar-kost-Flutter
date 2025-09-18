import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'home_screen.dart';        // admin
import 'user_home_screen.dart';   // user

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    await AuthService.init();           // load user & session
    if (!mounted) return;
    setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = AuthService.currentUser;
    if (user == null) {
      // belum login → arahkan ke login
      return const _LoginRedirect();
    }

    if (user.role == 'admin') {
      return const HomeScreen();        // panel admin
    } else {
      return const UserHomeScreen();    // panel user
    }
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    // supaya kompatibel dgn route '/login' yg kamu punya
    // kalau tak ada, tukar ke screen login langsung.
    Future.microtask(() => Navigator.pushReplacementNamed(context, '/login'));
    return const Scaffold(body: SizedBox.shrink());
  }
}
