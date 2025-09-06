class Request {
  final String type;   // Kunjungan Ortu / Pulang Kampung
  final String date;   // tanggal atau rentang
  final String note;
  String status;       // Pending / Disetujui / Ditolak

  Request({
    required this.type,
    required this.date,
    required this.note,
    required this.status,
  });
}
