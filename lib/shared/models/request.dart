
class Request {
  final String id;
  final String type;
  final String date;
  final String note;
  String status;
  final String? roomCode;
  final String? userName;

  Request({
    required this.id,
    required this.type,
    required this.date,
    required this.note,
    required this.status,
    this.roomCode,
    this.userName,
  });
}
