import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'admin_panel_event.dart';
part 'admin_panel_state.dart';
part 'admin_panel_bloc.freezed.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  final DummyService _dummyService = getIt<DummyService>();

  AdminPanelBloc() : super(AdminPanelState.initial()) {
    on<LoadAdminData>(_onLoadData);
    on<ChangeAdminTab>(_onChangeTab);
  }

  void _onLoadData(LoadAdminData event, Emitter<AdminPanelState> emit) {
    emit(state.copyWith(isLoading: true));
    try {
      // Ambil semua data yang diperlukan untuk panel admin
      final rooms = _dummyService.rooms;
      final pendingBills = _dummyService.getPendingConfirmationBills();
      final requests = _dummyService.requests;
      final complaints = _dummyService.getAllComplaints();
      final announcements = _dummyService.getLatestAnnouncements();

      emit(state.copyWith(
        isLoading: false,
        rooms: rooms,
        pendingBills: pendingBills,
        requests: requests,
        complaints: complaints,
        announcements: announcements,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onChangeTab(ChangeAdminTab event, Emitter<AdminPanelState> emit) {
    emit(state.copyWith(activeTabIndex: event.newIndex));
  }
}
