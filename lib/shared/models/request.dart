
class Request {
  final String type;
  final String date;
  final String note;
  String status;
  final String? roomCode;
  final String? userName;

  Request({
    required this.type,
    required this.date,
    required this.note,
    required this.status,
    this.roomCode,
    this.userName,
  });
}
