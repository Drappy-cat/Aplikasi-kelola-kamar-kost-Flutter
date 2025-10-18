import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/models/chat_conversation.dart';
import 'package:tes/shared/models/chat_message.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  String? _currentConversationUserId;

  ChatBloc() : super(const ChatState()) {
    on<LoadChat>(_onLoadChat);
    on<SendTextMessage>(_onSendTextMessage);
    on<SendImageMessage>(_onSendImageMessage);
  }

  void _onLoadChat(LoadChat event, Emitter<ChatState> emit) {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      _currentConversationUserId = event.userId;
      final user = _authService.findUserById(event.userId);
      if (user == null) throw 'Pengguna percakapan tidak ditemukan.';

      final conversation = _dummyService.getConversationForUser(user.id, user.fullName ?? user.username);
      emit(state.copyWith(isLoading: false, conversation: conversation));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSendTextMessage(
      SendTextMessage event, Emitter<ChatState> emit) async {
    await _sendMessage(emit, text: event.text);
  }

  Future<void> _onSendImageMessage(
      SendImageMessage event, Emitter<ChatState> emit) async {
    await _sendMessage(emit, imageUrl: event.imageUrl);
  }

  Future<void> _sendMessage(Emitter<ChatState> emit, {String? text, String? imageUrl}) async {
    final userId = _currentConversationUserId;
    final sender = _authService.currentUser;

    if (userId == null || sender == null) {
      emit(state.copyWith(error: 'Gagal mengirim pesan: Sesi tidak valid.'));
      return;
    }

    emit(state.copyWith(isSending: true));

    final newMessage = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      senderId: sender.id,
      text: text,
      imageUrl: imageUrl,
      timestamp: DateTime.now(),
    );

    try {
      await _dummyService.addMessage(userId, newMessage);
      add(LoadChat(userId));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isSending: false));
    }
  }
}
