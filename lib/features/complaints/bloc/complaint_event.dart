part of 'complaint_bloc.dart';

@freezed
abstract class ComplaintEvent with _$ComplaintEvent {
  // Event untuk memuat daftar keluhan awal
  const factory ComplaintEvent.load() = LoadComplaints;

  // Event saat filter diubah (baik teks pencarian maupun status)
  const factory ComplaintEvent.filterChanged({
    String? searchQuery,
    String? statusFilter,
  }) = FilterChanged;

  // Event untuk menambahkan keluhan baru
  const factory ComplaintEvent.add({
    required String title,
    required String description,
    required String category,
    required List<String> imageUrls,
  }) = AddComplaint;
}
