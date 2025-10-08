// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  DateTime get date =>
      throw _privateConstructorUsedError; // Menggunakan converter untuk tipe data yang tidak didukung JSON secara default
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get iconColor => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
    AppNotification value,
    $Res Function(AppNotification) then,
  ) = _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call({
    String title,
    String subtitle,
    DateTime date,
    @IconDataConverter() IconData icon,
    @ColorConverter() Color iconColor,
    bool isRead,
  });
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? date = null,
    Object? icon = null,
    Object? iconColor = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            subtitle: null == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as IconData,
            iconColor: null == iconColor
                ? _value.iconColor
                : iconColor // ignore: cast_nullable_to_non_nullable
                      as Color,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(
    _$AppNotificationImpl value,
    $Res Function(_$AppNotificationImpl) then,
  ) = __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String subtitle,
    DateTime date,
    @IconDataConverter() IconData icon,
    @ColorConverter() Color iconColor,
    bool isRead,
  });
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
    _$AppNotificationImpl _value,
    $Res Function(_$AppNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? date = null,
    Object? icon = null,
    Object? iconColor = null,
    Object? isRead = null,
  }) {
    return _then(
      _$AppNotificationImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        subtitle: null == subtitle
            ? _value.subtitle
            : subtitle // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as IconData,
        iconColor: null == iconColor
            ? _value.iconColor
            : iconColor // ignore: cast_nullable_to_non_nullable
                  as Color,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl({
    required this.title,
    required this.subtitle,
    required this.date,
    @IconDataConverter() required this.icon,
    @ColorConverter() required this.iconColor,
    this.isRead = false,
  });

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final DateTime date;
  // Menggunakan converter untuk tipe data yang tidak didukung JSON secara default
  @override
  @IconDataConverter()
  final IconData icon;
  @override
  @ColorConverter()
  final Color iconColor;
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'AppNotification(title: $title, subtitle: $subtitle, date: $date, icon: $icon, iconColor: $iconColor, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.iconColor, iconColor) ||
                other.iconColor == iconColor) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, subtitle, date, icon, iconColor, isRead);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(this);
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification({
    required final String title,
    required final String subtitle,
    required final DateTime date,
    @IconDataConverter() required final IconData icon,
    @ColorConverter() required final Color iconColor,
    final bool isRead,
  }) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  DateTime get date; // Menggunakan converter untuk tipe data yang tidak didukung JSON secara default
  @override
  @IconDataConverter()
  IconData get icon;
  @override
  @ColorConverter()
  Color get iconColor;
  @override
  bool get isRead;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
