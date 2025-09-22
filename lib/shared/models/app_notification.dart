import 'package:flutter/material.dart';

class AppNotification {
  final String title;
  final String subtitle;
  final DateTime date;
  final IconData icon;
  final Color iconColor;
  bool isRead;

  AppNotification({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    this.iconColor = Colors.blue,
    this.isRead = false,
  });
}
