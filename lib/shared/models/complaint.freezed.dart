// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complaint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Complaint _$ComplaintFromJson(Map<String, dynamic> json) {
  return _Complaint.fromJson(json);
}

/// @nodoc
mixin _$Complaint {
  // ID unik untuk setiap pengaduan.
  String get id =>
      throw _privateConstructorUsedError; // ID pengguna yang membuat pengaduan.
  String get userId =>
      throw _privateConstructorUsedError; // Kode kamar dari mana pengaduan ini berasal.
  String get roomId =>
      throw _privateConstructorUsedError; // Judul singkat dari pengaduan, misal: "Keran air bocor".
  String get title =>
      throw _privateConstructorUsedError; // Deskripsi detail dari masalah yang dilaporkan.
  String get description =>
      throw _privateConstructorUsedError; // Kategori pengaduan, misal: "Kerusakan Fasilitas", "Kebersihan".
  String get category =>
      throw _privateConstructorUsedError; // Status penanganan pengaduan: "Pending", "In Progress", "Resolved", "Ditolak".
  String get status =>
      throw _privateConstructorUsedError; // Daftar URL gambar bukti yang diunggah oleh pengguna.
  List<String> get imageUrls =>
      throw _privateConstructorUsedError; // Tanggal kapan pengaduan ini dibuat.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Complaint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Complaint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComplaintCopyWith<Complaint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintCopyWith<$Res> {
  factory $ComplaintCopyWith(Complaint value, $Res Function(Complaint) then) =
      _$ComplaintCopyWithImpl<$Res, Complaint>;
  @useResult
  $Res call({
    String id,
    String userId,
    String roomId,
    String title,
    String description,
    String category,
    String status,
    List<String> imageUrls,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ComplaintCopyWithImpl<$Res, $Val extends Complaint>
    implements $ComplaintCopyWith<$Res> {
  _$ComplaintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Complaint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? status = null,
    Object? imageUrls = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$ComplaintImplCopyWith<$Res>
    implements $ComplaintCopyWith<$Res> {
  factory _$$ComplaintImplCopyWith(
    _$ComplaintImpl value,
    $Res Function(_$ComplaintImpl) then,
  ) = __$$ComplaintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String roomId,
    String title,
    String description,
    String category,
    String status,
    List<String> imageUrls,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ComplaintImplCopyWithImpl<$Res>
    extends _$ComplaintCopyWithImpl<$Res, _$ComplaintImpl>
    implements _$$ComplaintImplCopyWith<$Res> {
  __$$ComplaintImplCopyWithImpl(
    _$ComplaintImpl _value,
    $Res Function(_$ComplaintImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Complaint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? roomId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? status = null,
    Object? imageUrls = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ComplaintImpl(
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
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
class _$ComplaintImpl implements _Complaint {
  const _$ComplaintImpl({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    final List<String> imageUrls = const [],
    required this.createdAt,
  }) : _imageUrls = imageUrls;

  factory _$ComplaintImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintImplFromJson(json);

  // ID unik untuk setiap pengaduan.
  @override
  final String id;
  // ID pengguna yang membuat pengaduan.
  @override
  final String userId;
  // Kode kamar dari mana pengaduan ini berasal.
  @override
  final String roomId;
  // Judul singkat dari pengaduan, misal: "Keran air bocor".
  @override
  final String title;
  // Deskripsi detail dari masalah yang dilaporkan.
  @override
  final String description;
  // Kategori pengaduan, misal: "Kerusakan Fasilitas", "Kebersihan".
  @override
  final String category;
  // Status penanganan pengaduan: "Pending", "In Progress", "Resolved", "Ditolak".
  @override
  final String status;
  // Daftar URL gambar bukti yang diunggah oleh pengguna.
  final List<String> _imageUrls;
  // Daftar URL gambar bukti yang diunggah oleh pengguna.
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  // Tanggal kapan pengaduan ini dibuat.
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Complaint(id: $id, userId: $userId, roomId: $roomId, title: $title, description: $description, category: $category, status: $status, imageUrls: $imageUrls, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
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
    title,
    description,
    category,
    status,
    const DeepCollectionEquality().hash(_imageUrls),
    createdAt,
  );

  /// Create a copy of Complaint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintImplCopyWith<_$ComplaintImpl> get copyWith =>
      __$$ComplaintImplCopyWithImpl<_$ComplaintImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintImplToJson(this);
  }
}

abstract class _Complaint implements Complaint {
  const factory _Complaint({
    required final String id,
    required final String userId,
    required final String roomId,
    required final String title,
    required final String description,
    required final String category,
    required final String status,
    final List<String> imageUrls,
    required final DateTime createdAt,
  }) = _$ComplaintImpl;

  factory _Complaint.fromJson(Map<String, dynamic> json) =
      _$ComplaintImpl.fromJson;

  // ID unik untuk setiap pengaduan.
  @override
  String get id; // ID pengguna yang membuat pengaduan.
  @override
  String get userId; // Kode kamar dari mana pengaduan ini berasal.
  @override
  String get roomId; // Judul singkat dari pengaduan, misal: "Keran air bocor".
  @override
  String get title; // Deskripsi detail dari masalah yang dilaporkan.
  @override
  String get description; // Kategori pengaduan, misal: "Kerusakan Fasilitas", "Kebersihan".
  @override
  String get category; // Status penanganan pengaduan: "Pending", "In Progress", "Resolved", "Ditolak".
  @override
  String get status; // Daftar URL gambar bukti yang diunggah oleh pengguna.
  @override
  List<String> get imageUrls; // Tanggal kapan pengaduan ini dibuat.
  @override
  DateTime get createdAt;

  /// Create a copy of Complaint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComplaintImplCopyWith<_$ComplaintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
