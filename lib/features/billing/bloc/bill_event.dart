part of 'bill_bloc.dart';

@immutable
abstract class BillEvent extends Equatable {
  const BillEvent();

  @override
  List<Object?> get props => [];
}

// Event untuk memuat semua tagihan pengguna
class LoadBills extends BillEvent {}

// Event saat pengguna memilih bayar tunai
class ConfirmCashPayment extends BillEvent {
  final String billId;

  const ConfirmCashPayment(this.billId);

  @override
  List<Object?> get props => [billId];
}

// Event saat pengguna mengunggah bukti transfer
class SubmitTransferProof extends BillEvent {
  final String billId;
  final String proofUrl;

  const SubmitTransferProof(this.billId, this.proofUrl);

  @override
  List<Object?> get props => [billId, proofUrl];
}
