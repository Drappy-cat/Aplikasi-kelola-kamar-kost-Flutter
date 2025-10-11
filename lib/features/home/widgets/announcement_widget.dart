import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/shared/models/announcement.dart';

class AnnouncementWidget extends StatelessWidget {
  final Announcement latestAnnouncement;

  const AnnouncementWidget({super.key, required this.latestAnnouncement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.announcements),
        child: Card(
          elevation: 3,
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.campaign, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    latestAnnouncement.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Text(
                  latestAnnouncement.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Lihat Semua Pengumuman',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().fade(duration: 500.ms).slideY(begin: -0.2, end: 0),
    );
  }
}
