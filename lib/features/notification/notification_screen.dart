import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart'; // <-- IMPORT

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Mengambil instance service dari GetIt
  final DummyService _dummyService = getIt<DummyService>();

  @override
  Widget build(BuildContext context) {
    final notifications = _dummyService.notifications;

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
              child: Text(
                'Tidak ada notifikasi baru.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                final bool isRead = notif.isRead;

                return ListTile(
                  tileColor: isRead ? null : Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  leading: CircleAvatar(
                    backgroundColor: notif.iconColor.withOpacity(0.1),
                    child: Icon(notif.icon, color: notif.iconColor),
                  ),
                  title: Text(notif.title, style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Text(notif.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text(
                    DateFormat.yMMMd().format(notif.date),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    if (!isRead) {
                      setState(() {
                        final updatedNotif = notif.copyWith(isRead: true);
                        _dummyService.notifications[index] = updatedNotif;
                        // Perubahan notifikasi juga perlu disimpan
                        // Kita akan menambahkan fungsi ini nanti di DummyService
                      });
                    }
                  },
                );
              },
            ),
    );
  }
}
