class Bill {
  final String id;           // unik sederhana
  final String roomCode;     // referensi kamar
  final String month;        // contoh: "September 2025"
  final int total;
  String status;             // Belum Dibayar / Lunas
  String? method;            // Cash / Transfer
  String? channel;           // QRIS / Bank Transfer (jika method=Transfer)

  Bill({
    required this.id,
    required this.roomCode,
    required this.month,
    required this.total,
    required this.status,
    this.method,
    this.channel,
  });
}
