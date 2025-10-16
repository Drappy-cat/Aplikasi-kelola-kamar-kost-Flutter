import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

/// Model data untuk merepresentasikan satu tagihan sewa bulanan.
@freezed
class Bill with _$Bill {
  const factory Bill({
    // ID unik untuk setiap tagihan.
    required String id,
    // ID pengguna yang memiliki tagihan ini.
    required String userId,
    // Kode kamar yang terkait dengan tagihan ini.
    required String roomId,
    // Periode tagihan, misal: "Juli 2024".
    required String period,
    // Jumlah total yang harus dibayar.
    required double amount,
    // Status pembayaran saat ini: "Belum Lunas", "Menunggu Konfirmasi", "Lunas".
    required String status,
    // URL ke gambar bukti pembayaran jika metode pembayaran adalah transfer.
    String? paymentProofUrl,
    // Metode pembayaran yang digunakan, misal: "Tunai", "Transfer", "Virtual Account".
    String? paymentMethod,
    // Tanggal kapan tagihan ini dibuat.
    required DateTime createdAt,
  }) = _Bill;

  /// Factory constructor untuk membuat instance Bill dari JSON.
  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
