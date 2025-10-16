import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';
part 'request.g.dart';

/// Model data untuk merepresentasikan sebuah permintaan dari pengguna (misalnya, booking atau sewa).
@freezed
class Request with _$Request {
  const factory Request({
    // ID unik untuk setiap permintaan.
    required String id,
    // Jenis permintaan, misal: "Booking Tunai", "Sewa via VA".
    required String type,
    // Tanggal saat permintaan dibuat.
    required String date,
    // Catatan atau deskripsi tambahan untuk permintaan.
    required String note,
    // Status permintaan saat ini: "Menunggu Persetujuan", "Menunggu Pembayaran", "Disetujui", "Ditolak".
    required String status,
    // Kode kamar yang terkait dengan permintaan ini.
    String? roomCode,
    // Nama pengguna yang membuat permintaan.
    String? userName,

    // --- Properti untuk Alur Pembayaran ---

    // Metode pembayaran yang dipilih, misal: "Tunai", "Virtual Account", "QRIS".
    String? paymentMethod,
    // Tanggal dan waktu jatuh tempo pembayaran (untuk timer).
    DateTime? paymentDueDate,
    // Nomor Virtual Account yang digenerate untuk pembayaran.
    String? virtualAccountNumber,
    
  }) = _Request;

  /// Factory constructor untuk membuat instance Request dari JSON.
  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
}
