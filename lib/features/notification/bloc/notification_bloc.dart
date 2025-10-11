import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final DummyService _dummyService = getIt<DummyService>();

  NotificationBloc() : super(const NotificationState()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<MarkAsRead>(_onMarkAsRead);
  }

  void _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final notifications = _dummyService.notifications;
      // Urutkan notifikasi agar yang belum dibaca muncul di atas
      notifications.sort((a, b) {
        if (a.isRead == b.isRead) return b.date.compareTo(a.date);
        return a.isRead ? 1 : -1;
      });
      emit(state.copyWith(isLoading: false, notifications: notifications));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onMarkAsRead(
      MarkAsRead event, Emitter<NotificationState> emit) async {
    try {
      final notification = _dummyService.notifications[event.notificationIndex];
      if (!notification.isRead) {
        final updatedNotif = notification.copyWith(isRead: true);
        // Panggil metode baru di service yang akan menyimpan perubahan
        await _dummyService.updateNotification(event.notificationIndex, updatedNotif);
        // Muat ulang data untuk menampilkan perubahan
        add(const LoadNotifications());
      }
    } catch (e) {
      // Bisa ditambahkan penanganan error jika diperlukan
      emit(state.copyWith(error: 'Gagal memperbarui notifikasi.'));
    }
  }
}
