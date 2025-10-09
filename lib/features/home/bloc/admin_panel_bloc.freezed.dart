// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_panel_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminPanelEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(int newIndex) changeTab,
    required TResult Function(Request request, bool isApproved) processRequest,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(int newIndex)? changeTab,
    TResult? Function(Request request, bool isApproved)? processRequest,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(int newIndex)? changeTab,
    TResult Function(Request request, bool isApproved)? processRequest,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAdminData value) loadData,
    required TResult Function(ChangeAdminTab value) changeTab,
    required TResult Function(ProcessRequest value) processRequest,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAdminData value)? loadData,
    TResult? Function(ChangeAdminTab value)? changeTab,
    TResult? Function(ProcessRequest value)? processRequest,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAdminData value)? loadData,
    TResult Function(ChangeAdminTab value)? changeTab,
    TResult Function(ProcessRequest value)? processRequest,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPanelEventCopyWith<$Res> {
  factory $AdminPanelEventCopyWith(
    AdminPanelEvent value,
    $Res Function(AdminPanelEvent) then,
  ) = _$AdminPanelEventCopyWithImpl<$Res, AdminPanelEvent>;
}

/// @nodoc
class _$AdminPanelEventCopyWithImpl<$Res, $Val extends AdminPanelEvent>
    implements $AdminPanelEventCopyWith<$Res> {
  _$AdminPanelEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadAdminDataImplCopyWith<$Res> {
  factory _$$LoadAdminDataImplCopyWith(
    _$LoadAdminDataImpl value,
    $Res Function(_$LoadAdminDataImpl) then,
  ) = __$$LoadAdminDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadAdminDataImplCopyWithImpl<$Res>
    extends _$AdminPanelEventCopyWithImpl<$Res, _$LoadAdminDataImpl>
    implements _$$LoadAdminDataImplCopyWith<$Res> {
  __$$LoadAdminDataImplCopyWithImpl(
    _$LoadAdminDataImpl _value,
    $Res Function(_$LoadAdminDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadAdminDataImpl implements LoadAdminData {
  const _$LoadAdminDataImpl();

  @override
  String toString() {
    return 'AdminPanelEvent.loadData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadAdminDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(int newIndex) changeTab,
    required TResult Function(Request request, bool isApproved) processRequest,
  }) {
    return loadData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(int newIndex)? changeTab,
    TResult? Function(Request request, bool isApproved)? processRequest,
  }) {
    return loadData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(int newIndex)? changeTab,
    TResult Function(Request request, bool isApproved)? processRequest,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAdminData value) loadData,
    required TResult Function(ChangeAdminTab value) changeTab,
    required TResult Function(ProcessRequest value) processRequest,
  }) {
    return loadData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAdminData value)? loadData,
    TResult? Function(ChangeAdminTab value)? changeTab,
    TResult? Function(ProcessRequest value)? processRequest,
  }) {
    return loadData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAdminData value)? loadData,
    TResult Function(ChangeAdminTab value)? changeTab,
    TResult Function(ProcessRequest value)? processRequest,
    required TResult orElse(),
  }) {
    if (loadData != null) {
      return loadData(this);
    }
    return orElse();
  }
}

abstract class LoadAdminData implements AdminPanelEvent {
  const factory LoadAdminData() = _$LoadAdminDataImpl;
}

/// @nodoc
abstract class _$$ChangeAdminTabImplCopyWith<$Res> {
  factory _$$ChangeAdminTabImplCopyWith(
    _$ChangeAdminTabImpl value,
    $Res Function(_$ChangeAdminTabImpl) then,
  ) = __$$ChangeAdminTabImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int newIndex});
}

/// @nodoc
class __$$ChangeAdminTabImplCopyWithImpl<$Res>
    extends _$AdminPanelEventCopyWithImpl<$Res, _$ChangeAdminTabImpl>
    implements _$$ChangeAdminTabImplCopyWith<$Res> {
  __$$ChangeAdminTabImplCopyWithImpl(
    _$ChangeAdminTabImpl _value,
    $Res Function(_$ChangeAdminTabImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newIndex = null}) {
    return _then(
      _$ChangeAdminTabImpl(
        null == newIndex
            ? _value.newIndex
            : newIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ChangeAdminTabImpl implements ChangeAdminTab {
  const _$ChangeAdminTabImpl(this.newIndex);

  @override
  final int newIndex;

  @override
  String toString() {
    return 'AdminPanelEvent.changeTab(newIndex: $newIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeAdminTabImpl &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newIndex);

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeAdminTabImplCopyWith<_$ChangeAdminTabImpl> get copyWith =>
      __$$ChangeAdminTabImplCopyWithImpl<_$ChangeAdminTabImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(int newIndex) changeTab,
    required TResult Function(Request request, bool isApproved) processRequest,
  }) {
    return changeTab(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(int newIndex)? changeTab,
    TResult? Function(Request request, bool isApproved)? processRequest,
  }) {
    return changeTab?.call(newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(int newIndex)? changeTab,
    TResult Function(Request request, bool isApproved)? processRequest,
    required TResult orElse(),
  }) {
    if (changeTab != null) {
      return changeTab(newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAdminData value) loadData,
    required TResult Function(ChangeAdminTab value) changeTab,
    required TResult Function(ProcessRequest value) processRequest,
  }) {
    return changeTab(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAdminData value)? loadData,
    TResult? Function(ChangeAdminTab value)? changeTab,
    TResult? Function(ProcessRequest value)? processRequest,
  }) {
    return changeTab?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAdminData value)? loadData,
    TResult Function(ChangeAdminTab value)? changeTab,
    TResult Function(ProcessRequest value)? processRequest,
    required TResult orElse(),
  }) {
    if (changeTab != null) {
      return changeTab(this);
    }
    return orElse();
  }
}

abstract class ChangeAdminTab implements AdminPanelEvent {
  const factory ChangeAdminTab(final int newIndex) = _$ChangeAdminTabImpl;

  int get newIndex;

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeAdminTabImplCopyWith<_$ChangeAdminTabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessRequestImplCopyWith<$Res> {
  factory _$$ProcessRequestImplCopyWith(
    _$ProcessRequestImpl value,
    $Res Function(_$ProcessRequestImpl) then,
  ) = __$$ProcessRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Request request, bool isApproved});

  $RequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$ProcessRequestImplCopyWithImpl<$Res>
    extends _$AdminPanelEventCopyWithImpl<$Res, _$ProcessRequestImpl>
    implements _$$ProcessRequestImplCopyWith<$Res> {
  __$$ProcessRequestImplCopyWithImpl(
    _$ProcessRequestImpl _value,
    $Res Function(_$ProcessRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? request = null, Object? isApproved = null}) {
    return _then(
      _$ProcessRequestImpl(
        null == request
            ? _value.request
            : request // ignore: cast_nullable_to_non_nullable
                  as Request,
        null == isApproved
            ? _value.isApproved
            : isApproved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestCopyWith<$Res> get request {
    return $RequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc

class _$ProcessRequestImpl implements ProcessRequest {
  const _$ProcessRequestImpl(this.request, this.isApproved);

  @override
  final Request request;
  @override
  final bool isApproved;

  @override
  String toString() {
    return 'AdminPanelEvent.processRequest(request: $request, isApproved: $isApproved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessRequestImpl &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, isApproved);

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessRequestImplCopyWith<_$ProcessRequestImpl> get copyWith =>
      __$$ProcessRequestImplCopyWithImpl<_$ProcessRequestImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadData,
    required TResult Function(int newIndex) changeTab,
    required TResult Function(Request request, bool isApproved) processRequest,
  }) {
    return processRequest(request, isApproved);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadData,
    TResult? Function(int newIndex)? changeTab,
    TResult? Function(Request request, bool isApproved)? processRequest,
  }) {
    return processRequest?.call(request, isApproved);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadData,
    TResult Function(int newIndex)? changeTab,
    TResult Function(Request request, bool isApproved)? processRequest,
    required TResult orElse(),
  }) {
    if (processRequest != null) {
      return processRequest(request, isApproved);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAdminData value) loadData,
    required TResult Function(ChangeAdminTab value) changeTab,
    required TResult Function(ProcessRequest value) processRequest,
  }) {
    return processRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAdminData value)? loadData,
    TResult? Function(ChangeAdminTab value)? changeTab,
    TResult? Function(ProcessRequest value)? processRequest,
  }) {
    return processRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAdminData value)? loadData,
    TResult Function(ChangeAdminTab value)? changeTab,
    TResult Function(ProcessRequest value)? processRequest,
    required TResult orElse(),
  }) {
    if (processRequest != null) {
      return processRequest(this);
    }
    return orElse();
  }
}

abstract class ProcessRequest implements AdminPanelEvent {
  const factory ProcessRequest(final Request request, final bool isApproved) =
      _$ProcessRequestImpl;

  Request get request;
  bool get isApproved;

  /// Create a copy of AdminPanelEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessRequestImplCopyWith<_$ProcessRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AdminPanelState {
  int get activeTabIndex => throw _privateConstructorUsedError;
  List<Room> get rooms => throw _privateConstructorUsedError;
  List<Bill> get pendingBills => throw _privateConstructorUsedError;
  List<Request> get requests => throw _privateConstructorUsedError;
  List<Complaint> get complaints => throw _privateConstructorUsedError;
  List<Announcement> get announcements => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AdminPanelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPanelStateCopyWith<AdminPanelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPanelStateCopyWith<$Res> {
  factory $AdminPanelStateCopyWith(
    AdminPanelState value,
    $Res Function(AdminPanelState) then,
  ) = _$AdminPanelStateCopyWithImpl<$Res, AdminPanelState>;
  @useResult
  $Res call({
    int activeTabIndex,
    List<Room> rooms,
    List<Bill> pendingBills,
    List<Request> requests,
    List<Complaint> complaints,
    List<Announcement> announcements,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class _$AdminPanelStateCopyWithImpl<$Res, $Val extends AdminPanelState>
    implements $AdminPanelStateCopyWith<$Res> {
  _$AdminPanelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPanelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTabIndex = null,
    Object? rooms = null,
    Object? pendingBills = null,
    Object? requests = null,
    Object? complaints = null,
    Object? announcements = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            activeTabIndex: null == activeTabIndex
                ? _value.activeTabIndex
                : activeTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            rooms: null == rooms
                ? _value.rooms
                : rooms // ignore: cast_nullable_to_non_nullable
                      as List<Room>,
            pendingBills: null == pendingBills
                ? _value.pendingBills
                : pendingBills // ignore: cast_nullable_to_non_nullable
                      as List<Bill>,
            requests: null == requests
                ? _value.requests
                : requests // ignore: cast_nullable_to_non_nullable
                      as List<Request>,
            complaints: null == complaints
                ? _value.complaints
                : complaints // ignore: cast_nullable_to_non_nullable
                      as List<Complaint>,
            announcements: null == announcements
                ? _value.announcements
                : announcements // ignore: cast_nullable_to_non_nullable
                      as List<Announcement>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminPanelStateImplCopyWith<$Res>
    implements $AdminPanelStateCopyWith<$Res> {
  factory _$$AdminPanelStateImplCopyWith(
    _$AdminPanelStateImpl value,
    $Res Function(_$AdminPanelStateImpl) then,
  ) = __$$AdminPanelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int activeTabIndex,
    List<Room> rooms,
    List<Bill> pendingBills,
    List<Request> requests,
    List<Complaint> complaints,
    List<Announcement> announcements,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class __$$AdminPanelStateImplCopyWithImpl<$Res>
    extends _$AdminPanelStateCopyWithImpl<$Res, _$AdminPanelStateImpl>
    implements _$$AdminPanelStateImplCopyWith<$Res> {
  __$$AdminPanelStateImplCopyWithImpl(
    _$AdminPanelStateImpl _value,
    $Res Function(_$AdminPanelStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPanelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTabIndex = null,
    Object? rooms = null,
    Object? pendingBills = null,
    Object? requests = null,
    Object? complaints = null,
    Object? announcements = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AdminPanelStateImpl(
        activeTabIndex: null == activeTabIndex
            ? _value.activeTabIndex
            : activeTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        rooms: null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<Room>,
        pendingBills: null == pendingBills
            ? _value._pendingBills
            : pendingBills // ignore: cast_nullable_to_non_nullable
                  as List<Bill>,
        requests: null == requests
            ? _value._requests
            : requests // ignore: cast_nullable_to_non_nullable
                  as List<Request>,
        complaints: null == complaints
            ? _value._complaints
            : complaints // ignore: cast_nullable_to_non_nullable
                  as List<Complaint>,
        announcements: null == announcements
            ? _value._announcements
            : announcements // ignore: cast_nullable_to_non_nullable
                  as List<Announcement>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AdminPanelStateImpl implements _AdminPanelState {
  const _$AdminPanelStateImpl({
    required this.activeTabIndex,
    required final List<Room> rooms,
    required final List<Bill> pendingBills,
    required final List<Request> requests,
    required final List<Complaint> complaints,
    required final List<Announcement> announcements,
    required this.isLoading,
    this.error,
  }) : _rooms = rooms,
       _pendingBills = pendingBills,
       _requests = requests,
       _complaints = complaints,
       _announcements = announcements;

  @override
  final int activeTabIndex;
  final List<Room> _rooms;
  @override
  List<Room> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  final List<Bill> _pendingBills;
  @override
  List<Bill> get pendingBills {
    if (_pendingBills is EqualUnmodifiableListView) return _pendingBills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingBills);
  }

  final List<Request> _requests;
  @override
  List<Request> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  final List<Complaint> _complaints;
  @override
  List<Complaint> get complaints {
    if (_complaints is EqualUnmodifiableListView) return _complaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_complaints);
  }

  final List<Announcement> _announcements;
  @override
  List<Announcement> get announcements {
    if (_announcements is EqualUnmodifiableListView) return _announcements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_announcements);
  }

  @override
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AdminPanelState(activeTabIndex: $activeTabIndex, rooms: $rooms, pendingBills: $pendingBills, requests: $requests, complaints: $complaints, announcements: $announcements, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPanelStateImpl &&
            (identical(other.activeTabIndex, activeTabIndex) ||
                other.activeTabIndex == activeTabIndex) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms) &&
            const DeepCollectionEquality().equals(
              other._pendingBills,
              _pendingBills,
            ) &&
            const DeepCollectionEquality().equals(other._requests, _requests) &&
            const DeepCollectionEquality().equals(
              other._complaints,
              _complaints,
            ) &&
            const DeepCollectionEquality().equals(
              other._announcements,
              _announcements,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    activeTabIndex,
    const DeepCollectionEquality().hash(_rooms),
    const DeepCollectionEquality().hash(_pendingBills),
    const DeepCollectionEquality().hash(_requests),
    const DeepCollectionEquality().hash(_complaints),
    const DeepCollectionEquality().hash(_announcements),
    isLoading,
    error,
  );

  /// Create a copy of AdminPanelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPanelStateImplCopyWith<_$AdminPanelStateImpl> get copyWith =>
      __$$AdminPanelStateImplCopyWithImpl<_$AdminPanelStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AdminPanelState implements AdminPanelState {
  const factory _AdminPanelState({
    required final int activeTabIndex,
    required final List<Room> rooms,
    required final List<Bill> pendingBills,
    required final List<Request> requests,
    required final List<Complaint> complaints,
    required final List<Announcement> announcements,
    required final bool isLoading,
    final String? error,
  }) = _$AdminPanelStateImpl;

  @override
  int get activeTabIndex;
  @override
  List<Room> get rooms;
  @override
  List<Bill> get pendingBills;
  @override
  List<Request> get requests;
  @override
  List<Complaint> get complaints;
  @override
  List<Announcement> get announcements;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of AdminPanelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPanelStateImplCopyWith<_$AdminPanelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
