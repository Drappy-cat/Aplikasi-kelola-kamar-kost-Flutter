import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

part 'bill_event.dart';
part 'bill_state.dart';
part 'bill_bloc.freezed.dart'; // Tambahkan part untuk freezed

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(const BillState.initial()) {
    // Menggunakan satu handler utama dan memetakan event
    on<BillEvent>((event, emit) {
      event.map(
        loadBills: (event) => _onLoadBills(event, emit),
        confirmCashPayment: (event) => _onConfirmCashPayment(event, emit),
        submitTransferProof: (event) => _onSubmitTransferProof(event, emit),
      );
    });
  }

  void _onLoadBills(LoadBills event, Emitter<BillState> emit) {
    emit(const BillState.loading());
    try {
      final userId = AuthService.currentUser?.id;
      if (userId == null) {
        emit(const BillState.error('Pengguna tidak ditemukan. Silakan login kembali.'));
        return;
      }
      final bills = DummyService.getBillsForUser(userId);
      bills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(BillState.loaded(bills));
    } catch (e) {
      emit(BillState.error('Gagal memuat tagihan: ${e.toString()}'));
    }
  }

  void _onConfirmCashPayment(ConfirmCashPayment event, Emitter<BillState> emit) {
    try {
      DummyService.confirmCashPayment(event.billId);
      // Memicu event loadBills untuk me-refresh data
      add(const BillEvent.loadBills());
    } catch (e) {
      emit(BillState.error('Gagal mengonfirmasi pembayaran tunai: ${e.toString()}'));
    }
  }

  void _onSubmitTransferProof(SubmitTransferProof event, Emitter<BillState> emit) {
    try {
      DummyService.submitPaymentProof(event.billId, event.proofUrl);
      // Memicu event loadBills untuk me-refresh data
      add(const BillEvent.loadBills());
    } catch (e) {
      emit(BillState.error('Gagal mengirim bukti transfer: ${e.toString()}'));
    }
  }
}
