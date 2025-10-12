import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  // Menambahkan private constructor agar bisa menambahkan method/getter
  const Room._();

  const factory Room({
    required String code,
    required String status,
    required int baseRent,
    required int wifi,
    required int water,
    required int electricity,
    @Default(0) int acCost,
    @Default(false) bool packageFull,
    @Default('N/A') String dimensions,
    @Default([]) List<String> imageUrls,
    String? tenantName,
    String? tenantAddress,
    String? tenantPhone,
    String? rentStartDate,
    // FIELD BARU
    String? fasilitasTambahan,
    @Default(false) bool isFurnished,
    @Default(1) int jumlahKasur,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  // GETTER BARU: Logika perhitungan harga sekarang menjadi milik model Room
  int get totalPrice {
    if (packageFull) return baseRent;
    // Menggunakan logika yang lebih lengkap (termasuk AC)
    return baseRent + wifi + water + electricity + acCost;
  }
}
