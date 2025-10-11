part of 'settings_bloc.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool isLoading,
    @Default({}) Map<String, String> deviceInfo,
    String? error,
  }) = _SettingsState;
}
