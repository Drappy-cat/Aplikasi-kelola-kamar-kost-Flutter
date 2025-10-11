import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tes/features/notification/bloc/notification_bloc.dart';

// Halaman wrapper yang menyediakan BLoC
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(const NotificationEvent.load()),
      child: const NotificationView(),
    );
  }
}

// Widget yang membangun UI
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          if (state.notifications.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada notifikasi baru.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notif = state.notifications[index];
              final bool isRead = notif.isRead;

              return ListTile(
                tileColor: isRead ? null : Theme.of(context).colorScheme.primary.withOpacity(0.05),
                leading: CircleAvatar(
                  backgroundColor: notif.iconColor.withOpacity(0.1),
                  child: Icon(notif.icon, color: notif.iconColor),
                ),
                title: Text(
                  notif.title,
                  style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold),
                ),
                subtitle: Text(notif.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: Text(
                  DateFormat.yMMMd().format(notif.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  // Kirim event ke BLoC untuk menandai sebagai telah dibaca
                  if (!isRead) {
                    context.read<NotificationBloc>().add(NotificationEvent.markAsRead(index));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
