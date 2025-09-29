import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String userId,
    required String roomId,
    required String period,
    required double amount,
    required String status, // "Belum Lunas", "Menunggu Konfirmasi", "Lunas"
    String? paymentProofUrl,
    String? paymentMethod, // "Tunai", "Transfer"
    required DateTime createdAt,
  }) = _Bill;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
