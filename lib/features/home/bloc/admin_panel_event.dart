part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelEvent with _$AdminPanelEvent {
  const factory AdminPanelEvent.loadData() = LoadAdminData;
  const factory AdminPanelEvent.changeTab(int newIndex) = ChangeAdminTab;
  // EVENT BARU: Untuk memproses pengajuan (setuju/tolak)
  const factory AdminPanelEvent.processRequest(Request request, bool isApproved) = ProcessRequest;
}
