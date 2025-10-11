import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthService _authService = getIt<AuthService>();

  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateFullName>(_onUpdateFullName);
    on<UpdateProfilePicture>(_onUpdateProfilePicture);
    on<ChangePassword>(_onChangePassword);
    on<Logout>(_onLogout);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isLoading: true, error: null));
    final user = _authService.currentUser;
    if (user != null) {
      emit(state.copyWith(isLoading: false, user: user));
    } else {
      emit(state.copyWith(isLoading: false, error: 'Pengguna tidak ditemukan.'));
    }
  }

  Future<void> _onUpdateFullName(
      UpdateFullName event, Emitter<ProfileState> emit) async {
    await _authService.updateProfile(fullName: event.newName);
    add(const LoadProfile()); // Muat ulang data untuk menampilkan perubahan
  }

  Future<void> _onUpdateProfilePicture(
      UpdateProfilePicture event, Emitter<ProfileState> emit) async {
    await _authService.updateProfilePicture(event.newUrl);
    add(const LoadProfile()); // Muat ulang data untuk menampilkan perubahan
  }

  Future<void> _onChangePassword(
      ChangePassword event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      isPasswordChangeLoading: true,
      passwordChangeError: null,
      passwordChangeSuccess: null,
    ));
    try {
      await _authService.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      emit(state.copyWith(
        isPasswordChangeLoading: false,
        passwordChangeSuccess: 'Password berhasil diubah',
      ));
    } catch (e) {
      emit(state.copyWith(
        isPasswordChangeLoading: false,
        passwordChangeError: e.toString(),
      ));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<ProfileState> emit) async {
    await _authService.signOut();
    emit(state.copyWith(loggedOut: true));
  }
}
