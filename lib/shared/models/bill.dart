
class Bill {
  final String id;
  final String userId;
  final String roomId;
  final String period;
  final double amount;
  final String status; // "Belum Lunas", "Menunggu Konfirmasi", "Lunas"
  final String? paymentProofUrl;
  final DateTime createdAt;

  Bill({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.period,
    required this.amount,
    required this.status,
    this.paymentProofUrl,
    required this.createdAt,
  });
}
