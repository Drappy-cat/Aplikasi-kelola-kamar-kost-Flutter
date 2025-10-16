import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_log.freezed.dart';
part 'activity_log.g.dart';

/// Model data untuk merepresentasikan satu catatan log aktivitas (keluar-masuk kost).
@freezed
class ActivityLog with _$ActivityLog {
  const factory ActivityLog({
    // ID unik untuk setiap log.
    required String id,
    // ID pengguna yang melakukan aktivitas.
    required String userId,
    // Nama pengguna untuk kemudahan tampilan.
    required String userName,
    // Jenis aksi yang dicatat, yaitu "Berangkat" atau "Pulang".
    required String action,
    // Waktu pasti saat aktivitas dicatat.
    required DateTime timestamp,
  }) = _ActivityLog;

  /// Factory constructor untuk membuat instance ActivityLog dari JSON.
  factory ActivityLog.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogFromJson(json);
}
