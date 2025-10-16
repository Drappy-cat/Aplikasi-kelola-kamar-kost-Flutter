import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'bill_event.dart';
part 'bill_state.dart';
part 'bill_bloc.freezed.dart';

/// BLoC ini mengelola state untuk halaman tagihan pengguna.
class BillBloc extends Bloc<BillEvent, BillState> {
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  BillBloc() : super(const BillState.initial()) {
    on<LoadBills>(_onLoadBills);
    on<ConfirmCashPayment>(_onConfirmCashPayment);
    on<SubmitTransferProof>(_onSubmitTransferProof);
  }

  /// Menangani event untuk memuat semua tagihan milik pengguna yang sedang login.
  Future<void> _onLoadBills(LoadBills event, Emitter<BillState> emit) async {
    emit(const BillState.loading());
    try {
      final userId = _authService.currentUser?.id;
      if (userId == null) {
        emit(const BillState.error('Pengguna tidak ditemukan. Silakan login kembali.'));
        return;
      }
      final bills = _dummyService.getBillsForUser(userId);
      emit(BillState.loaded(bills));
    } catch (e) {
      emit(BillState.error('Gagal memuat tagihan: ${e.toString()}'));
    }
  }

  /// Menangani event saat pengguna mengonfirmasi pembayaran secara tunai.
  Future<void> _onConfirmCashPayment(ConfirmCashPayment event, Emitter<BillState> emit) async {
    try {
      await _dummyService.confirmCashPayment(event.billId);
      // Setelah berhasil, muat ulang daftar tagihan untuk memperbarui UI.
      add(const BillEvent.loadBills());
    } catch (e) {
      emit(BillState.error('Gagal konfirmasi pembayaran tunai: ${e.toString()}'));
    }
  }

  /// Menangani event saat pengguna mengirimkan bukti transfer.
  Future<void> _onSubmitTransferProof(SubmitTransferProof event, Emitter<BillState> emit) async {
    try {
      await _dummyService.submitPaymentProof(event.billId, event.proofUrl);
      // Setelah berhasil, muat ulang daftar tagihan untuk memperbarui UI.
      add(const BillEvent.loadBills());
    } catch (e) {
      emit(BillState.error('Gagal mengirim bukti transfer: ${e.toString()}'));
    }
  }
}
