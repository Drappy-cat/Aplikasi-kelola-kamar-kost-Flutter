part of 'notification_bloc.dart';

@freezed
abstract class NotificationEvent with _$NotificationEvent {
  // Event untuk memuat daftar notifikasi
  const factory NotificationEvent.load() = LoadNotifications;

  // Event untuk menandai notifikasi sebagai telah dibaca
  const factory NotificationEvent.markAsRead(int notificationIndex) = MarkAsRead;
}
