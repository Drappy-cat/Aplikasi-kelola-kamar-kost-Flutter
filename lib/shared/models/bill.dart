class Bill {
  // Properti (Data)
  final String id;
  final String roomCode;
  final String month;
  final String dueDate;
  final int total;
  String status;
  String? method;
  String? channel;

  Bill({
    required this.id,
    required this.roomCode,
    required this.month,
    required this.dueDate,
    required this.total,
    required this.status,
    this.method,
    this.channel,
  });
}
