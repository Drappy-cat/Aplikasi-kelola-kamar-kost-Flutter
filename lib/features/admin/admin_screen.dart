
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: ListView.builder(
        itemCount: 0, // Replace with actual data length
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('User Input'), // Replace with actual data
          );
        },
      ),
    );
  }
}
