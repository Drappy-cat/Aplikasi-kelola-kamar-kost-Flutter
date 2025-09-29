import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  // Menambahkan constructor privat agar bisa membuat custom getter
  const AppUser._();

  const factory AppUser({
    required String id,
    required String username,
    required String password,
    required String role,
    String? fullName,
    String? profileImageUrl,
    String? roomId,
  }) = _AppUser;

  // Custom getter untuk mendapatkan nama
  String get name => fullName ?? username;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
