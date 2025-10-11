part of 'notification_bloc.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(true) bool isLoading,
    @Default([]) List<AppNotification> notifications,
    String? error,
  }) = _NotificationState;
}
