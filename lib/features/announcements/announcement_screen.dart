import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart'; // <-- IMPORT

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan instance DummyService dari GetIt
    final announcements = getIt<DummyService>().getLatestAnnouncements();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman'),
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
