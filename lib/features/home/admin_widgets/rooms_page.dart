import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/room.dart';

class RoomsPage extends StatelessWidget {
  final List<Room> rooms;
  const RoomsPage({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${room.status}'),
                if (room.tenantName != null) Text('Penghuni: ${room.tenantName}'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              // Navigasi ke detail, lalu muat ulang data saat kembali
              await context.push(AppRoutes.roomDetail, extra: room);
              if (context.mounted) {
                context.read<AdminPanelBloc>().add(const AdminPanelEvent.loadData());
              }
            },
          ),
        );
      },
    );
  }
}
