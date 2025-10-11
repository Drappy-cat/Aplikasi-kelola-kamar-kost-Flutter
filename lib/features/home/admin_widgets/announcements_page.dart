import 'package:flutter/material.dart';
import 'package:tes/shared/models/announcement.dart';

class AnnouncementsPage extends StatelessWidget {
  final List<Announcement> announcements;
  const AnnouncementsPage({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    if (announcements.isEmpty) {
      return const Center(
        child: Text('Belum ada pengumuman yang dibuat.', style: TextStyle(color: Colors.grey)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(announcement.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(announcement.content),
          ),
        );
      },
    );
  }
}
