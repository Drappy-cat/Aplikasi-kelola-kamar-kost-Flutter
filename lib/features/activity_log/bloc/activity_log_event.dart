part of 'activity_log_bloc.dart';

@freezed
abstract class ActivityLogEvent with _$ActivityLogEvent {
  const factory ActivityLogEvent.add(String action) = AddActivityLog;

  const factory ActivityLogEvent.load() = LoadActivityLogs;
}
