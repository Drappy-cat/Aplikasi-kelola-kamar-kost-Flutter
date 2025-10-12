import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/bloc/admin_panel_bloc.dart';
import 'package:tes/shared/models/chat_conversation.dart';

class AdminChatListScreen extends StatelessWidget {
  const AdminChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan BlocBuilder untuk mendapatkan state terbaru dari AdminPanelBloc
    return BlocBuilder<AdminPanelBloc, AdminPanelState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.conversations.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada pesan masuk.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.conversations.length,
          itemBuilder: (context, index) {
            final conversation = state.conversations[index];
            final lastMessage = conversation.messages.isNotEmpty
                ? conversation.messages.first
                : null;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(conversation.userName[0].toUpperCase()),
                ),
                title: Text(conversation.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  lastMessage?.text ?? (lastMessage?.imageUrl != null ? '[Gambar]' : 'Tidak ada pesan'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigasi ke halaman chat spesifik untuk pengguna ini
                  context.push('${AppRoutes.chat}/${conversation.userId}');
                },
              ),
            );
          },
        );
      },
    );
  }
}
