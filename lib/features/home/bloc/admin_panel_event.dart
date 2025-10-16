part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelEvent with _$AdminPanelEvent {
  // Memuat semua data yang diperlukan untuk panel admin.
  const factory AdminPanelEvent.loadData() = LoadAdminData;
  // Mengubah tab yang sedang aktif di UI.
  const factory AdminPanelEvent.changeTab(int newIndex) = ChangeAdminTab;
  // Memproses permintaan dari pengguna (misal, menyetujui/menolak sewa).
  const factory AdminPanelEvent.processRequest(Request request, bool isApproved) = ProcessRequest;
  // Menyetujui pembayaran tagihan.
  const factory AdminPanelEvent.approveBill(String billId) = ApproveBill;
  // Menolak pembayaran tagihan.
  const factory AdminPanelEvent.rejectBill(String billId) = RejectBill;
  // Menyaring daftar pengaduan berdasarkan status.
  const factory AdminPanelEvent.filterComplaints(String status) = FilterComplaints;
  // Memperbarui status dari sebuah pengaduan.
  const factory AdminPanelEvent.updateComplaintStatus({
    required String complaintId,
    required String newStatus,
  }) = UpdateComplaintStatus;
}
