part of 'settings_bloc.dart';

@freezed
abstract class SettingsEvent with _$SettingsEvent {
  // Event untuk memuat informasi perangkat
  const factory SettingsEvent.loadDeviceInfo() = LoadDeviceInfo;
}
