part of 'complaint_bloc.dart';

@freezed
abstract class ComplaintState with _$ComplaintState {
  const factory ComplaintState({
    // Status loading keseluruhan halaman
    @Default(false) bool isLoading,
    // Daftar keluhan asli dari service
    @Default([]) List<Complaint> allComplaints,
    // Daftar keluhan yang akan ditampilkan di UI setelah difilter
    @Default([]) List<Complaint> filteredComplaints,
    // Pesan error jika terjadi kesalahan
    String? error,
    // Status untuk aksi penambahan keluhan
    @Default(false) bool isSubmitting,
    String? submissionError,
    String? submissionSuccess,
  }) = _ComplaintState;
}
