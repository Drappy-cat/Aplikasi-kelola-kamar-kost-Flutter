part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelEvent with _$AdminPanelEvent {
  const factory AdminPanelEvent.loadData() = LoadAdminData;
  const factory AdminPanelEvent.changeTab(int newIndex) = ChangeAdminTab;
  const factory AdminPanelEvent.processRequest(Request request, bool isApproved) = ProcessRequest;
  const factory AdminPanelEvent.approveBill(String billId) = ApproveBill;
  const factory AdminPanelEvent.rejectBill(String billId) = RejectBill;

  // Event baru untuk manajemen keluhan admin
  const factory AdminPanelEvent.filterComplaints(String status) = FilterComplaints;
  const factory AdminPanelEvent.updateComplaintStatus({
    required String complaintId,
    required String newStatus,
  }) = UpdateComplaintStatus;
}
