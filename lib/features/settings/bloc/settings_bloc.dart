import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadDeviceInfo>(_onLoadDeviceInfo);
  }

  Future<void> _onLoadDeviceInfo(
      LoadDeviceInfo event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      Map<String, String> info = {};

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        info = {
          'Model Perangkat': '${androidInfo.manufacturer.toUpperCase()} ${androidInfo.model}',
          'Sistem Operasi': 'Android ${androidInfo.version.release}',
          'Pabrikan': androidInfo.manufacturer,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        info = {
          'Model Perangkat': iosInfo.name ?? 'N/A',
          'Sistem Operasi': '${iosInfo.systemName} ${iosInfo.systemVersion}',
          'Pabrikan': 'Apple',
        };
      } else {
        // Handle platform lain jika diperlukan, misal web atau desktop
        info = {'Info': 'Platform tidak didukung untuk info perangkat.'};
      }

      emit(state.copyWith(isLoading: false, deviceInfo: info));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Gagal memuat info perangkat.',
      ));
    }
  }
}
