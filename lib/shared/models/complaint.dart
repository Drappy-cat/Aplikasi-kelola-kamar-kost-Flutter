class Complaint {
  final String id;
  final String userId;
  final String roomId;
  final String title;
  final String description;
  final String category;
  final String status; // "Pending", "In Progress", "Resolved"
  final List<String> imageUrls;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    this.imageUrls = const [],
    required this.createdAt,
  });
}
