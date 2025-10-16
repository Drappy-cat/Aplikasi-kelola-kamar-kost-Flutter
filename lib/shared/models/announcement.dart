import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';
part 'announcement.g.dart';

/// Model data untuk merepresentasikan satu pengumuman yang dibuat oleh admin.
@freezed
class Announcement with _$Announcement {
  const factory Announcement({
    // ID unik untuk setiap pengumuman.
    required String id,
    // Judul pengumuman.
    required String title,
    // Isi atau konten detail dari pengumuman.
    required String content,
    // Tanggal kapan pengumuman ini dibuat.
    required DateTime createdAt,
  }) = _Announcement;

  /// Factory constructor untuk membuat instance Announcement dari JSON.
  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
}
