import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

part 'bill_event.dart';
part 'bill_state.dart';
part 'bill_bloc.freezed.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final AuthService _authService = getIt<AuthService>();
  final DummyService _dummyService = getIt<DummyService>();

  BillBloc() : super(const BillState.initial()) {
    on<LoadBills>(_onLoadBills);
    on<ConfirmCashPayment>(_onConfirmCashPayment);
    on<SubmitTransferProof>(_onSubmitTransferProof);
  }

  Future<void> _onLoadBills(LoadBills event, Emitter<BillState> emit) async {
    emit(const BillState.loading());
    try {
      final userId = _authService.currentUser?.id;
      if (userId == null) {
        emit(const BillState.error('Pengguna tidak ditemukan. Silakan login kembali.'));
        return;
      }
      // PERBAIKAN: Logika pengurutan dihapus karena sudah ditangani oleh DummyService
      final bills = _dummyService.getBillsForUser(userId);
      emit(BillState.loaded(bills));
    } catch (e) {
      emit(BillState.error('Gagal memuat tagihan: ${e.toString()}'));
    }
  }

  Future<void> _onConfirmCashPayment(ConfirmCashPayment event, Emitter<BillState> emit) async {
    try {
      await _dummyService.confirmCashPayment(event.billId);
      add(const BillEvent.loadBills());
    } catch (e) {
      // handle error
    }
  }

  Future<void> _onSubmitTransferProof(SubmitTransferProof event, Emitter<BillState> emit) async {
    try {
      await _dummyService.submitPaymentProof(event.billId, event.proofUrl);
      add(const BillEvent.loadBills());
    } catch (e) {
      // handle error
    }
  }
}
