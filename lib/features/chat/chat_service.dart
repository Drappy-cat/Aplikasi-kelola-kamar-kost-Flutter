import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tes/features/chat/message.dart';

// --- CHAT SERVICE PALSU (MOCK) ---
// Kelas ini mensimulasikan pengiriman dan penerimaan pesan
// tanpa menggunakan database online (Firebase).

class ChatService extends ChangeNotifier {
  // ID palsu untuk user yang sedang menggunakan aplikasi
  static const String currentUserId = 'user_id_001';
  static const String currentUsername = 'Rizma Indra';

  final List<Message> _messages = [];
  final _messageController = StreamController<List<Message>>.broadcast();

  // Stream untuk didengarkan oleh UI
  Stream<List<Message>> get messagesStream => _messageController.stream;

  ChatService() {
    // Menambahkan beberapa pesan awal untuk simulasi
    _messages.addAll([
      Message(
        senderId: 'admin_id_001',
        senderUsername: 'Admin',
        receiverId: currentUserId,
        text: 'Halo, ada yang bisa saya bantu?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Message(
        senderId: currentUserId,
        senderUsername: currentUsername,
        receiverId: 'admin_id_001',
        text: 'Ya, halo. Saya ingin bertanya tentang tagihan bulan ini.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
    ]);
    _messageController.add(_messages);
  }

  // Fungsi untuk mengirim pesan (hanya menambah ke daftar lokal)
  Future<void> sendMessage(String receiverId, String text) async {
    final newMessage = Message(
      senderId: currentUserId,
      senderUsername: currentUsername,
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
    );

    _messages.add(newMessage);
    _messageController.add(_messages); // Memberi tahu UI bahwa ada data baru
    notifyListeners();

    // Simulasi balasan otomatis dari admin setelah 2 detik
    if (receiverId == 'admin_id_001') {
      Future.delayed(const Duration(seconds: 2), () {
        final autoReply = Message(
          senderId: 'admin_id_001',
          senderUsername: 'Admin',
          receiverId: currentUserId,
          text: 'Baik, akan segera kami cek. Mohon ditunggu.',
          timestamp: DateTime.now(),
        );
        _messages.add(autoReply);
        _messageController.add(_messages);
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _messageController.close();
    super.dispose();
  }
}
