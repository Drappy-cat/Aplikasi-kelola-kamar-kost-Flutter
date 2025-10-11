import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/chat_message.dart';

part 'chat_conversation.freezed.dart';
part 'chat_conversation.g.dart';

@freezed
class ChatConversation with _$ChatConversation {
  const factory ChatConversation({
    required String id, // Usually the same as userId for simplicity
    required String userId,
    required String userName,
    required List<ChatMessage> messages,
  }) = _ChatConversation;

  factory ChatConversation.fromJson(Map<String, dynamic> json) =>
      _$ChatConversationFromJson(json);
}
