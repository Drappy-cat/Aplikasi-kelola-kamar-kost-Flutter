part of 'complaint_bloc.dart';

@freezed
abstract class ComplaintEvent with _$ComplaintEvent {
  const factory ComplaintEvent.load() = LoadComplaints;

  const factory ComplaintEvent.filterChanged({
    String? searchQuery,
    String? statusFilter,
  }) = FilterChanged;

  const factory ComplaintEvent.add({
    required String title,
    required String description,
    required String category,
    required List<String> imageUrls,
  }) = AddComplaint;
}
