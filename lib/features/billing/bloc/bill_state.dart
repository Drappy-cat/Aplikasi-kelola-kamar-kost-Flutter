part of 'bill_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/bill.dart';

part 'bill_state.freezed.dart';

@freezed
abstract class BillState with _$BillState {
  const factory BillState.initial() = BillInitial;
  const factory BillState.loading() = BillLoading;
  const factory BillState.loaded(List<Bill> bills) = BillLoaded;
  const factory BillState.error(String message) = BillError;
}
