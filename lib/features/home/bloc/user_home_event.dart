part of 'user_home_bloc.dart';

@freezed
abstract class UserHomeEvent with _$UserHomeEvent {
  const factory UserHomeEvent.loadData() = LoadUserHomeData;
}
