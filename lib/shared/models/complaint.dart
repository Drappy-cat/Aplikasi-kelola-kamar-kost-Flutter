import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint.freezed.dart';
part 'complaint.g.dart';

/// Model data untuk merepresentasikan satu pengaduan atau laporan masalah dari penghuni.
@freezed
class Complaint with _$Complaint {
  const factory Complaint({
    // ID unik untuk setiap pengaduan.
    required String id,
    // ID pengguna yang membuat pengaduan.
    required String userId,
    // Kode kamar dari mana pengaduan ini berasal.
    required String roomId,
    // Judul singkat dari pengaduan, misal: "Keran air bocor".
    required String title,
    // Deskripsi detail dari masalah yang dilaporkan.
    required String description,
    // Kategori pengaduan, misal: "Kerusakan Fasilitas", "Kebersihan".
    required String category,
    // Status penanganan pengaduan: "Pending", "In Progress", "Resolved", "Ditolak".
    required String status,
    // Daftar URL gambar bukti yang diunggah oleh pengguna.
    @Default([]) List<String> imageUrls,
    // Tanggal kapan pengaduan ini dibuat.
    required DateTime createdAt,
  }) = _Complaint;

  /// Factory constructor untuk membuat instance Complaint dari JSON.
  factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
}
