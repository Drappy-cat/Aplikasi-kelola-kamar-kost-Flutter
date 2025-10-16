part of 'user_home_bloc.dart';

@freezed
abstract class UserHomeEvent with _$UserHomeEvent {
  // Event untuk memicu pemuatan semua data yang diperlukan untuk halaman utama pengguna.
  const factory UserHomeEvent.loadData() = LoadUserHomeData;
}
