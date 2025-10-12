import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

@freezed
class Request with _$Request {
  const factory Request({
    required String id,
    required String type, // 'Booking Kamar', 'Sewa Langsung', dll.
    required String date,
    required String note,
    // Status bisa lebih deskriptif: 'Pending', 'Menunggu Pembayaran', 'Disetujui', 'Ditolak'
    required String status,
    String? roomCode,
    String? userName,

    // Kolom baru untuk alur pembayaran
    String? paymentMethod,
    DateTime? paymentDueDate,
    String? virtualAccountNumber,
    
  }) = _Request;

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
}
