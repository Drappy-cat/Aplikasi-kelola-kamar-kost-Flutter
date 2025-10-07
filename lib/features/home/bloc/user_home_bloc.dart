import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';
part 'user_home_bloc.freezed.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(const UserHomeState.initial()) {
    on<LoadUserHomeData>(_onLoadData);
  }

  Future<void> _onLoadData(LoadUserHomeData event, Emitter<UserHomeState> emit) async {
    emit(const UserHomeState.loading());
    try {
      final user = AuthService.currentUser;
      if (user == null) {
        emit(const UserHomeState.error('Sesi tidak valid. Silakan login kembali.'));
        return;
      }

      // Ambil data umum
      final announcements = DummyService.getLatestAnnouncements();
      final latestAnnouncement = announcements.isNotEmpty ? announcements.first : null;

      // Cek apakah pengguna adalah penghuni
      final bool isTenant = user.roomId != null;
      Room? userRoom;
      Bill? latestBill;
      List<Room> allRooms = [];

      if (isTenant) {
        userRoom = DummyService.findRoom(user.roomId!);
        if (userRoom != null) {
          final userBills = DummyService.getBillsForUser(user.id);
          if (userBills.isNotEmpty) {
            userBills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            latestBill = userBills.first;
          }
        }
      } else {
        allRooms = DummyService.rooms;
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
