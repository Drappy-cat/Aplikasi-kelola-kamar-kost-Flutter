import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    on<LoadBills>(_onLoadBills);
    on<ConfirmCashPayment>(_onConfirmCashPayment);
    on<SubmitTransferProof>(_onSubmitTransferProof);
  }

  void _onLoadBills(LoadBills event, Emitter<BillState> emit) {
    emit(BillLoading());
    try {
      // Mengakses properti statis langsung dari kelas AuthService
      final userId = AuthService.currentUser?.id;
      if (userId == null) {
        emit(const BillError('Pengguna tidak ditemukan. Silakan login kembali.'));
        return;
      }
      // Memanggil metode statis langsung dari kelas DummyService
      final bills = DummyService.getBillsForUser(userId);
      bills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(BillLoaded(bills));
    } catch (e) {
      emit(BillError('Gagal memuat tagihan: ${e.toString()}'));
    }
  }

  void _onConfirmCashPayment(ConfirmCashPayment event, Emitter<BillState> emit) {
    try {
      // Memanggil metode statis langsung dari kelas DummyService
      DummyService.confirmCashPayment(event.billId);
      add(LoadBills());
    } catch (e) {
      emit(BillError('Gagal mengonfirmasi pembayaran tunai: ${e.toString()}'));
    }
  }

  void _onSubmitTransferProof(SubmitTransferProof event, Emitter<BillState> emit) {
    try {
      // Memanggil metode statis langsung dari kelas DummyService
      DummyService.submitPaymentProof(event.billId, event.proofUrl);
      add(LoadBills());
    } catch (e) {
      emit(BillError('Gagal mengirim bukti transfer: ${e.toString()}'));
    }
  }
}
