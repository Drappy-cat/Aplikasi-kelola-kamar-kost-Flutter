part of 'chat_bloc.dart';

@freezed
abstract class ChatEvent with _$ChatEvent {
  // Event untuk memuat percakapan untuk pengguna tertentu
  const factory ChatEvent.load(String userId) = LoadChat;

  // Event untuk mengirim pesan teks
  const factory ChatEvent.sendMessage(String text) = SendTextMessage;

  // Event untuk mengirim pesan gambar
  const factory ChatEvent.sendImage(String imageUrl) = SendImageMessage;
}
