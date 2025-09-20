import 'package:flutter/material.dart';
import 'package:tes/features/admin/admin_screen.dart';
import 'package:tes/features/home/user_home_page.dart';
import 'package:tes/shared/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = AuthService.currentUser?.role == 'admin';

    if (isAdmin) {
      return const AdminScreen();
    } else {
      return const UserHomePage();
    }
  }
}
