import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';
part 'complaint_bloc.freezed.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  ComplaintBloc() : super(const ComplaintState()) {
    on<LoadComplaints>(_onLoadComplaints);
    on<FilterChanged>(_onFilterChanged);
    on<AddComplaint>(_onAddComplaint);
  }

  void _onLoadComplaints(LoadComplaints event, Emitter<ComplaintState> emit) {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final userId = _authService.currentUser?.id;
      if (userId == null) {
        throw 'Pengguna tidak ditemukan. Silakan login kembali.';
      }
      final complaints = _dummyService.getComplaintsForUser(userId);
      complaints.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      emit(state.copyWith(
        isLoading: false,
        allComplaints: complaints,
        filteredComplaints: complaints, // Awalnya, tampilkan semua
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onFilterChanged(FilterChanged event, Emitter<ComplaintState> emit) {
    final filtered = state.allComplaints.where((c) {
      final titleMatches = event.searchQuery == null ||
          c.title.toLowerCase().contains(event.searchQuery!.toLowerCase());
      final statusMatches =
          event.statusFilter == null || c.status == event.statusFilter;
      return titleMatches && statusMatches;
    }).toList();

    emit(state.copyWith(filteredComplaints: filtered));
  }

  Future<void> _onAddComplaint(
      AddComplaint event, Emitter<ComplaintState> emit) async {
    emit(state.copyWith(
      isSubmitting: true,
      submissionError: null,
      submissionSuccess: null,
    ));
    try {
      final user = _authService.currentUser;
      if (user == null || user.roomId == null) {
        throw 'Anda harus menjadi penghuni untuk membuat pengaduan.';
      }

      await _dummyService.addComplaint(
        userId: user.id,
        roomId: user.roomId!,
        title: event.title,
        description: event.description,
        category: event.category,
        imageUrls: event.imageUrls,
      );

      emit(state.copyWith(
        isSubmitting: false,
        submissionSuccess: 'Pengaduan berhasil dikirim!',
      ));
      // Muat ulang data setelah berhasil menambahkan
      add(const LoadComplaints());
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, submissionError: e.toString()));
    }
  }
}
