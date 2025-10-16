part of 'profile_bloc.dart';

@freezed
abstract class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.load() = LoadProfile;
  const factory ProfileEvent.updateFullName(String newName) = UpdateFullName;
  const factory ProfileEvent.updateProfilePicture(String newUrl) = UpdateProfilePicture;
  
  // EVENT BARU: Untuk memperbarui alamat dan nomor telepon.
  const factory ProfileEvent.updateContactInfo({
    required String address,
    required String phoneNumber,
  }) = UpdateContactInfo;

  const factory ProfileEvent.changePassword({
    required String oldPassword,
    required String newPassword,
  }) = ChangePassword;

  const factory ProfileEvent.logout() = Logout;
}
