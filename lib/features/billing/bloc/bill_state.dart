part of 'bill_bloc.dart';

@immutable
abstract class BillState extends Equatable {
  const BillState();

  @override
  List<Object> get props => [];
}

// State awal, sebelum ada aksi apa pun
class BillInitial extends BillState {}

// State saat data tagihan sedang dimuat
class BillLoading extends BillState {}

// State saat data tagihan berhasil dimuat
class BillLoaded extends BillState {
  final List<Bill> bills;

  const BillLoaded(this.bills);

  @override
  List<Object> get props => [bills];
}

// State saat terjadi error
class BillError extends BillState {
  final String message;

  const BillError(this.message);

  @override
  List<Object> get props => [message];
}
