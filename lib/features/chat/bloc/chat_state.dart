part of 'chat_bloc.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    @Default(true) bool isLoading,
    @Default(false) bool isSending,
    ChatConversation? conversation,
    String? error,
  }) = _ChatState;
}
