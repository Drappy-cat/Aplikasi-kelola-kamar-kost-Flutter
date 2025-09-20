import 'package:flutter/material.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Panel'),
      ),
      body: const Center(
        child: Text('Welcome, User!'),
      ),
    );
  }
}
