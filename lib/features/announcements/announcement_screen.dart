import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = getIt<DummyService>().getLatestAnnouncements();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: announcements.isEmpty
          ? const Center(child: Text('Tidak ada pengumuman.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat.yMMMMEEEEd().format(announcement.createdAt),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const Divider(height: 24),
                        Text(announcement.content),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
