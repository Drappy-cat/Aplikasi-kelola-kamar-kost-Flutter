import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/activity_log.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'activity_log_event.dart';
part 'activity_log_state.dart';
part 'activity_log_bloc.freezed.dart';

class ActivityLogBloc extends Bloc<ActivityLogEvent, ActivityLogState> {
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  ActivityLogBloc() : super(const ActivityLogState()) {
    on<AddActivityLog>(_onAddActivityLog);
    on<LoadActivityLogs>(_onLoadActivityLogs);
  }

  Future<void> _onAddActivityLog(
      AddActivityLog event, Emitter<ActivityLogState> emit) async {
    emit(state.copyWith(isSubmitting: true, error: null, successMessage: null));
    try {
      final user = _authService.currentUser;
      if (user == null) {
        throw 'Sesi pengguna tidak valid.';
      }

      // 1. log aktivitas
      await _dummyService.addActivityLog(
        userId: user.id,
        userName: user.fullName ?? user.username,
        action: event.action,
      );

      // 2. notifikasi untuk admin
      await _dummyService.addNotification(
        title: 'Aktivitas Penghuni',
        subtitle: '${user.fullName ?? user.username} telah mencatat aktivitas \'${event.action}\'.',
        icon: Icons.history_toggle_off_outlined,
        iconColor: Colors.blue,
      );

      emit(state.copyWith(
        isSubmitting: false,
        successMessage: 'Aktivitas \'${event.action}\' berhasil dicatat.',
      ));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }

  void _onLoadActivityLogs(
      LoadActivityLogs event, Emitter<ActivityLogState> emit) {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final logs = _dummyService.activityLogs;
      emit(state.copyWith(isLoading: false, logs: logs));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
