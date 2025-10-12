import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/chat_conversation.dart';
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
    on<ProcessRequest>(_onProcessRequest);
    on<ApproveBill>(_onApproveBill);
    on<RejectBill>(_onRejectBill);
    on<FilterComplaints>(_onFilterComplaints);
    on<UpdateComplaintStatus>(_onUpdateComplaintStatus);
  }

  void _onLoadData(LoadAdminData event, Emitter<AdminPanelState> emit) {
    emit(state.copyWith(isLoading: true));
    try {
      final rooms = _dummyService.rooms;
      final pendingBills = _dummyService.getPendingConfirmationBills();
      final requests = _dummyService.requests;
      final complaints = _dummyService.getAllComplaints();
      final announcements = _dummyService.getLatestAnnouncements();
      final conversations = _dummyService.conversations;

      // Urutkan percakapan berdasarkan pesan terakhir
      conversations.sort((a, b) {
        if (a.messages.isEmpty) return 1;
        if (b.messages.isEmpty) return -1;
        return b.messages.first.timestamp.compareTo(a.messages.first.timestamp);
      });

      final filteredComplaints = state.complaintStatusFilter == 'Semua'
          ? complaints
          : complaints.where((c) => c.status == state.complaintStatusFilter).toList();

      emit(state.copyWith(
        isLoading: false,
        rooms: rooms,
        pendingBills: pendingBills,
        requests: requests,
        complaints: complaints,
        announcements: announcements,
        filteredComplaints: filteredComplaints,
        conversations: conversations,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onChangeTab(ChangeAdminTab event, Emitter<AdminPanelState> emit) {
    emit(state.copyWith(activeTabIndex: event.newIndex));
  }

  Future<void> _onProcessRequest(ProcessRequest event, Emitter<AdminPanelState> emit) async {
    // ... (logika yang ada tidak berubah)
    add(const AdminPanelEvent.loadData());
  }

  Future<void> _onApproveBill(ApproveBill event, Emitter<AdminPanelState> emit) async {
    await _dummyService.approveBill(event.billId);
    add(const AdminPanelEvent.loadData());
  }

  Future<void> _onRejectBill(RejectBill event, Emitter<AdminPanelState> emit) async {
    await _dummyService.rejectBill(event.billId);
    add(const AdminPanelEvent.loadData());
  }

  void _onFilterComplaints(FilterComplaints event, Emitter<AdminPanelState> emit) {
    final filtered = event.status == 'Semua'
        ? state.complaints
        : state.complaints.where((c) => c.status == event.status).toList();
    emit(state.copyWith(
      filteredComplaints: filtered,
      complaintStatusFilter: event.status,
    ));
  }

  Future<void> _onUpdateComplaintStatus(
      UpdateComplaintStatus event, Emitter<AdminPanelState> emit) async {
    await _dummyService.updateComplaintStatus(event.complaintId, event.newStatus);
    add(const AdminPanelEvent.loadData());
  }
}
