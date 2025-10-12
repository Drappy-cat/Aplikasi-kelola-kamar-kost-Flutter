// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_log_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ActivityLogEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String action) add,
    required TResult Function() load,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String action)? add,
    TResult? Function()? load,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String action)? add,
    TResult Function()? load,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddActivityLog value) add,
    required TResult Function(LoadActivityLogs value) load,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddActivityLog value)? add,
    TResult? Function(LoadActivityLogs value)? load,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddActivityLog value)? add,
    TResult Function(LoadActivityLogs value)? load,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogEventCopyWith<$Res> {
  factory $ActivityLogEventCopyWith(
    ActivityLogEvent value,
    $Res Function(ActivityLogEvent) then,
  ) = _$ActivityLogEventCopyWithImpl<$Res, ActivityLogEvent>;
}

/// @nodoc
class _$ActivityLogEventCopyWithImpl<$Res, $Val extends ActivityLogEvent>
    implements $ActivityLogEventCopyWith<$Res> {
  _$ActivityLogEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddActivityLogImplCopyWith<$Res> {
  factory _$$AddActivityLogImplCopyWith(
    _$AddActivityLogImpl value,
    $Res Function(_$AddActivityLogImpl) then,
  ) = __$$AddActivityLogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String action});
}

/// @nodoc
class __$$AddActivityLogImplCopyWithImpl<$Res>
    extends _$ActivityLogEventCopyWithImpl<$Res, _$AddActivityLogImpl>
    implements _$$AddActivityLogImplCopyWith<$Res> {
  __$$AddActivityLogImplCopyWithImpl(
    _$AddActivityLogImpl _value,
    $Res Function(_$AddActivityLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? action = null}) {
    return _then(
      _$AddActivityLogImpl(
        null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AddActivityLogImpl implements AddActivityLog {
  const _$AddActivityLogImpl(this.action);

  @override
  final String action;

  @override
  String toString() {
    return 'ActivityLogEvent.add(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddActivityLogImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action);

  /// Create a copy of ActivityLogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddActivityLogImplCopyWith<_$AddActivityLogImpl> get copyWith =>
      __$$AddActivityLogImplCopyWithImpl<_$AddActivityLogImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String action) add,
    required TResult Function() load,
  }) {
    return add(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String action)? add,
    TResult? Function()? load,
  }) {
    return add?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String action)? add,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddActivityLog value) add,
    required TResult Function(LoadActivityLogs value) load,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddActivityLog value)? add,
    TResult? Function(LoadActivityLogs value)? load,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddActivityLog value)? add,
    TResult Function(LoadActivityLogs value)? load,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class AddActivityLog implements ActivityLogEvent {
  const factory AddActivityLog(final String action) = _$AddActivityLogImpl;

  String get action;

  /// Create a copy of ActivityLogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddActivityLogImplCopyWith<_$AddActivityLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadActivityLogsImplCopyWith<$Res> {
  factory _$$LoadActivityLogsImplCopyWith(
    _$LoadActivityLogsImpl value,
    $Res Function(_$LoadActivityLogsImpl) then,
  ) = __$$LoadActivityLogsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadActivityLogsImplCopyWithImpl<$Res>
    extends _$ActivityLogEventCopyWithImpl<$Res, _$LoadActivityLogsImpl>
    implements _$$LoadActivityLogsImplCopyWith<$Res> {
  __$$LoadActivityLogsImplCopyWithImpl(
    _$LoadActivityLogsImpl _value,
    $Res Function(_$LoadActivityLogsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadActivityLogsImpl implements LoadActivityLogs {
  const _$LoadActivityLogsImpl();

  @override
  String toString() {
    return 'ActivityLogEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadActivityLogsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String action) add,
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String action)? add,
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String action)? add,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddActivityLog value) add,
    required TResult Function(LoadActivityLogs value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddActivityLog value)? add,
    TResult? Function(LoadActivityLogs value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddActivityLog value)? add,
    TResult Function(LoadActivityLogs value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadActivityLogs implements ActivityLogEvent {
  const factory LoadActivityLogs() = _$LoadActivityLogsImpl;
}

/// @nodoc
mixin _$ActivityLogState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  List<ActivityLog> get logs => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogStateCopyWith<ActivityLogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogStateCopyWith<$Res> {
  factory $ActivityLogStateCopyWith(
    ActivityLogState value,
    $Res Function(ActivityLogState) then,
  ) = _$ActivityLogStateCopyWithImpl<$Res, ActivityLogState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSubmitting,
    List<ActivityLog> logs,
    String? error,
    String? successMessage,
  });
}

/// @nodoc
class _$ActivityLogStateCopyWithImpl<$Res, $Val extends ActivityLogState>
    implements $ActivityLogStateCopyWith<$Res> {
  _$ActivityLogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? logs = null,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            logs: null == logs
                ? _value.logs
                : logs // ignore: cast_nullable_to_non_nullable
                      as List<ActivityLog>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityLogStateImplCopyWith<$Res>
    implements $ActivityLogStateCopyWith<$Res> {
  factory _$$ActivityLogStateImplCopyWith(
    _$ActivityLogStateImpl value,
    $Res Function(_$ActivityLogStateImpl) then,
  ) = __$$ActivityLogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSubmitting,
    List<ActivityLog> logs,
    String? error,
    String? successMessage,
  });
}

/// @nodoc
class __$$ActivityLogStateImplCopyWithImpl<$Res>
    extends _$ActivityLogStateCopyWithImpl<$Res, _$ActivityLogStateImpl>
    implements _$$ActivityLogStateImplCopyWith<$Res> {
  __$$ActivityLogStateImplCopyWithImpl(
    _$ActivityLogStateImpl _value,
    $Res Function(_$ActivityLogStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? logs = null,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$ActivityLogStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        logs: null == logs
            ? _value._logs
            : logs // ignore: cast_nullable_to_non_nullable
                  as List<ActivityLog>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ActivityLogStateImpl implements _ActivityLogState {
  const _$ActivityLogStateImpl({
    this.isLoading = false,
    this.isSubmitting = false,
    final List<ActivityLog> logs = const [],
    this.error,
    this.successMessage,
  }) : _logs = logs;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSubmitting;
  final List<ActivityLog> _logs;
  @override
  @JsonKey()
  List<ActivityLog> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  final String? error;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'ActivityLogState(isLoading: $isLoading, isSubmitting: $isSubmitting, logs: $logs, error: $error, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSubmitting,
    const DeepCollectionEquality().hash(_logs),
    error,
    successMessage,
  );

  /// Create a copy of ActivityLogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogStateImplCopyWith<_$ActivityLogStateImpl> get copyWith =>
      __$$ActivityLogStateImplCopyWithImpl<_$ActivityLogStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ActivityLogState implements ActivityLogState {
  const factory _ActivityLogState({
    final bool isLoading,
    final bool isSubmitting,
    final List<ActivityLog> logs,
    final String? error,
    final String? successMessage,
  }) = _$ActivityLogStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSubmitting;
  @override
  List<ActivityLog> get logs;
  @override
  String? get error;
  @override
  String? get successMessage;

  /// Create a copy of ActivityLogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogStateImplCopyWith<_$ActivityLogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
