import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint.freezed.dart';
part 'complaint.g.dart';

@freezed
class Complaint with _$Complaint {
  const factory Complaint({
    required String id,
    required String userId,
    required String roomId,
    required String title,
    required String description,
    required String category,
    required String status,
    @Default([]) List<String> imageUrls,
    required DateTime createdAt,
  }) = _Complaint;

  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
}
