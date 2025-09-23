class Complaint {
  final String id;
  final String userId;
  final String roomId;
  final String title;
  final String description;
  final String status; // "Pending", "In Progress", "Resolved"
  final String? imageUrl;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.status,
    this.imageUrl,
    required this.createdAt,
  });
}
