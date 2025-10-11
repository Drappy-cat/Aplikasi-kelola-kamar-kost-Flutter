part of 'activity_log_bloc.dart';

@freezed
abstract class ActivityLogState with _$ActivityLogState {
  const factory ActivityLogState({
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default([]) List<ActivityLog> logs,
    String? error,
    String? successMessage,
  }) = _ActivityLogState;
}
