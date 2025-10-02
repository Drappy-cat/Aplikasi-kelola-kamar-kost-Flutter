part of 'bill_bloc.dart';

@freezed
abstract class BillEvent with _$BillEvent {
  const factory BillEvent.loadBills() = LoadBills;
  const factory BillEvent.confirmCashPayment(String billId) = ConfirmCashPayment;
  const factory BillEvent.submitTransferProof(String billId, String proofUrl) = SubmitTransferProof;
}
