// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatConversation _$ChatConversationFromJson(Map<String, dynamic> json) {
  return _ChatConversation.fromJson(json);
}

/// @nodoc
mixin _$ChatConversation {
  // ID unik untuk percakapan, biasanya sama dengan userId untuk kemudahan.
  String get id =>
      throw _privateConstructorUsedError; // ID pengguna yang menjadi lawan bicara dalam percakapan ini.
  String get userId =>
      throw _privateConstructorUsedError; // Nama pengguna untuk ditampilkan di UI daftar chat.
  String get userName =>
      throw _privateConstructorUsedError; // Daftar semua pesan yang ada di dalam percakapan ini.
  List<ChatMessage> get messages => throw _privateConstructorUsedError;

  /// Serializes this ChatConversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatConversationCopyWith<ChatConversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatConversationCopyWith<$Res> {
  factory $ChatConversationCopyWith(
    ChatConversation value,
    $Res Function(ChatConversation) then,
  ) = _$ChatConversationCopyWithImpl<$Res, ChatConversation>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    List<ChatMessage> messages,
  });
}

/// @nodoc
class _$ChatConversationCopyWithImpl<$Res, $Val extends ChatConversation>
    implements $ChatConversationCopyWith<$Res> {
  _$ChatConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? messages = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<ChatMessage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatConversationImplCopyWith<$Res>
    implements $ChatConversationCopyWith<$Res> {
  factory _$$ChatConversationImplCopyWith(
    _$ChatConversationImpl value,
    $Res Function(_$ChatConversationImpl) then,
  ) = __$$ChatConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    List<ChatMessage> messages,
  });
}

/// @nodoc
class __$$ChatConversationImplCopyWithImpl<$Res>
    extends _$ChatConversationCopyWithImpl<$Res, _$ChatConversationImpl>
    implements _$$ChatConversationImplCopyWith<$Res> {
  __$$ChatConversationImplCopyWithImpl(
    _$ChatConversationImpl _value,
    $Res Function(_$ChatConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? messages = null,
  }) {
    return _then(
      _$ChatConversationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatMessage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatConversationImpl implements _ChatConversation {
  const _$ChatConversationImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required final List<ChatMessage> messages,
  }) : _messages = messages;

  factory _$ChatConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatConversationImplFromJson(json);

  // ID unik untuk percakapan, biasanya sama dengan userId untuk kemudahan.
  @override
  final String id;
  // ID pengguna yang menjadi lawan bicara dalam percakapan ini.
  @override
  final String userId;
  // Nama pengguna untuk ditampilkan di UI daftar chat.
  @override
  final String userName;
  // Daftar semua pesan yang ada di dalam percakapan ini.
  final List<ChatMessage> _messages;
  // Daftar semua pesan yang ada di dalam percakapan ini.
  @override
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatConversation(id: $id, userId: $userId, userName: $userName, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    userName,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of ChatConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatConversationImplCopyWith<_$ChatConversationImpl> get copyWith =>
      __$$ChatConversationImplCopyWithImpl<_$ChatConversationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatConversationImplToJson(this);
  }
}

abstract class _ChatConversation implements ChatConversation {
  const factory _ChatConversation({
    required final String id,
    required final String userId,
    required final String userName,
    required final List<ChatMessage> messages,
  }) = _$ChatConversationImpl;

  factory _ChatConversation.fromJson(Map<String, dynamic> json) =
      _$ChatConversationImpl.fromJson;

  // ID unik untuk percakapan, biasanya sama dengan userId untuk kemudahan.
  @override
  String get id; // ID pengguna yang menjadi lawan bicara dalam percakapan ini.
  @override
  String get userId; // Nama pengguna untuk ditampilkan di UI daftar chat.
  @override
  String get userName; // Daftar semua pesan yang ada di dalam percakapan ini.
  @override
  List<ChatMessage> get messages;

  /// Create a copy of ChatConversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatConversationImplCopyWith<_$ChatConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
