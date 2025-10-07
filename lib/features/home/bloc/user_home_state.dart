part of 'user_home_bloc.dart';

@freezed
abstract class UserHomeState with _$UserHomeState {
  const factory UserHomeState.initial() = _Initial;
  const factory UserHomeState.loading() = _Loading;
  const factory UserHomeState.loaded({
    required bool isTenant,
    Announcement? latestAnnouncement,
    Room? userRoom,
    Bill? latestBill,
    required List<Room> allRooms,
  }) = _Loaded;
  const factory UserHomeState.error(String message) = _Error;
}
