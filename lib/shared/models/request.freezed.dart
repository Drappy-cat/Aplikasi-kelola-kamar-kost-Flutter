// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Request _$RequestFromJson(Map<String, dynamic> json) {
  return _Request.fromJson(json);
}

/// @nodoc
mixin _$Request {
  String get id => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'Booking Kamar', 'Sewa Langsung', dll.
  String get date => throw _privateConstructorUsedError;
  String get note =>
      throw _privateConstructorUsedError; // Status bisa lebih deskriptif: 'Pending', 'Menunggu Pembayaran', 'Disetujui', 'Ditolak'
  String get status => throw _privateConstructorUsedError;
  String? get roomCode => throw _privateConstructorUsedError;
  String? get userName =>
      throw _privateConstructorUsedError; // Kolom baru untuk alur pembayaran
  String? get paymentMethod => throw _privateConstructorUsedError;
  DateTime? get paymentDueDate => throw _privateConstructorUsedError;
  String? get virtualAccountNumber => throw _privateConstructorUsedError;

  /// Serializes this Request to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestCopyWith<Request> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestCopyWith<$Res> {
  factory $RequestCopyWith(Request value, $Res Function(Request) then) =
      _$RequestCopyWithImpl<$Res, Request>;
  @useResult
  $Res call({
    String id,
    String type,
    String date,
    String note,
    String status,
    String? roomCode,
    String? userName,
    String? paymentMethod,
    DateTime? paymentDueDate,
    String? virtualAccountNumber,
  });
}

/// @nodoc
class _$RequestCopyWithImpl<$Res, $Val extends Request>
    implements $RequestCopyWith<$Res> {
  _$RequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? note = null,
    Object? status = null,
    Object? roomCode = freezed,
    Object? userName = freezed,
    Object? paymentMethod = freezed,
    Object? paymentDueDate = freezed,
    Object? virtualAccountNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            note: null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            roomCode: freezed == roomCode
                ? _value.roomCode
                : roomCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentDueDate: freezed == paymentDueDate
                ? _value.paymentDueDate
                : paymentDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            virtualAccountNumber: freezed == virtualAccountNumber
                ? _value.virtualAccountNumber
                : virtualAccountNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestImplCopyWith<$Res> implements $RequestCopyWith<$Res> {
  factory _$$RequestImplCopyWith(
    _$RequestImpl value,
    $Res Function(_$RequestImpl) then,
  ) = __$$RequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String date,
    String note,
    String status,
    String? roomCode,
    String? userName,
    String? paymentMethod,
    DateTime? paymentDueDate,
    String? virtualAccountNumber,
  });
}

/// @nodoc
class __$$RequestImplCopyWithImpl<$Res>
    extends _$RequestCopyWithImpl<$Res, _$RequestImpl>
    implements _$$RequestImplCopyWith<$Res> {
  __$$RequestImplCopyWithImpl(
    _$RequestImpl _value,
    $Res Function(_$RequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? date = null,
    Object? note = null,
    Object? status = null,
    Object? roomCode = freezed,
    Object? userName = freezed,
    Object? paymentMethod = freezed,
    Object? paymentDueDate = freezed,
    Object? virtualAccountNumber = freezed,
  }) {
    return _then(
      _$RequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        note: null == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        roomCode: freezed == roomCode
            ? _value.roomCode
            : roomCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentDueDate: freezed == paymentDueDate
            ? _value.paymentDueDate
            : paymentDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        virtualAccountNumber: freezed == virtualAccountNumber
            ? _value.virtualAccountNumber
            : virtualAccountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestImpl implements _Request {
  const _$RequestImpl({
    required this.id,
    required this.type,
    required this.date,
    required this.note,
    required this.status,
    this.roomCode,
    this.userName,
    this.paymentMethod,
    this.paymentDueDate,
    this.virtualAccountNumber,
  });

  factory _$RequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  // 'Booking Kamar', 'Sewa Langsung', dll.
  @override
  final String date;
  @override
  final String note;
  // Status bisa lebih deskriptif: 'Pending', 'Menunggu Pembayaran', 'Disetujui', 'Ditolak'
  @override
  final String status;
  @override
  final String? roomCode;
  @override
  final String? userName;
  // Kolom baru untuk alur pembayaran
  @override
  final String? paymentMethod;
  @override
  final DateTime? paymentDueDate;
  @override
  final String? virtualAccountNumber;

  @override
  String toString() {
    return 'Request(id: $id, type: $type, date: $date, note: $note, status: $status, roomCode: $roomCode, userName: $userName, paymentMethod: $paymentMethod, paymentDueDate: $paymentDueDate, virtualAccountNumber: $virtualAccountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentDueDate, paymentDueDate) ||
                other.paymentDueDate == paymentDueDate) &&
            (identical(other.virtualAccountNumber, virtualAccountNumber) ||
                other.virtualAccountNumber == virtualAccountNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    date,
    note,
    status,
    roomCode,
    userName,
    paymentMethod,
    paymentDueDate,
    virtualAccountNumber,
  );

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestImplCopyWith<_$RequestImpl> get copyWith =>
      __$$RequestImplCopyWithImpl<_$RequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestImplToJson(this);
  }
}

abstract class _Request implements Request {
  const factory _Request({
    required final String id,
    required final String type,
    required final String date,
    required final String note,
    required final String status,
    final String? roomCode,
    final String? userName,
    final String? paymentMethod,
    final DateTime? paymentDueDate,
    final String? virtualAccountNumber,
  }) = _$RequestImpl;

  factory _Request.fromJson(Map<String, dynamic> json) = _$RequestImpl.fromJson;

  @override
  String get id;
  @override
  String get type; // 'Booking Kamar', 'Sewa Langsung', dll.
  @override
  String get date;
  @override
  String get note; // Status bisa lebih deskriptif: 'Pending', 'Menunggu Pembayaran', 'Disetujui', 'Ditolak'
  @override
  String get status;
  @override
  String? get roomCode;
  @override
  String? get userName; // Kolom baru untuk alur pembayaran
  @override
  String? get paymentMethod;
  @override
  DateTime? get paymentDueDate;
  @override
  String? get virtualAccountNumber;

  /// Create a copy of Request
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestImplCopyWith<_$RequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
