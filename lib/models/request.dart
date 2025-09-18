class Request {
  final String type;   // Kunjungan Ortu / Pulang Kampung / Booking Kamar / Berhenti
  final String date;   // tanggal / rentang / timestamp
  final String note;
  String status;       // Pending / Disetujui / Ditolak

  // Opsional (tidak memecahkan admin yang lama)
  final String? roomCode;   // kamar terkait (kalau ada)
  final String? userName;   // siapa yang ajukan (kalau user)

  Request({
    required this.type,
    required this.date,
    required this.note,
    required this.status,
    this.roomCode,
    this.userName,
  });
}
