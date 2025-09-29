import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
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
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
