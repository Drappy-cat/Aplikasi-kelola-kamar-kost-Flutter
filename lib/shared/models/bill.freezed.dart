// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bill _$BillFromJson(Map<String, dynamic> json) {
  return _Bill.fromJson(json);
}

/// @nodoc
mixin _$Bill {
  // ID unik untuk setiap tagihan.
  String get id =>
      throw _privateConstructorUsedError; // ID pengguna yang memiliki tagihan ini.
  String get userId =>
      throw _privateConstructorUsedError; // Kode kamar yang terkait dengan tagihan ini.
  String get roomId =>
      throw _privateConstructorUsedError; // Periode tagihan, misal: "Juli 2024".
  String get period =>
      throw _privateConstructorUsedError; // Jumlah total yang harus dibayar.
  double get amount =>
      throw _privateConstructorUsedError; // Status pembayaran saat ini: "Belum Lunas", "Menunggu Konfirmasi", "Lunas".
  String get status =>
      throw _privateConstructorUsedError; // URL ke gambar bukti pembayaran jika metode pembayaran adalah transfer.
  String? get paymentProofUrl =>
      throw _privateConstructorUsedError; // Metode pembayaran yang digunakan, misal: "Tunai", "Transfer", "Virtual Account".
  String? get paymentMethod =>
      throw _privateConstructorUsedError; // Tanggal kapan tagihan ini dibuat.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Bill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillCopyWith<Bill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillCopyWith<$Res> {
  factory $BillCopyWith(Bill value, $Res Function(Bill) then) =
      _$BillCopyWithImpl<$Res, Bill>;
  @useResult
  $Res call({
    String id,
    String userId,
    String roomId,
    String period,
    double amount,
    String status,
    String? paymentProofUrl,
    String? paymentMethod,
    DateTime createdAt,
  });
}

/// @nodoc
class _$BillCopyWithImpl<$Res, $Val extends Bill>
    implements $BillCopyWith<$Res> {
  _$BillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? period = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentProofUrl = freezed,
    Object? paymentMethod = freezed,
    Object? createdAt = null,
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
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentProofUrl: freezed == paymentProofUrl
                ? _value.paymentProofUrl
                : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BillImplCopyWith<$Res> implements $BillCopyWith<$Res> {
  factory _$$BillImplCopyWith(
    _$BillImpl value,
    $Res Function(_$BillImpl) then,
  ) = __$$BillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String roomId,
    String period,
    double amount,
    String status,
    String? paymentProofUrl,
    String? paymentMethod,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$BillImplCopyWithImpl<$Res>
    extends _$BillCopyWithImpl<$Res, _$BillImpl>
    implements _$$BillImplCopyWith<$Res> {
  __$$BillImplCopyWithImpl(_$BillImpl _value, $Res Function(_$BillImpl) _then)
    : super(_value, _then);

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? period = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentProofUrl = freezed,
    Object? paymentMethod = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$BillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentProofUrl: freezed == paymentProofUrl
            ? _value.paymentProofUrl
            : paymentProofUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BillImpl implements _Bill {
  const _$BillImpl({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.period,
    required this.amount,
    required this.status,
    this.paymentProofUrl,
    this.paymentMethod,
    required this.createdAt,
  });

  factory _$BillImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillImplFromJson(json);

  // ID unik untuk setiap tagihan.
  @override
  final String id;
  // ID pengguna yang memiliki tagihan ini.
  @override
  final String userId;
  // Kode kamar yang terkait dengan tagihan ini.
  @override
  final String roomId;
  // Periode tagihan, misal: "Juli 2024".
  @override
  final String period;
  // Jumlah total yang harus dibayar.
  @override
  final double amount;
  // Status pembayaran saat ini: "Belum Lunas", "Menunggu Konfirmasi", "Lunas".
  @override
  final String status;
  // URL ke gambar bukti pembayaran jika metode pembayaran adalah transfer.
  @override
  final String? paymentProofUrl;
  // Metode pembayaran yang digunakan, misal: "Tunai", "Transfer", "Virtual Account".
  @override
  final String? paymentMethod;
  // Tanggal kapan tagihan ini dibuat.
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Bill(id: $id, userId: $userId, roomId: $roomId, period: $period, amount: $amount, status: $status, paymentProofUrl: $paymentProofUrl, paymentMethod: $paymentMethod, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentProofUrl, paymentProofUrl) ||
                other.paymentProofUrl == paymentProofUrl) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    roomId,
    period,
    amount,
    status,
    paymentProofUrl,
    paymentMethod,
    createdAt,
  );

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillImplCopyWith<_$BillImpl> get copyWith =>
      __$$BillImplCopyWithImpl<_$BillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillImplToJson(this);
  }
}

abstract class _Bill implements Bill {
  const factory _Bill({
    required final String id,
    required final String userId,
    required final String roomId,
    required final String period,
    required final double amount,
    required final String status,
    final String? paymentProofUrl,
    final String? paymentMethod,
    required final DateTime createdAt,
  }) = _$BillImpl;

  factory _Bill.fromJson(Map<String, dynamic> json) = _$BillImpl.fromJson;

  // ID unik untuk setiap tagihan.
  @override
  String get id; // ID pengguna yang memiliki tagihan ini.
  @override
  String get userId; // Kode kamar yang terkait dengan tagihan ini.
  @override
  String get roomId; // Periode tagihan, misal: "Juli 2024".
  @override
  String get period; // Jumlah total yang harus dibayar.
  @override
  double get amount; // Status pembayaran saat ini: "Belum Lunas", "Menunggu Konfirmasi", "Lunas".
  @override
  String get status; // URL ke gambar bukti pembayaran jika metode pembayaran adalah transfer.
  @override
  String? get paymentProofUrl; // Metode pembayaran yang digunakan, misal: "Tunai", "Transfer", "Virtual Account".
  @override
  String? get paymentMethod; // Tanggal kapan tagihan ini dibuat.
  @override
  DateTime get createdAt;

  /// Create a copy of Bill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillImplCopyWith<_$BillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
