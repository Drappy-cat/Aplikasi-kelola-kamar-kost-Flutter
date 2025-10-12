// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
    ProfileEvent value,
    $Res Function(ProfileEvent) then,
  ) = _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadProfileImplCopyWith<$Res> {
  factory _$$LoadProfileImplCopyWith(
    _$LoadProfileImpl value,
    $Res Function(_$LoadProfileImpl) then,
  ) = __$$LoadProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadProfileImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LoadProfileImpl>
    implements _$$LoadProfileImplCopyWith<$Res> {
  __$$LoadProfileImplCopyWithImpl(
    _$LoadProfileImpl _value,
    $Res Function(_$LoadProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadProfileImpl implements LoadProfile {
  const _$LoadProfileImpl();

  @override
  String toString() {
    return 'ProfileEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
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
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadProfile implements ProfileEvent {
  const factory LoadProfile() = _$LoadProfileImpl;
}

/// @nodoc
abstract class _$$UpdateFullNameImplCopyWith<$Res> {
  factory _$$UpdateFullNameImplCopyWith(
    _$UpdateFullNameImpl value,
    $Res Function(_$UpdateFullNameImpl) then,
  ) = __$$UpdateFullNameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newName});
}

/// @nodoc
class __$$UpdateFullNameImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$UpdateFullNameImpl>
    implements _$$UpdateFullNameImplCopyWith<$Res> {
  __$$UpdateFullNameImplCopyWithImpl(
    _$UpdateFullNameImpl _value,
    $Res Function(_$UpdateFullNameImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newName = null}) {
    return _then(
      _$UpdateFullNameImpl(
        null == newName
            ? _value.newName
            : newName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateFullNameImpl implements UpdateFullName {
  const _$UpdateFullNameImpl(this.newName);

  @override
  final String newName;

  @override
  String toString() {
    return 'ProfileEvent.updateFullName(newName: $newName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateFullNameImpl &&
            (identical(other.newName, newName) || other.newName == newName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newName);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateFullNameImplCopyWith<_$UpdateFullNameImpl> get copyWith =>
      __$$UpdateFullNameImplCopyWithImpl<_$UpdateFullNameImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) {
    return updateFullName(newName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) {
    return updateFullName?.call(newName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (updateFullName != null) {
      return updateFullName(newName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) {
    return updateFullName(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) {
    return updateFullName?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (updateFullName != null) {
      return updateFullName(this);
    }
    return orElse();
  }
}

abstract class UpdateFullName implements ProfileEvent {
  const factory UpdateFullName(final String newName) = _$UpdateFullNameImpl;

  String get newName;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateFullNameImplCopyWith<_$UpdateFullNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateProfilePictureImplCopyWith<$Res> {
  factory _$$UpdateProfilePictureImplCopyWith(
    _$UpdateProfilePictureImpl value,
    $Res Function(_$UpdateProfilePictureImpl) then,
  ) = __$$UpdateProfilePictureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newUrl});
}

/// @nodoc
class __$$UpdateProfilePictureImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$UpdateProfilePictureImpl>
    implements _$$UpdateProfilePictureImplCopyWith<$Res> {
  __$$UpdateProfilePictureImplCopyWithImpl(
    _$UpdateProfilePictureImpl _value,
    $Res Function(_$UpdateProfilePictureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newUrl = null}) {
    return _then(
      _$UpdateProfilePictureImpl(
        null == newUrl
            ? _value.newUrl
            : newUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateProfilePictureImpl implements UpdateProfilePicture {
  const _$UpdateProfilePictureImpl(this.newUrl);

  @override
  final String newUrl;

  @override
  String toString() {
    return 'ProfileEvent.updateProfilePicture(newUrl: $newUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfilePictureImpl &&
            (identical(other.newUrl, newUrl) || other.newUrl == newUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newUrl);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfilePictureImplCopyWith<_$UpdateProfilePictureImpl>
  get copyWith =>
      __$$UpdateProfilePictureImplCopyWithImpl<_$UpdateProfilePictureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) {
    return updateProfilePicture(newUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) {
    return updateProfilePicture?.call(newUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (updateProfilePicture != null) {
      return updateProfilePicture(newUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) {
    return updateProfilePicture(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) {
    return updateProfilePicture?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (updateProfilePicture != null) {
      return updateProfilePicture(this);
    }
    return orElse();
  }
}

abstract class UpdateProfilePicture implements ProfileEvent {
  const factory UpdateProfilePicture(final String newUrl) =
      _$UpdateProfilePictureImpl;

  String get newUrl;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfilePictureImplCopyWith<_$UpdateProfilePictureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePasswordImplCopyWith<$Res> {
  factory _$$ChangePasswordImplCopyWith(
    _$ChangePasswordImpl value,
    $Res Function(_$ChangePasswordImpl) then,
  ) = __$$ChangePasswordImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String oldPassword, String newPassword});
}

/// @nodoc
class __$$ChangePasswordImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$ChangePasswordImpl>
    implements _$$ChangePasswordImplCopyWith<$Res> {
  __$$ChangePasswordImplCopyWithImpl(
    _$ChangePasswordImpl _value,
    $Res Function(_$ChangePasswordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? oldPassword = null, Object? newPassword = null}) {
    return _then(
      _$ChangePasswordImpl(
        oldPassword: null == oldPassword
            ? _value.oldPassword
            : oldPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        newPassword: null == newPassword
            ? _value.newPassword
            : newPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChangePasswordImpl implements ChangePassword {
  const _$ChangePasswordImpl({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  final String oldPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ProfileEvent.changePassword(oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordImpl &&
            (identical(other.oldPassword, oldPassword) ||
                other.oldPassword == oldPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldPassword, newPassword);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordImplCopyWith<_$ChangePasswordImpl> get copyWith =>
      __$$ChangePasswordImplCopyWithImpl<_$ChangePasswordImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) {
    return changePassword(oldPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) {
    return changePassword?.call(oldPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (changePassword != null) {
      return changePassword(oldPassword, newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) {
    return changePassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) {
    return changePassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (changePassword != null) {
      return changePassword(this);
    }
    return orElse();
  }
}

abstract class ChangePassword implements ProfileEvent {
  const factory ChangePassword({
    required final String oldPassword,
    required final String newPassword,
  }) = _$ChangePasswordImpl;

  String get oldPassword;
  String get newPassword;

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordImplCopyWith<_$ChangePasswordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutImplCopyWith<$Res> {
  factory _$$LogoutImplCopyWith(
    _$LogoutImpl value,
    $Res Function(_$LogoutImpl) then,
  ) = __$$LogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$LogoutImpl>
    implements _$$LogoutImplCopyWith<$Res> {
  __$$LogoutImplCopyWithImpl(
    _$LogoutImpl _value,
    $Res Function(_$LogoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutImpl implements Logout {
  const _$LogoutImpl();

  @override
  String toString() {
    return 'ProfileEvent.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String newName) updateFullName,
    required TResult Function(String newUrl) updateProfilePicture,
    required TResult Function(String oldPassword, String newPassword)
    changePassword,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String newName)? updateFullName,
    TResult? Function(String newUrl)? updateProfilePicture,
    TResult? Function(String oldPassword, String newPassword)? changePassword,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String newName)? updateFullName,
    TResult Function(String newUrl)? updateProfilePicture,
    TResult Function(String oldPassword, String newPassword)? changePassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProfile value) load,
    required TResult Function(UpdateFullName value) updateFullName,
    required TResult Function(UpdateProfilePicture value) updateProfilePicture,
    required TResult Function(ChangePassword value) changePassword,
    required TResult Function(Logout value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProfile value)? load,
    TResult? Function(UpdateFullName value)? updateFullName,
    TResult? Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult? Function(ChangePassword value)? changePassword,
    TResult? Function(Logout value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProfile value)? load,
    TResult Function(UpdateFullName value)? updateFullName,
    TResult Function(UpdateProfilePicture value)? updateProfilePicture,
    TResult Function(ChangePassword value)? changePassword,
    TResult Function(Logout value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class Logout implements ProfileEvent {
  const factory Logout() = _$LogoutImpl;
}

/// @nodoc
mixin _$ProfileState {
  // Status keseluruhan halaman
  bool get isLoading =>
      throw _privateConstructorUsedError; // Data pengguna yang akan ditampilkan
  AppUser? get user =>
      throw _privateConstructorUsedError; // Untuk menampilkan pesan error umum
  String? get error =>
      throw _privateConstructorUsedError; // Status spesifik untuk aksi ubah password
  bool get isPasswordChangeLoading => throw _privateConstructorUsedError;
  String? get passwordChangeError => throw _privateConstructorUsedError;
  String? get passwordChangeSuccess =>
      throw _privateConstructorUsedError; // Status untuk aksi logout
  bool get loggedOut => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
    ProfileState value,
    $Res Function(ProfileState) then,
  ) = _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call({
    bool isLoading,
    AppUser? user,
    String? error,
    bool isPasswordChangeLoading,
    String? passwordChangeError,
    String? passwordChangeSuccess,
    bool loggedOut,
  });

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? user = freezed,
    Object? error = freezed,
    Object? isPasswordChangeLoading = null,
    Object? passwordChangeError = freezed,
    Object? passwordChangeSuccess = freezed,
    Object? loggedOut = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AppUser?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPasswordChangeLoading: null == isPasswordChangeLoading
                ? _value.isPasswordChangeLoading
                : isPasswordChangeLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            passwordChangeError: freezed == passwordChangeError
                ? _value.passwordChangeError
                : passwordChangeError // ignore: cast_nullable_to_non_nullable
                      as String?,
            passwordChangeSuccess: freezed == passwordChangeSuccess
                ? _value.passwordChangeSuccess
                : passwordChangeSuccess // ignore: cast_nullable_to_non_nullable
                      as String?,
            loggedOut: null == loggedOut
                ? _value.loggedOut
                : loggedOut // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
    _$ProfileStateImpl value,
    $Res Function(_$ProfileStateImpl) then,
  ) = __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    AppUser? user,
    String? error,
    bool isPasswordChangeLoading,
    String? passwordChangeError,
    String? passwordChangeSuccess,
    bool loggedOut,
  });

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
    _$ProfileStateImpl _value,
    $Res Function(_$ProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? user = freezed,
    Object? error = freezed,
    Object? isPasswordChangeLoading = null,
    Object? passwordChangeError = freezed,
    Object? passwordChangeSuccess = freezed,
    Object? loggedOut = null,
  }) {
    return _then(
      _$ProfileStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AppUser?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPasswordChangeLoading: null == isPasswordChangeLoading
            ? _value.isPasswordChangeLoading
            : isPasswordChangeLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        passwordChangeError: freezed == passwordChangeError
            ? _value.passwordChangeError
            : passwordChangeError // ignore: cast_nullable_to_non_nullable
                  as String?,
        passwordChangeSuccess: freezed == passwordChangeSuccess
            ? _value.passwordChangeSuccess
            : passwordChangeSuccess // ignore: cast_nullable_to_non_nullable
                  as String?,
        loggedOut: null == loggedOut
            ? _value.loggedOut
            : loggedOut // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl({
    this.isLoading = false,
    this.user,
    this.error,
    this.isPasswordChangeLoading = false,
    this.passwordChangeError,
    this.passwordChangeSuccess,
    this.loggedOut = false,
  });

  // Status keseluruhan halaman
  @override
  @JsonKey()
  final bool isLoading;
  // Data pengguna yang akan ditampilkan
  @override
  final AppUser? user;
  // Untuk menampilkan pesan error umum
  @override
  final String? error;
  // Status spesifik untuk aksi ubah password
  @override
  @JsonKey()
  final bool isPasswordChangeLoading;
  @override
  final String? passwordChangeError;
  @override
  final String? passwordChangeSuccess;
  // Status untuk aksi logout
  @override
  @JsonKey()
  final bool loggedOut;

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, user: $user, error: $error, isPasswordChangeLoading: $isPasswordChangeLoading, passwordChangeError: $passwordChangeError, passwordChangeSuccess: $passwordChangeSuccess, loggedOut: $loggedOut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(
                  other.isPasswordChangeLoading,
                  isPasswordChangeLoading,
                ) ||
                other.isPasswordChangeLoading == isPasswordChangeLoading) &&
            (identical(other.passwordChangeError, passwordChangeError) ||
                other.passwordChangeError == passwordChangeError) &&
            (identical(other.passwordChangeSuccess, passwordChangeSuccess) ||
                other.passwordChangeSuccess == passwordChangeSuccess) &&
            (identical(other.loggedOut, loggedOut) ||
                other.loggedOut == loggedOut));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    user,
    error,
    isPasswordChangeLoading,
    passwordChangeError,
    passwordChangeSuccess,
    loggedOut,
  );

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState({
    final bool isLoading,
    final AppUser? user,
    final String? error,
    final bool isPasswordChangeLoading,
    final String? passwordChangeError,
    final String? passwordChangeSuccess,
    final bool loggedOut,
  }) = _$ProfileStateImpl;

  // Status keseluruhan halaman
  @override
  bool get isLoading; // Data pengguna yang akan ditampilkan
  @override
  AppUser? get user; // Untuk menampilkan pesan error umum
  @override
  String? get error; // Status spesifik untuk aksi ubah password
  @override
  bool get isPasswordChangeLoading;
  @override
  String? get passwordChangeError;
  @override
  String? get passwordChangeSuccess; // Status untuk aksi logout
  @override
  bool get loggedOut;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
