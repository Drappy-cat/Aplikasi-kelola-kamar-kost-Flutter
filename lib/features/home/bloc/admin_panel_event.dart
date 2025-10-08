part of 'admin_panel_bloc.dart';

@freezed
abstract class AdminPanelEvent with _$AdminPanelEvent {
  const factory AdminPanelEvent.loadData() = LoadAdminData;
  const factory AdminPanelEvent.changeTab(int newIndex) = ChangeAdminTab;
}
