// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) load,
    required TResult Function(String text) sendMessage,
    required TResult Function(String imageUrl) sendImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? load,
    TResult? Function(String text)? sendMessage,
    TResult? Function(String imageUrl)? sendImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? load,
    TResult Function(String text)? sendMessage,
    TResult Function(String imageUrl)? sendImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadChat value) load,
    required TResult Function(SendTextMessage value) sendMessage,
    required TResult Function(SendImageMessage value) sendImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadChat value)? load,
    TResult? Function(SendTextMessage value)? sendMessage,
    TResult? Function(SendImageMessage value)? sendImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadChat value)? load,
    TResult Function(SendTextMessage value)? sendMessage,
    TResult Function(SendImageMessage value)? sendImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<$Res> {
  factory $ChatEventCopyWith(ChatEvent value, $Res Function(ChatEvent) then) =
      _$ChatEventCopyWithImpl<$Res, ChatEvent>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res, $Val extends ChatEvent>
    implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadChatImplCopyWith<$Res> {
  factory _$$LoadChatImplCopyWith(
          _$LoadChatImpl value, $Res Function(_$LoadChatImpl) then) =
      __$$LoadChatImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$LoadChatImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$LoadChatImpl>
    implements _$$LoadChatImplCopyWith<$Res> {
  __$$LoadChatImplCopyWithImpl(
      _$LoadChatImpl _value, $Res Function(_$LoadChatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$LoadChatImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadChatImpl implements LoadChat {
  const _$LoadChatImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ChatEvent.load(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadChatImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadChatImplCopyWith<_$LoadChatImpl> get copyWith =>
      __$$LoadChatImplCopyWithImpl<_$LoadChatImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) load,
    required TResult Function(String text) sendMessage,
    required TResult Function(String imageUrl) sendImage,
  }) {
    return load(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? load,
    TResult? Function(String text)? sendMessage,
    TResult? Function(String imageUrl)? sendImage,
  }) {
    return load?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? load,
    TResult Function(String text)? sendMessage,
    TResult Function(String imageUrl)? sendImage,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadChat value) load,
    required TResult Function(SendTextMessage value) sendMessage,
    required TResult Function(SendImageMessage value) sendImage,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadChat value)? load,
    TResult? Function(SendTextMessage value)? sendMessage,
    TResult? Function(SendImageMessage value)? sendImage,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadChat value)? load,
    TResult Function(SendTextMessage value)? sendMessage,
    TResult Function(SendImageMessage value)? sendImage,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadChat implements ChatEvent {
  const factory LoadChat(final String userId) = _$LoadChatImpl;

  String get userId;
  @JsonKey(ignore: true)
  _$$LoadChatImplCopyWith<_$LoadChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTextMessageImplCopyWith<$Res> {
  factory _$$SendTextMessageImplCopyWith(_$SendTextMessageImpl value,
          $Res Function(_$SendTextMessageImpl) then) =
      __$$SendTextMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$SendTextMessageImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SendTextMessageImpl>
    implements _$$SendTextMessageImplCopyWith<$Res> {
  __$$SendTextMessageImplCopyWithImpl(
      _$SendTextMessageImpl _value, $Res Function(_$SendTextMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$SendTextMessageImpl(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendTextMessageImpl implements SendTextMessage {
  const _$SendTextMessageImpl(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.sendMessage(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTextMessageImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      __$$SendTextMessageImplCopyWithImpl<_$SendTextMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) load,
    required TResult Function(String text) sendMessage,
    required TResult Function(String imageUrl) sendImage,
  }) {
    return sendMessage(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? load,
    TResult? Function(String text)? sendMessage,
    TResult? Function(String imageUrl)? sendImage,
  }) {
    return sendMessage?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? load,
    TResult Function(String text)? sendMessage,
    TResult Function(String imageUrl)? sendImage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadChat value) load,
    required TResult Function(SendTextMessage value) sendMessage,
    required TResult Function(SendImageMessage value) sendImage,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadChat value)? load,
    TResult? Function(SendTextMessage value)? sendMessage,
    TResult? Function(SendImageMessage value)? sendImage,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadChat value)? load,
    TResult Function(SendTextMessage value)? sendMessage,
    TResult Function(SendImageMessage value)? sendImage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class SendTextMessage implements ChatEvent {
  const factory SendTextMessage(final String text) = _$SendTextMessageImpl;

  String get text;
  @JsonKey(ignore: true)
  _$$SendTextMessageImplCopyWith<_$SendTextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendImageMessageImplCopyWith<$Res> {
  factory _$$SendImageMessageImplCopyWith(_$SendImageMessageImpl value,
          $Res Function(_$SendImageMessageImpl) then) =
      __$$SendImageMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String imageUrl});
}

/// @nodoc
class __$$SendImageMessageImplCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res, _$SendImageMessageImpl>
    implements _$$SendImageMessageImplCopyWith<$Res> {
  __$$SendImageMessageImplCopyWithImpl(_$SendImageMessageImpl _value,
      $Res Function(_$SendImageMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
  }) {
    return _then(_$SendImageMessageImpl(
      null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendImageMessageImpl implements SendImageMessage {
  const _$SendImageMessageImpl(this.imageUrl);

  @override
  final String imageUrl;

  @override
  String toString() {
    return 'ChatEvent.sendImage(imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendImageMessageImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendImageMessageImplCopyWith<_$SendImageMessageImpl> get copyWith =>
      __$$SendImageMessageImplCopyWithImpl<_$SendImageMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) load,
    required TResult Function(String text) sendMessage,
    required TResult Function(String imageUrl) sendImage,
  }) {
    return sendImage(imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? load,
    TResult? Function(String text)? sendMessage,
    TResult? Function(String imageUrl)? sendImage,
  }) {
    return sendImage?.call(imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? load,
    TResult Function(String text)? sendMessage,
    TResult Function(String imageUrl)? sendImage,
    required TResult orElse(),
  }) {
    if (sendImage != null) {
      return sendImage(imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadChat value) load,
    required TResult Function(SendTextMessage value) sendMessage,
    required TResult Function(SendImageMessage value) sendImage,
  }) {
    return sendImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadChat value)? load,
    TResult? Function(SendTextMessage value)? sendMessage,
    TResult? Function(SendImageMessage value)? sendImage,
  }) {
    return sendImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadChat value)? load,
    TResult Function(SendTextMessage value)? sendMessage,
    TResult Function(SendImageMessage value)? sendImage,
    required TResult orElse(),
  }) {
    if (sendImage != null) {
      return sendImage(this);
    }
    return orElse();
  }
}

abstract class SendImageMessage implements ChatEvent {
  const factory SendImageMessage(final String imageUrl) = _$SendImageMessageImpl;

  String get imageUrl;
  @JsonKey(ignore: true)
  _$$SendImageMessageImplCopyWith<_$SendImageMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  ChatConversation? get conversation => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSending,
      ChatConversation? conversation,
      String? error});

  $ChatConversationCopyWith<$Res>? get conversation;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSending = null,
    Object? conversation = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      conversation: freezed == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as ChatConversation?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatConversationCopyWith<$Res>? get conversation {
    if (_value.conversation == null) {
      return null;
    }

    return $ChatConversationCopyWith<$Res>(_value.conversation!, (value) {
      return _then(_value.copyWith(conversation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
          _$ChatStateImpl value, $Res Function(_$ChatStateImpl) then) =
      __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSending,
      ChatConversation? conversation,
      String? error});

  @override
  $ChatConversationCopyWith<$Res>? get conversation;
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
      _$ChatStateImpl _value, $Res Function(_$ChatStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSending = null,
    Object? conversation = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ChatStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      conversation: freezed == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as ChatConversation?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl(
      {this.isLoading = true,
      this.isSending = false,
      this.conversation,
      this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSending;
  @override
  final ChatConversation? conversation;
  @override
  final String? error;

  @override
  String toString() {
    return 'ChatState(isLoading: $isLoading, isSending: $isSending, conversation: $conversation, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.conversation, conversation) ||
                other.conversation == conversation) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, isSending, conversation, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState(
      {final bool isLoading,
      final bool isSending,
      final ChatConversation? conversation,
      final String? error}) = _$ChatStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSending;
  @override
  ChatConversation? get conversation;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
