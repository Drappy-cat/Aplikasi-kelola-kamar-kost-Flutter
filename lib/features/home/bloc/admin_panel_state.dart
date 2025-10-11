part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelState with _$AdminPanelState {
  const factory AdminPanelState({
    required int activeTabIndex,
    required List<Room> rooms,
    required List<Bill> pendingBills,
    required List<Request> requests,
    required List<Complaint> complaints,
    required List<Announcement> announcements,
    required bool isLoading,
    String? error,

    // State untuk manajemen keluhan admin
    @Default([]) List<Complaint> filteredComplaints,
    @Default('Semua') String complaintStatusFilter,

    // PERBAIKAN: State baru untuk daftar percakapan chat
    @Default([]) List<ChatConversation> conversations,
  }) = _AdminPanelState;

  factory AdminPanelState.initial() => const AdminPanelState(
        activeTabIndex: 0,
        rooms: [],
        pendingBills: [],
        requests: [],
        complaints: [],
        announcements: [],
        isLoading: true,
        error: null,
        filteredComplaints: [],
        complaintStatusFilter: 'Semua',
        conversations: [], // Inisialisasi state baru
      );
}
