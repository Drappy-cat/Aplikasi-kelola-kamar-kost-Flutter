part of 'chat_bloc.dart';

@freezed
abstract class ChatEvent with _$ChatEvent {
  // Event untuk memuat percakapan untuk pengguna tertentu
  const factory ChatEvent.load(String userId) = LoadChat;

  // PERBAIKAN: Menghapus parameter userId yang tidak perlu
  const factory ChatEvent.sendMessage(String text) = SendTextMessage;

  // PERBAIKAN: Menghapus parameter userId yang tidak perlu
  const factory ChatEvent.sendImage(String imageUrl) = SendImageMessage;
}
