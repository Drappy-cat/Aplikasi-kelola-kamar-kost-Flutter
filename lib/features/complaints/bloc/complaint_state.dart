part of 'complaint_bloc.dart';

@freezed
abstract class ComplaintState with _$ComplaintState {
  const factory ComplaintState({
    @Default(false) bool isLoading,
    @Default([]) List<Complaint> allComplaints,
    @Default([]) List<Complaint> filteredComplaints,
    String? error,
    @Default(false) bool isSubmitting,
    String? submissionError,
    String? submissionSuccess,
  }) = _ComplaintState;
}
