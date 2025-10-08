// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get code => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get baseRent => throw _privateConstructorUsedError;
  int get wifi => throw _privateConstructorUsedError;
  int get water => throw _privateConstructorUsedError;
  int get electricity => throw _privateConstructorUsedError;
  int get acCost => throw _privateConstructorUsedError;
  bool get packageFull => throw _privateConstructorUsedError;
  String get dimensions => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  String? get tenantName => throw _privateConstructorUsedError;
  String? get tenantAddress => throw _privateConstructorUsedError;
  String? get tenantPhone => throw _privateConstructorUsedError;
  String? get rentStartDate => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String code,
    String status,
    int baseRent,
    int wifi,
    int water,
    int electricity,
    int acCost,
    bool packageFull,
    String dimensions,
    List<String> imageUrls,
    String? tenantName,
    String? tenantAddress,
    String? tenantPhone,
    String? rentStartDate,
  });
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? status = null,
    Object? baseRent = null,
    Object? wifi = null,
    Object? water = null,
    Object? electricity = null,
    Object? acCost = null,
    Object? packageFull = null,
    Object? dimensions = null,
    Object? imageUrls = null,
    Object? tenantName = freezed,
    Object? tenantAddress = freezed,
    Object? tenantPhone = freezed,
    Object? rentStartDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            baseRent: null == baseRent
                ? _value.baseRent
                : baseRent // ignore: cast_nullable_to_non_nullable
                      as int,
            wifi: null == wifi
                ? _value.wifi
                : wifi // ignore: cast_nullable_to_non_nullable
                      as int,
            water: null == water
                ? _value.water
                : water // ignore: cast_nullable_to_non_nullable
                      as int,
            electricity: null == electricity
                ? _value.electricity
                : electricity // ignore: cast_nullable_to_non_nullable
                      as int,
            acCost: null == acCost
                ? _value.acCost
                : acCost // ignore: cast_nullable_to_non_nullable
                      as int,
            packageFull: null == packageFull
                ? _value.packageFull
                : packageFull // ignore: cast_nullable_to_non_nullable
                      as bool,
            dimensions: null == dimensions
                ? _value.dimensions
                : dimensions // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tenantName: freezed == tenantName
                ? _value.tenantName
                : tenantName // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantAddress: freezed == tenantAddress
                ? _value.tenantAddress
                : tenantAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantPhone: freezed == tenantPhone
                ? _value.tenantPhone
                : tenantPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            rentStartDate: freezed == rentStartDate
                ? _value.rentStartDate
                : rentStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String status,
    int baseRent,
    int wifi,
    int water,
    int electricity,
    int acCost,
    bool packageFull,
    String dimensions,
    List<String> imageUrls,
    String? tenantName,
    String? tenantAddress,
    String? tenantPhone,
    String? rentStartDate,
  });
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? status = null,
    Object? baseRent = null,
    Object? wifi = null,
    Object? water = null,
    Object? electricity = null,
    Object? acCost = null,
    Object? packageFull = null,
    Object? dimensions = null,
    Object? imageUrls = null,
    Object? tenantName = freezed,
    Object? tenantAddress = freezed,
    Object? tenantPhone = freezed,
    Object? rentStartDate = freezed,
  }) {
    return _then(
      _$RoomImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        baseRent: null == baseRent
            ? _value.baseRent
            : baseRent // ignore: cast_nullable_to_non_nullable
                  as int,
        wifi: null == wifi
            ? _value.wifi
            : wifi // ignore: cast_nullable_to_non_nullable
                  as int,
        water: null == water
            ? _value.water
            : water // ignore: cast_nullable_to_non_nullable
                  as int,
        electricity: null == electricity
            ? _value.electricity
            : electricity // ignore: cast_nullable_to_non_nullable
                  as int,
        acCost: null == acCost
            ? _value.acCost
            : acCost // ignore: cast_nullable_to_non_nullable
                  as int,
        packageFull: null == packageFull
            ? _value.packageFull
            : packageFull // ignore: cast_nullable_to_non_nullable
                  as bool,
        dimensions: null == dimensions
            ? _value.dimensions
            : dimensions // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tenantName: freezed == tenantName
            ? _value.tenantName
            : tenantName // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantAddress: freezed == tenantAddress
            ? _value.tenantAddress
            : tenantAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantPhone: freezed == tenantPhone
            ? _value.tenantPhone
            : tenantPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        rentStartDate: freezed == rentStartDate
            ? _value.rentStartDate
            : rentStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl extends _Room {
  const _$RoomImpl({
    required this.code,
    required this.status,
    required this.baseRent,
    required this.wifi,
    required this.water,
    required this.electricity,
    this.acCost = 0,
    this.packageFull = false,
    this.dimensions = 'N/A',
    final List<String> imageUrls = const [],
    this.tenantName,
    this.tenantAddress,
    this.tenantPhone,
    this.rentStartDate,
  }) : _imageUrls = imageUrls,
       super._();

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String code;
  @override
  final String status;
  @override
  final int baseRent;
  @override
  final int wifi;
  @override
  final int water;
  @override
  final int electricity;
  @override
  @JsonKey()
  final int acCost;
  @override
  @JsonKey()
  final bool packageFull;
  @override
  @JsonKey()
  final String dimensions;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String? tenantName;
  @override
  final String? tenantAddress;
  @override
  final String? tenantPhone;
  @override
  final String? rentStartDate;

  @override
  String toString() {
    return 'Room(code: $code, status: $status, baseRent: $baseRent, wifi: $wifi, water: $water, electricity: $electricity, acCost: $acCost, packageFull: $packageFull, dimensions: $dimensions, imageUrls: $imageUrls, tenantName: $tenantName, tenantAddress: $tenantAddress, tenantPhone: $tenantPhone, rentStartDate: $rentStartDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.baseRent, baseRent) ||
                other.baseRent == baseRent) &&
            (identical(other.wifi, wifi) || other.wifi == wifi) &&
            (identical(other.water, water) || other.water == water) &&
            (identical(other.electricity, electricity) ||
                other.electricity == electricity) &&
            (identical(other.acCost, acCost) || other.acCost == acCost) &&
            (identical(other.packageFull, packageFull) ||
                other.packageFull == packageFull) &&
            (identical(other.dimensions, dimensions) ||
                other.dimensions == dimensions) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            (identical(other.tenantName, tenantName) ||
                other.tenantName == tenantName) &&
            (identical(other.tenantAddress, tenantAddress) ||
                other.tenantAddress == tenantAddress) &&
            (identical(other.tenantPhone, tenantPhone) ||
                other.tenantPhone == tenantPhone) &&
            (identical(other.rentStartDate, rentStartDate) ||
                other.rentStartDate == rentStartDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    status,
    baseRent,
    wifi,
    water,
    electricity,
    acCost,
    packageFull,
    dimensions,
    const DeepCollectionEquality().hash(_imageUrls),
    tenantName,
    tenantAddress,
    tenantPhone,
    rentStartDate,
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room extends Room {
  const factory _Room({
    required final String code,
    required final String status,
    required final int baseRent,
    required final int wifi,
    required final int water,
    required final int electricity,
    final int acCost,
    final bool packageFull,
    final String dimensions,
    final List<String> imageUrls,
    final String? tenantName,
    final String? tenantAddress,
    final String? tenantPhone,
    final String? rentStartDate,
  }) = _$RoomImpl;
  const _Room._() : super._();

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get code;
  @override
  String get status;
  @override
  int get baseRent;
  @override
  int get wifi;
  @override
  int get water;
  @override
  int get electricity;
  @override
  int get acCost;
  @override
  bool get packageFull;
  @override
  String get dimensions;
  @override
  List<String> get imageUrls;
  @override
  String? get tenantName;
  @override
  String? get tenantAddress;
  @override
  String? get tenantPhone;
  @override
  String? get rentStartDate;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
