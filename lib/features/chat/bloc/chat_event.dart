part of 'chat_bloc.dart';

@freezed
abstract class ChatEvent with _$ChatEvent {
  const factory ChatEvent.load(String userId) = LoadChat;
  const factory ChatEvent.sendMessage(String text) = SendTextMessage;
  const factory ChatEvent.sendImage(String imageUrl) = SendImageMessage;
}
