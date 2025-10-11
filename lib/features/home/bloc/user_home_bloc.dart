import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart'; // <-- IMPORT

part 'user_home_event.dart';
part 'user_home_state.dart';
part 'user_home_bloc.freezed.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  // Mengambil instance service dari GetIt
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  UserHomeBloc() : super(const UserHomeState.initial()) {
    on<LoadUserHomeData>(_onLoadData);
  }

  Future<void> _onLoadData(LoadUserHomeData event, Emitter<UserHomeState> emit) async {
    emit(const UserHomeState.loading());
    try {
      final user = _authService.currentUser;
      if (user == null) {
        emit(const UserHomeState.error('Sesi tidak valid. Silakan login kembali.'));
        return;
      }

      final announcements = _dummyService.getLatestAnnouncements();
      final latestAnnouncement = announcements.isNotEmpty ? announcements.first : null;

      final bool isTenant = user.roomId != null;
      Room? userRoom;
      Bill? latestBill;
      List<Room> allRooms = [];

      if (isTenant) {
        userRoom = _dummyService.findRoom(user.roomId!);
        // PERBAIKAN: Menggunakan metode baru dari DummyService
        latestBill = _dummyService.getLatestBillForUser(user.id);
      } else {
        allRooms = _dummyService.rooms;
      }

      emit(UserHomeState.loaded(
        isTenant: isTenant,
        latestAnnouncement: latestAnnouncement,
        userRoom: userRoom,
        latestBill: latestBill,
        allRooms: allRooms,
      ));
    } catch (e) {
      emit(UserHomeState.error('Gagal memuat data: ${e.toString()}'));
    }
  }
}
