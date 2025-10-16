// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) {
  return _ActivityLog.fromJson(json);
}

/// @nodoc
mixin _$ActivityLog {
  // ID unik untuk setiap log.
  String get id =>
      throw _privateConstructorUsedError; // ID pengguna yang melakukan aktivitas.
  String get userId =>
      throw _privateConstructorUsedError; // Nama pengguna untuk kemudahan tampilan.
  String get userName =>
      throw _privateConstructorUsedError; // Jenis aksi yang dicatat, yaitu "Berangkat" atau "Pulang".
  String get action =>
      throw _privateConstructorUsedError; // Waktu pasti saat aktivitas dicatat.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ActivityLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogCopyWith<ActivityLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogCopyWith<$Res> {
  factory $ActivityLogCopyWith(
    ActivityLog value,
    $Res Function(ActivityLog) then,
  ) = _$ActivityLogCopyWithImpl<$Res, ActivityLog>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String action,
    DateTime timestamp,
  });
}

/// @nodoc
class _$ActivityLogCopyWithImpl<$Res, $Val extends ActivityLog>
    implements $ActivityLogCopyWith<$Res> {
  _$ActivityLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? action = null,
    Object? timestamp = null,
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
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityLogImplCopyWith<$Res>
    implements $ActivityLogCopyWith<$Res> {
  factory _$$ActivityLogImplCopyWith(
    _$ActivityLogImpl value,
    $Res Function(_$ActivityLogImpl) then,
  ) = __$$ActivityLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String action,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$ActivityLogImplCopyWithImpl<$Res>
    extends _$ActivityLogCopyWithImpl<$Res, _$ActivityLogImpl>
    implements _$$ActivityLogImplCopyWith<$Res> {
  __$$ActivityLogImplCopyWithImpl(
    _$ActivityLogImpl _value,
    $Res Function(_$ActivityLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? action = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$ActivityLogImpl(
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
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityLogImpl implements _ActivityLog {
  const _$ActivityLogImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.action,
    required this.timestamp,
  });

  factory _$ActivityLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityLogImplFromJson(json);

  // ID unik untuk setiap log.
  @override
  final String id;
  // ID pengguna yang melakukan aktivitas.
  @override
  final String userId;
  // Nama pengguna untuk kemudahan tampilan.
  @override
  final String userName;
  // Jenis aksi yang dicatat, yaitu "Berangkat" atau "Pulang".
  @override
  final String action;
  // Waktu pasti saat aktivitas dicatat.
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ActivityLog(id: $id, userId: $userId, userName: $userName, action: $action, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, userName, action, timestamp);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      __$$ActivityLogImplCopyWithImpl<_$ActivityLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityLogImplToJson(this);
  }
}

abstract class _ActivityLog implements ActivityLog {
  const factory _ActivityLog({
    required final String id,
    required final String userId,
    required final String userName,
    required final String action,
    required final DateTime timestamp,
  }) = _$ActivityLogImpl;

  factory _ActivityLog.fromJson(Map<String, dynamic> json) =
      _$ActivityLogImpl.fromJson;

  // ID unik untuk setiap log.
  @override
  String get id; // ID pengguna yang melakukan aktivitas.
  @override
  String get userId; // Nama pengguna untuk kemudahan tampilan.
  @override
  String get userName; // Jenis aksi yang dicatat, yaitu "Berangkat" atau "Pulang".
  @override
  String get action; // Waktu pasti saat aktivitas dicatat.
  @override
  DateTime get timestamp;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
