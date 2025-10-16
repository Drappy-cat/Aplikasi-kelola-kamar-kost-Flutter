import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/chat_message.dart';

part 'chat_conversation.freezed.dart';
part 'chat_conversation.g.dart';

/// Model data untuk merepresentasikan satu percakapan utuh dengan seorang pengguna.
@freezed
class ChatConversation with _$ChatConversation {
  const factory ChatConversation({
    // ID unik untuk percakapan, biasanya sama dengan userId untuk kemudahan.
    required String id,
    // ID pengguna yang menjadi lawan bicara dalam percakapan ini.
    required String userId,
    // Nama pengguna untuk ditampilkan di UI daftar chat.
    required String userName,
    // Daftar semua pesan yang ada di dalam percakapan ini.
    required List<ChatMessage> messages,
  }) = _ChatConversation;

  /// Factory constructor untuk membuat instance ChatConversation dari JSON.
  factory ChatConversation.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationFromJson(json);
}
