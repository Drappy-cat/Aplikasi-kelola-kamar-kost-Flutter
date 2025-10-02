part of 'bill_bloc.dart';

@freezed
abstract class BillState with _$BillState {
  const factory BillState.initial() = BillInitial;
  const factory BillState.loading() = BillLoading;
  const factory BillState.loaded(List<Bill> bills) = BillLoaded;
  const factory BillState.error(String message) = BillError;
}
