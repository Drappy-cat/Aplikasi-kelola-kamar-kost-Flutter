part of 'bill_bloc.dart';

@freezed
abstract class BillEvent with _$BillEvent {
  // Event untuk memuat daftar tagihan pengguna.
  const factory BillEvent.loadBills() = LoadBills;
  // Event saat pengguna mengonfirmasi pembayaran secara tunai.
  const factory BillEvent.confirmCashPayment(String billId) = ConfirmCashPayment;
  // Event saat pengguna mengirimkan bukti pembayaran transfer.
  const factory BillEvent.submitTransferProof(String billId, String proofUrl) = SubmitTransferProof;
}
