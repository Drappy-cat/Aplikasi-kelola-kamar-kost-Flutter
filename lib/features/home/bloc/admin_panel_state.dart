part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelState with _$AdminPanelState {
  const factory AdminPanelState({
    // Indeks tab yang sedang aktif di UI.
    required int activeTabIndex,
    // Daftar semua data yang dikelola oleh admin.
    required List<Room> rooms,
    required List<Bill> pendingBills,
    required List<Request> requests,
    required List<Complaint> complaints,
    required List<Announcement> announcements,
    required List<ChatConversation> conversations,

    // Status loading untuk menampilkan CircularProgressIndicator.
    required bool isLoading,
    // Menyimpan pesan error jika terjadi kesalahan.
    String? error,

    // State spesifik untuk fitur filter di halaman pengaduan.
    @Default([]) List<Complaint> filteredComplaints,
    @Default('Semua') String complaintStatusFilter,
  }) = _AdminPanelState;

  // Factory constructor untuk membuat state awal saat BLoC pertama kali diinisialisasi.
  factory AdminPanelState.initial() => const AdminPanelState(
        activeTabIndex: 0,
        rooms: [],
        pendingBills: [],
        requests: [],
        complaints: [],
        announcements: [],
        conversations: [],
        isLoading: true,
        error: null,
      );
}
