class Message {
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String text;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.senderUsername,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });
}
