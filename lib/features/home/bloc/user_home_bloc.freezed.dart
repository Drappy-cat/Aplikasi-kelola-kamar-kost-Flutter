// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserHomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserHomeData value) loadData,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserHomeData value)? loadData,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserHomeData value)? loadData,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHomeEventCopyWith<$Res> {
  factory $UserHomeEventCopyWith(
    UserHomeEvent value,
    $Res Function(UserHomeEvent) then,
  ) = _$UserHomeEventCopyWithImpl<$Res, UserHomeEvent>;
}

/// @nodoc
class _$UserHomeEventCopyWithImpl<$Res, $Val extends UserHomeEvent>
    implements $UserHomeEventCopyWith<$Res> {
  _$UserHomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadUserHomeDataImplCopyWith<$Res> {
  factory _$$LoadUserHomeDataImplCopyWith(
    _$LoadUserHomeDataImpl value,
    $Res Function(_$LoadUserHomeDataImpl) then,
  ) = __$$LoadUserHomeDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadUserHomeDataImplCopyWithImpl<$Res>
    extends _$UserHomeEventCopyWithImpl<$Res, _$LoadUserHomeDataImpl>
    implements _$$LoadUserHomeDataImplCopyWith<$Res> {
  __$$LoadUserHomeDataImplCopyWithImpl(
    _$LoadUserHomeDataImpl _value,
    $Res Function(_$LoadUserHomeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadUserHomeDataImpl implements LoadUserHomeData {
  const _$LoadUserHomeDataImpl();

  @override
  String toString() {
    return 'UserHomeEvent.loadData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadUserHomeDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
  }) {
    return loadData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
  }) {
    return loadData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadUserHomeData value) loadData,
  }) {
    return loadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadUserHomeData value)? loadData,
  }) {
    return loadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadUserHomeData value)? loadData,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData(this);
    }
    return orElse();
  }
}

abstract class LoadUserHomeData implements UserHomeEvent {
  const factory LoadUserHomeData() = _$LoadUserHomeDataImpl;
}

/// @nodoc
mixin _$UserHomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHomeStateCopyWith<$Res> {
  factory $UserHomeStateCopyWith(
    UserHomeState value,
    $Res Function(UserHomeState) then,
  ) = _$UserHomeStateCopyWithImpl<$Res, UserHomeState>;
}

/// @nodoc
class _$UserHomeStateCopyWithImpl<$Res, $Val extends UserHomeState>
    implements $UserHomeStateCopyWith<$Res> {
  _$UserHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserHomeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'UserHomeState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserHomeState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$UserHomeStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'UserHomeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements UserHomeState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    bool isTenant,
    Announcement? latestAnnouncement,
    Room? userRoom,
    Bill? latestBill,
    List<Room> allRooms,
  });

  $AnnouncementCopyWith<$Res>? get latestAnnouncement;
  $RoomCopyWith<$Res>? get userRoom;
  $BillCopyWith<$Res>? get latestBill;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$UserHomeStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTenant = null,
    Object? latestAnnouncement = freezed,
    Object? userRoom = freezed,
    Object? latestBill = freezed,
    Object? allRooms = null,
  }) {
    return _then(
      _$LoadedImpl(
        isTenant: null == isTenant
            ? _value.isTenant
            : isTenant // ignore: cast_nullable_to_non_nullable
                  as bool,
        latestAnnouncement: freezed == latestAnnouncement
            ? _value.latestAnnouncement
            : latestAnnouncement // ignore: cast_nullable_to_non_nullable
                  as Announcement?,
        userRoom: freezed == userRoom
            ? _value.userRoom
            : userRoom // ignore: cast_nullable_to_non_nullable
                  as Room?,
        latestBill: freezed == latestBill
            ? _value.latestBill
            : latestBill // ignore: cast_nullable_to_non_nullable
                  as Bill?,
        allRooms: null == allRooms
            ? _value._allRooms
            : allRooms // ignore: cast_nullable_to_non_nullable
                  as List<Room>,
      ),
    );
  }

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnnouncementCopyWith<$Res>? get latestAnnouncement {
    if (_value.latestAnnouncement == null) {
      return null;
    }

    return $AnnouncementCopyWith<$Res>(_value.latestAnnouncement!, (value) {
      return _then(_value.copyWith(latestAnnouncement: value));
    });
  }

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res>? get userRoom {
    if (_value.userRoom == null) {
      return null;
    }

    return $RoomCopyWith<$Res>(_value.userRoom!, (value) {
      return _then(_value.copyWith(userRoom: value));
    });
  }

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BillCopyWith<$Res>? get latestBill {
    if (_value.latestBill == null) {
      return null;
    }

    return $BillCopyWith<$Res>(_value.latestBill!, (value) {
      return _then(_value.copyWith(latestBill: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required this.isTenant,
    this.latestAnnouncement,
    this.userRoom,
    this.latestBill,
    required final List<Room> allRooms,
  }) : _allRooms = allRooms;

  @override
  final bool isTenant;
  @override
  final Announcement? latestAnnouncement;
  @override
  final Room? userRoom;
  @override
  final Bill? latestBill;
  final List<Room> _allRooms;
  @override
  List<Room> get allRooms {
    if (_allRooms is EqualUnmodifiableListView) return _allRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRooms);
  }

  @override
  String toString() {
    return 'UserHomeState.loaded(isTenant: $isTenant, latestAnnouncement: $latestAnnouncement, userRoom: $userRoom, latestBill: $latestBill, allRooms: $allRooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.isTenant, isTenant) ||
                other.isTenant == isTenant) &&
            (identical(other.latestAnnouncement, latestAnnouncement) ||
                other.latestAnnouncement == latestAnnouncement) &&
            (identical(other.userRoom, userRoom) ||
                other.userRoom == userRoom) &&
            (identical(other.latestBill, latestBill) ||
                other.latestBill == latestBill) &&
            const DeepCollectionEquality().equals(other._allRooms, _allRooms));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isTenant,
    latestAnnouncement,
    userRoom,
    latestBill,
    const DeepCollectionEquality().hash(_allRooms),
  );

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(isTenant, latestAnnouncement, userRoom, latestBill, allRooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      isTenant,
      latestAnnouncement,
      userRoom,
      latestBill,
      allRooms,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        isTenant,
        latestAnnouncement,
        userRoom,
        latestBill,
        allRooms,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements UserHomeState {
  const factory _Loaded({
    required final bool isTenant,
    final Announcement? latestAnnouncement,
    final Room? userRoom,
    final Bill? latestBill,
    required final List<Room> allRooms,
  }) = _$LoadedImpl;

  bool get isTenant;
  Announcement? get latestAnnouncement;
  Room? get userRoom;
  Bill? get latestBill;
  List<Room> get allRooms;

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$UserHomeStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserHomeState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      bool isTenant,
      Announcement? latestAnnouncement,
      Room? userRoom,
      Bill? latestBill,
      List<Room> allRooms,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements UserHomeState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of UserHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
