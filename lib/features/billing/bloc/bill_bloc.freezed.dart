// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BillEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBills,
    required TResult Function(String billId) confirmCashPayment,
    required TResult Function(String billId, String proofUrl)
    submitTransferProof,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBills,
    TResult? Function(String billId)? confirmCashPayment,
    TResult? Function(String billId, String proofUrl)? submitTransferProof,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBills,
    TResult Function(String billId)? confirmCashPayment,
    TResult Function(String billId, String proofUrl)? submitTransferProof,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadBills value) loadBills,
    required TResult Function(ConfirmCashPayment value) confirmCashPayment,
    required TResult Function(SubmitTransferProof value) submitTransferProof,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadBills value)? loadBills,
    TResult? Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult? Function(SubmitTransferProof value)? submitTransferProof,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadBills value)? loadBills,
    TResult Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult Function(SubmitTransferProof value)? submitTransferProof,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillEventCopyWith<$Res> {
  factory $BillEventCopyWith(BillEvent value, $Res Function(BillEvent) then) =
      _$BillEventCopyWithImpl<$Res, BillEvent>;
}

/// @nodoc
class _$BillEventCopyWithImpl<$Res, $Val extends BillEvent>
    implements $BillEventCopyWith<$Res> {
  _$BillEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBillsImplCopyWith<$Res> {
  factory _$$LoadBillsImplCopyWith(
    _$LoadBillsImpl value,
    $Res Function(_$LoadBillsImpl) then,
  ) = __$$LoadBillsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadBillsImplCopyWithImpl<$Res>
    extends _$BillEventCopyWithImpl<$Res, _$LoadBillsImpl>
    implements _$$LoadBillsImplCopyWith<$Res> {
  __$$LoadBillsImplCopyWithImpl(
    _$LoadBillsImpl _value,
    $Res Function(_$LoadBillsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadBillsImpl implements LoadBills {
  const _$LoadBillsImpl();

  @override
  String toString() {
    return 'BillEvent.loadBills()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadBillsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBills,
    required TResult Function(String billId) confirmCashPayment,
    required TResult Function(String billId, String proofUrl)
    submitTransferProof,
  }) {
    return loadBills();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBills,
    TResult? Function(String billId)? confirmCashPayment,
    TResult? Function(String billId, String proofUrl)? submitTransferProof,
  }) {
    return loadBills?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBills,
    TResult Function(String billId)? confirmCashPayment,
    TResult Function(String billId, String proofUrl)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (loadBills != null) {
      return loadBills();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadBills value) loadBills,
    required TResult Function(ConfirmCashPayment value) confirmCashPayment,
    required TResult Function(SubmitTransferProof value) submitTransferProof,
  }) {
    return loadBills(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadBills value)? loadBills,
    TResult? Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult? Function(SubmitTransferProof value)? submitTransferProof,
  }) {
    return loadBills?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadBills value)? loadBills,
    TResult Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult Function(SubmitTransferProof value)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (loadBills != null) {
      return loadBills(this);
    }
    return orElse();
  }
}

abstract class LoadBills implements BillEvent {
  const factory LoadBills() = _$LoadBillsImpl;
}

/// @nodoc
abstract class _$$ConfirmCashPaymentImplCopyWith<$Res> {
  factory _$$ConfirmCashPaymentImplCopyWith(
    _$ConfirmCashPaymentImpl value,
    $Res Function(_$ConfirmCashPaymentImpl) then,
  ) = __$$ConfirmCashPaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String billId});
}

/// @nodoc
class __$$ConfirmCashPaymentImplCopyWithImpl<$Res>
    extends _$BillEventCopyWithImpl<$Res, _$ConfirmCashPaymentImpl>
    implements _$$ConfirmCashPaymentImplCopyWith<$Res> {
  __$$ConfirmCashPaymentImplCopyWithImpl(
    _$ConfirmCashPaymentImpl _value,
    $Res Function(_$ConfirmCashPaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? billId = null}) {
    return _then(
      _$ConfirmCashPaymentImpl(
        null == billId
            ? _value.billId
            : billId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmCashPaymentImpl implements ConfirmCashPayment {
  const _$ConfirmCashPaymentImpl(this.billId);

  @override
  final String billId;

  @override
  String toString() {
    return 'BillEvent.confirmCashPayment(billId: $billId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmCashPaymentImpl &&
            (identical(other.billId, billId) || other.billId == billId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, billId);

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmCashPaymentImplCopyWith<_$ConfirmCashPaymentImpl> get copyWith =>
      __$$ConfirmCashPaymentImplCopyWithImpl<_$ConfirmCashPaymentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBills,
    required TResult Function(String billId) confirmCashPayment,
    required TResult Function(String billId, String proofUrl)
    submitTransferProof,
  }) {
    return confirmCashPayment(billId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBills,
    TResult? Function(String billId)? confirmCashPayment,
    TResult? Function(String billId, String proofUrl)? submitTransferProof,
  }) {
    return confirmCashPayment?.call(billId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBills,
    TResult Function(String billId)? confirmCashPayment,
    TResult Function(String billId, String proofUrl)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (confirmCashPayment != null) {
      return confirmCashPayment(billId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadBills value) loadBills,
    required TResult Function(ConfirmCashPayment value) confirmCashPayment,
    required TResult Function(SubmitTransferProof value) submitTransferProof,
  }) {
    return confirmCashPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadBills value)? loadBills,
    TResult? Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult? Function(SubmitTransferProof value)? submitTransferProof,
  }) {
    return confirmCashPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadBills value)? loadBills,
    TResult Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult Function(SubmitTransferProof value)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (confirmCashPayment != null) {
      return confirmCashPayment(this);
    }
    return orElse();
  }
}

abstract class ConfirmCashPayment implements BillEvent {
  const factory ConfirmCashPayment(final String billId) =
      _$ConfirmCashPaymentImpl;

  String get billId;

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmCashPaymentImplCopyWith<_$ConfirmCashPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitTransferProofImplCopyWith<$Res> {
  factory _$$SubmitTransferProofImplCopyWith(
    _$SubmitTransferProofImpl value,
    $Res Function(_$SubmitTransferProofImpl) then,
  ) = __$$SubmitTransferProofImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String billId, String proofUrl});
}

/// @nodoc
class __$$SubmitTransferProofImplCopyWithImpl<$Res>
    extends _$BillEventCopyWithImpl<$Res, _$SubmitTransferProofImpl>
    implements _$$SubmitTransferProofImplCopyWith<$Res> {
  __$$SubmitTransferProofImplCopyWithImpl(
    _$SubmitTransferProofImpl _value,
    $Res Function(_$SubmitTransferProofImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? billId = null, Object? proofUrl = null}) {
    return _then(
      _$SubmitTransferProofImpl(
        null == billId
            ? _value.billId
            : billId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == proofUrl
            ? _value.proofUrl
            : proofUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SubmitTransferProofImpl implements SubmitTransferProof {
  const _$SubmitTransferProofImpl(this.billId, this.proofUrl);

  @override
  final String billId;
  @override
  final String proofUrl;

  @override
  String toString() {
    return 'BillEvent.submitTransferProof(billId: $billId, proofUrl: $proofUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitTransferProofImpl &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.proofUrl, proofUrl) ||
                other.proofUrl == proofUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, billId, proofUrl);

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitTransferProofImplCopyWith<_$SubmitTransferProofImpl> get copyWith =>
      __$$SubmitTransferProofImplCopyWithImpl<_$SubmitTransferProofImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBills,
    required TResult Function(String billId) confirmCashPayment,
    required TResult Function(String billId, String proofUrl)
    submitTransferProof,
  }) {
    return submitTransferProof(billId, proofUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBills,
    TResult? Function(String billId)? confirmCashPayment,
    TResult? Function(String billId, String proofUrl)? submitTransferProof,
  }) {
    return submitTransferProof?.call(billId, proofUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBills,
    TResult Function(String billId)? confirmCashPayment,
    TResult Function(String billId, String proofUrl)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (submitTransferProof != null) {
      return submitTransferProof(billId, proofUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadBills value) loadBills,
    required TResult Function(ConfirmCashPayment value) confirmCashPayment,
    required TResult Function(SubmitTransferProof value) submitTransferProof,
  }) {
    return submitTransferProof(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadBills value)? loadBills,
    TResult? Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult? Function(SubmitTransferProof value)? submitTransferProof,
  }) {
    return submitTransferProof?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadBills value)? loadBills,
    TResult Function(ConfirmCashPayment value)? confirmCashPayment,
    TResult Function(SubmitTransferProof value)? submitTransferProof,
    required TResult orElse(),
  }) {
    if (submitTransferProof != null) {
      return submitTransferProof(this);
    }
    return orElse();
  }
}

abstract class SubmitTransferProof implements BillEvent {
  const factory SubmitTransferProof(
    final String billId,
    final String proofUrl,
  ) = _$SubmitTransferProofImpl;

  String get billId;
  String get proofUrl;

  /// Create a copy of BillEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitTransferProofImplCopyWith<_$SubmitTransferProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BillState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Bill> bills) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Bill> bills)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Bill> bills)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BillInitial value) initial,
    required TResult Function(BillLoading value) loading,
    required TResult Function(BillLoaded value) loaded,
    required TResult Function(BillError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BillInitial value)? initial,
    TResult? Function(BillLoading value)? loading,
    TResult? Function(BillLoaded value)? loaded,
    TResult? Function(BillError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BillInitial value)? initial,
    TResult Function(BillLoading value)? loading,
    TResult Function(BillLoaded value)? loaded,
    TResult Function(BillError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillStateCopyWith<$Res> {
  factory $BillStateCopyWith(BillState value, $Res Function(BillState) then) =
      _$BillStateCopyWithImpl<$Res, BillState>;
}

/// @nodoc
class _$BillStateCopyWithImpl<$Res, $Val extends BillState>
    implements $BillStateCopyWith<$Res> {
  _$BillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BillInitialImplCopyWith<$Res> {
  factory _$$BillInitialImplCopyWith(
    _$BillInitialImpl value,
    $Res Function(_$BillInitialImpl) then,
  ) = __$$BillInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BillInitialImplCopyWithImpl<$Res>
    extends _$BillStateCopyWithImpl<$Res, _$BillInitialImpl>
    implements _$$BillInitialImplCopyWith<$Res> {
  __$$BillInitialImplCopyWithImpl(
    _$BillInitialImpl _value,
    $Res Function(_$BillInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BillInitialImpl implements BillInitial {
  const _$BillInitialImpl();

  @override
  String toString() {
    return 'BillState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BillInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Bill> bills) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Bill> bills)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Bill> bills)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BillInitial value) initial,
    required TResult Function(BillLoading value) loading,
    required TResult Function(BillLoaded value) loaded,
    required TResult Function(BillError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BillInitial value)? initial,
    TResult? Function(BillLoading value)? loading,
    TResult? Function(BillLoaded value)? loaded,
    TResult? Function(BillError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BillInitial value)? initial,
    TResult Function(BillLoading value)? loading,
    TResult Function(BillLoaded value)? loaded,
    TResult Function(BillError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BillInitial implements BillState {
  const factory BillInitial() = _$BillInitialImpl;
}

/// @nodoc
abstract class _$$BillLoadingImplCopyWith<$Res> {
  factory _$$BillLoadingImplCopyWith(
    _$BillLoadingImpl value,
    $Res Function(_$BillLoadingImpl) then,
  ) = __$$BillLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BillLoadingImplCopyWithImpl<$Res>
    extends _$BillStateCopyWithImpl<$Res, _$BillLoadingImpl>
    implements _$$BillLoadingImplCopyWith<$Res> {
  __$$BillLoadingImplCopyWithImpl(
    _$BillLoadingImpl _value,
    $Res Function(_$BillLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BillLoadingImpl implements BillLoading {
  const _$BillLoadingImpl();

  @override
  String toString() {
    return 'BillState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BillLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Bill> bills) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Bill> bills)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Bill> bills)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BillInitial value) initial,
    required TResult Function(BillLoading value) loading,
    required TResult Function(BillLoaded value) loaded,
    required TResult Function(BillError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BillInitial value)? initial,
    TResult? Function(BillLoading value)? loading,
    TResult? Function(BillLoaded value)? loaded,
    TResult? Function(BillError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BillInitial value)? initial,
    TResult Function(BillLoading value)? loading,
    TResult Function(BillLoaded value)? loaded,
    TResult Function(BillError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BillLoading implements BillState {
  const factory BillLoading() = _$BillLoadingImpl;
}

/// @nodoc
abstract class _$$BillLoadedImplCopyWith<$Res> {
  factory _$$BillLoadedImplCopyWith(
    _$BillLoadedImpl value,
    $Res Function(_$BillLoadedImpl) then,
  ) = __$$BillLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Bill> bills});
}

/// @nodoc
class __$$BillLoadedImplCopyWithImpl<$Res>
    extends _$BillStateCopyWithImpl<$Res, _$BillLoadedImpl>
    implements _$$BillLoadedImplCopyWith<$Res> {
  __$$BillLoadedImplCopyWithImpl(
    _$BillLoadedImpl _value,
    $Res Function(_$BillLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bills = null}) {
    return _then(
      _$BillLoadedImpl(
        null == bills
            ? _value._bills
            : bills // ignore: cast_nullable_to_non_nullable
                  as List<Bill>,
      ),
    );
  }
}

/// @nodoc

class _$BillLoadedImpl implements BillLoaded {
  const _$BillLoadedImpl(final List<Bill> bills) : _bills = bills;

  final List<Bill> _bills;
  @override
  List<Bill> get bills {
    if (_bills is EqualUnmodifiableListView) return _bills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bills);
  }

  @override
  String toString() {
    return 'BillState.loaded(bills: $bills)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillLoadedImpl &&
            const DeepCollectionEquality().equals(other._bills, _bills));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_bills));

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillLoadedImplCopyWith<_$BillLoadedImpl> get copyWith =>
      __$$BillLoadedImplCopyWithImpl<_$BillLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Bill> bills) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(bills);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Bill> bills)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(bills);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Bill> bills)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bills);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BillInitial value) initial,
    required TResult Function(BillLoading value) loading,
    required TResult Function(BillLoaded value) loaded,
    required TResult Function(BillError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BillInitial value)? initial,
    TResult? Function(BillLoading value)? loading,
    TResult? Function(BillLoaded value)? loaded,
    TResult? Function(BillError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BillInitial value)? initial,
    TResult Function(BillLoading value)? loading,
    TResult Function(BillLoaded value)? loaded,
    TResult Function(BillError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BillLoaded implements BillState {
  const factory BillLoaded(final List<Bill> bills) = _$BillLoadedImpl;

  List<Bill> get bills;

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillLoadedImplCopyWith<_$BillLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BillErrorImplCopyWith<$Res> {
  factory _$$BillErrorImplCopyWith(
    _$BillErrorImpl value,
    $Res Function(_$BillErrorImpl) then,
  ) = __$$BillErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BillErrorImplCopyWithImpl<$Res>
    extends _$BillStateCopyWithImpl<$Res, _$BillErrorImpl>
    implements _$$BillErrorImplCopyWith<$Res> {
  __$$BillErrorImplCopyWithImpl(
    _$BillErrorImpl _value,
    $Res Function(_$BillErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$BillErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BillErrorImpl implements BillError {
  const _$BillErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BillState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillErrorImplCopyWith<_$BillErrorImpl> get copyWith =>
      __$$BillErrorImplCopyWithImpl<_$BillErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Bill> bills) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Bill> bills)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Bill> bills)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BillInitial value) initial,
    required TResult Function(BillLoading value) loading,
    required TResult Function(BillLoaded value) loaded,
    required TResult Function(BillError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BillInitial value)? initial,
    TResult? Function(BillLoading value)? loading,
    TResult? Function(BillLoaded value)? loaded,
    TResult? Function(BillError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BillInitial value)? initial,
    TResult Function(BillLoading value)? loading,
    TResult Function(BillLoaded value)? loaded,
    TResult Function(BillError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BillError implements BillState {
  const factory BillError(final String message) = _$BillErrorImpl;

  String get message;

  /// Create a copy of BillState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillErrorImplCopyWith<_$BillErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
