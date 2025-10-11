part of 'profile_bloc.dart';

@freezed
abstract class ProfileEvent with _$ProfileEvent {
  // Event untuk memuat data pengguna saat halaman dibuka
  const factory ProfileEvent.load() = LoadProfile;

  // Event untuk memperbarui nama lengkap
  const factory ProfileEvent.updateFullName(String newName) = UpdateFullName;

  // Event untuk memperbarui gambar profil
  const factory ProfileEvent.updateProfilePicture(String newUrl) = UpdateProfilePicture;

  // Event untuk mengubah password
  const factory ProfileEvent.changePassword({
    required String oldPassword,
    required String newPassword,
  }) = ChangePassword;

  // Event untuk logout
  const factory ProfileEvent.logout() = Logout;
}
