part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    // Status keseluruhan halaman
    @Default(false) bool isLoading,
    // Data pengguna yang akan ditampilkan
    AppUser? user,
    // Untuk menampilkan pesan error umum
    String? error,
    // Status spesifik untuk aksi ubah password
    @Default(false) bool isPasswordChangeLoading,
    String? passwordChangeError,
    String? passwordChangeSuccess,
    // Status untuk aksi logout
    @Default(false) bool loggedOut,
  }) = _ProfileState;
}
