import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/services/dummy_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = DummyService.notifications;
    notifications.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('Tidak ada notifikasi saat ini.', style: TextStyle(color: Colors.grey)),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: notif.iconColor.withOpacity(0.1),
                    child: Icon(notif.icon, color: notif.iconColor),
                  ),
                  title: Text(notif.title, style: TextStyle(fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Text(notif.subtitle),
                  trailing: Text(
                    DateFormat('dd MMM').format(notif.date),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    setState(() {
                      notif.isRead = true;
                    });
                  },
                );
              },
            ),
    );
  }
}
