part of 'activity_log_bloc.dart';

@freezed
abstract class ActivityLogEvent with _$ActivityLogEvent {
  // Event untuk menambahkan log baru (Berangkat/Pulang)
  const factory ActivityLogEvent.add(String action) = AddActivityLog;

  // Event untuk memuat semua log (untuk admin)
  const factory ActivityLogEvent.load() = LoadActivityLogs;
}
