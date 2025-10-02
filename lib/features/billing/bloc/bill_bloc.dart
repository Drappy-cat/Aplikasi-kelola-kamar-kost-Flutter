import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

// Semua 'part' file dideklarasikan di sini
part 'bill_event.dart';
part 'bill_state.dart';
part 'bill_bloc.freezed.dart'; // File ini akan dibuat otomatis

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(const BillState.initial()) {
    // Menggunakan sintaks modern untuk menangani event
    on<LoadBills>(_onLoadBills);
    on<ConfirmCashPayment>(_onConfirmCashPayment);
    on<SubmitTransferProof>(_onSubmitTransferProof);
  }

  // Tandai fungsi sebagai async jika melakukan operasi I/O
  Future<void> _onLoadBills(LoadBills event, Emitter<BillState> emit) async {
    emit(const BillState.loading());
    try {
      final userId = AuthService.currentUser?.id;
      if (userId == null) {
        emit(const BillState.error('Pengguna tidak ditemukan. Silakan login kembali.'));
        return;
      }
      // Jika DummyService.getBillsForUser() adalah async, tambahkan await
      final bills = DummyService.getBillsForUser(userId);
      bills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(BillState.loaded(bills));
    } catch (e) {
      emit(BillState.error('Gagal memuat tagihan: ${e.toString()}'));
    }
  }

  Future<void> _onConfirmCashPayment(ConfirmCashPayment event, Emitter<BillState> emit) async {
    try {
      DummyService.confirmCashPayment(event.billId);
      // Memicu event loadBills untuk me-refresh data
      add(const BillEvent.loadBills());
    } catch (e) {
      // Untuk menghindari UI error, sebaiknya jangan emit state error di sini,
      // cukup muat ulang data atau tampilkan snackbar.
      // Untuk saat ini, kita biarkan kosong agar tidak crash.
    }
  }

  Future<void> _onSubmitTransferProof(SubmitTransferProof event, Emitter<BillState> emit) async {
    try {
      DummyService.submitPaymentProof(event.billId, event.proofUrl);
      // Memicu event loadBills untuk me-refresh data
      add(const BillEvent.loadBills());
    } catch (e) {
      // Sama seperti di atas, hindari emit error jika memungkinkan
    }
  }
}
