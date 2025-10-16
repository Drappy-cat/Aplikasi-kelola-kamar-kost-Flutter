part of 'bill_bloc.dart';

@freezed
abstract class BillState with _$BillState {
  // State awal sebelum data tagihan dimuat.
  const factory BillState.initial() = BillInitial;
  // State saat data tagihan sedang dalam proses pemuatan.
  const factory BillState.loading() = BillLoading;
  // State saat data tagihan berhasil dimuat dan siap ditampilkan.
  const factory BillState.loaded(List<Bill> bills) = BillLoaded;
  // State jika terjadi kesalahan saat memuat atau memproses data tagihan.
  const factory BillState.error(String message) = BillError;
}
