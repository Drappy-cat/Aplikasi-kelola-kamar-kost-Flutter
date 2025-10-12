// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complaint_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ComplaintEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String? searchQuery, String? statusFilter)
    filterChanged,
    required TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )
    add,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult? Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadComplaints value) load,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(AddComplaint value) add,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadComplaints value)? load,
    TResult? Function(FilterChanged value)? filterChanged,
    TResult? Function(AddComplaint value)? add,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadComplaints value)? load,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(AddComplaint value)? add,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintEventCopyWith<$Res> {
  factory $ComplaintEventCopyWith(
    ComplaintEvent value,
    $Res Function(ComplaintEvent) then,
  ) = _$ComplaintEventCopyWithImpl<$Res, ComplaintEvent>;
}

/// @nodoc
class _$ComplaintEventCopyWithImpl<$Res, $Val extends ComplaintEvent>
    implements $ComplaintEventCopyWith<$Res> {
  _$ComplaintEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadComplaintsImplCopyWith<$Res> {
  factory _$$LoadComplaintsImplCopyWith(
    _$LoadComplaintsImpl value,
    $Res Function(_$LoadComplaintsImpl) then,
  ) = __$$LoadComplaintsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadComplaintsImplCopyWithImpl<$Res>
    extends _$ComplaintEventCopyWithImpl<$Res, _$LoadComplaintsImpl>
    implements _$$LoadComplaintsImplCopyWith<$Res> {
  __$$LoadComplaintsImplCopyWithImpl(
    _$LoadComplaintsImpl _value,
    $Res Function(_$LoadComplaintsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadComplaintsImpl implements LoadComplaints {
  const _$LoadComplaintsImpl();

  @override
  String toString() {
    return 'ComplaintEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadComplaintsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String? searchQuery, String? statusFilter)
    filterChanged,
    required TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )
    add,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult? Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadComplaints value) load,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(AddComplaint value) add,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadComplaints value)? load,
    TResult? Function(FilterChanged value)? filterChanged,
    TResult? Function(AddComplaint value)? add,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadComplaints value)? load,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(AddComplaint value)? add,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadComplaints implements ComplaintEvent {
  const factory LoadComplaints() = _$LoadComplaintsImpl;
}

/// @nodoc
abstract class _$$FilterChangedImplCopyWith<$Res> {
  factory _$$FilterChangedImplCopyWith(
    _$FilterChangedImpl value,
    $Res Function(_$FilterChangedImpl) then,
  ) = __$$FilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? searchQuery, String? statusFilter});
}

/// @nodoc
class __$$FilterChangedImplCopyWithImpl<$Res>
    extends _$ComplaintEventCopyWithImpl<$Res, _$FilterChangedImpl>
    implements _$$FilterChangedImplCopyWith<$Res> {
  __$$FilterChangedImplCopyWithImpl(
    _$FilterChangedImpl _value,
    $Res Function(_$FilterChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchQuery = freezed, Object? statusFilter = freezed}) {
    return _then(
      _$FilterChangedImpl(
        searchQuery: freezed == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusFilter: freezed == statusFilter
            ? _value.statusFilter
            : statusFilter // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FilterChangedImpl implements FilterChanged {
  const _$FilterChangedImpl({this.searchQuery, this.statusFilter});

  @override
  final String? searchQuery;
  @override
  final String? statusFilter;

  @override
  String toString() {
    return 'ComplaintEvent.filterChanged(searchQuery: $searchQuery, statusFilter: $statusFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterChangedImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.statusFilter, statusFilter) ||
                other.statusFilter == statusFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchQuery, statusFilter);

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      __$$FilterChangedImplCopyWithImpl<_$FilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String? searchQuery, String? statusFilter)
    filterChanged,
    required TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )
    add,
  }) {
    return filterChanged(searchQuery, statusFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult? Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
  }) {
    return filterChanged?.call(searchQuery, statusFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(searchQuery, statusFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadComplaints value) load,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(AddComplaint value) add,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadComplaints value)? load,
    TResult? Function(FilterChanged value)? filterChanged,
    TResult? Function(AddComplaint value)? add,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadComplaints value)? load,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(AddComplaint value)? add,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }
}

abstract class FilterChanged implements ComplaintEvent {
  const factory FilterChanged({
    final String? searchQuery,
    final String? statusFilter,
  }) = _$FilterChangedImpl;

  String? get searchQuery;
  String? get statusFilter;

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterChangedImplCopyWith<_$FilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddComplaintImplCopyWith<$Res> {
  factory _$$AddComplaintImplCopyWith(
    _$AddComplaintImpl value,
    $Res Function(_$AddComplaintImpl) then,
  ) = __$$AddComplaintImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String title,
    String description,
    String category,
    List<String> imageUrls,
  });
}

/// @nodoc
class __$$AddComplaintImplCopyWithImpl<$Res>
    extends _$ComplaintEventCopyWithImpl<$Res, _$AddComplaintImpl>
    implements _$$AddComplaintImplCopyWith<$Res> {
  __$$AddComplaintImplCopyWithImpl(
    _$AddComplaintImpl _value,
    $Res Function(_$AddComplaintImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? imageUrls = null,
  }) {
    return _then(
      _$AddComplaintImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$AddComplaintImpl implements AddComplaint {
  const _$AddComplaintImpl({
    required this.title,
    required this.description,
    required this.category,
    required final List<String> imageUrls,
  }) : _imageUrls = imageUrls;

  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'ComplaintEvent.add(title: $title, description: $description, category: $category, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddComplaintImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    category,
    const DeepCollectionEquality().hash(_imageUrls),
  );

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddComplaintImplCopyWith<_$AddComplaintImpl> get copyWith =>
      __$$AddComplaintImplCopyWithImpl<_$AddComplaintImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(String? searchQuery, String? statusFilter)
    filterChanged,
    required TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )
    add,
  }) {
    return add(title, description, category, imageUrls);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult? Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
  }) {
    return add?.call(title, description, category, imageUrls);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(String? searchQuery, String? statusFilter)? filterChanged,
    TResult Function(
      String title,
      String description,
      String category,
      List<String> imageUrls,
    )?
    add,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(title, description, category, imageUrls);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadComplaints value) load,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(AddComplaint value) add,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadComplaints value)? load,
    TResult? Function(FilterChanged value)? filterChanged,
    TResult? Function(AddComplaint value)? add,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadComplaints value)? load,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(AddComplaint value)? add,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class AddComplaint implements ComplaintEvent {
  const factory AddComplaint({
    required final String title,
    required final String description,
    required final String category,
    required final List<String> imageUrls,
  }) = _$AddComplaintImpl;

  String get title;
  String get description;
  String get category;
  List<String> get imageUrls;

  /// Create a copy of ComplaintEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddComplaintImplCopyWith<_$AddComplaintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ComplaintState {
  // Status loading keseluruhan halaman
  bool get isLoading =>
      throw _privateConstructorUsedError; // Daftar keluhan asli dari service
  List<Complaint> get allComplaints =>
      throw _privateConstructorUsedError; // Daftar keluhan yang akan ditampilkan di UI setelah difilter
  List<Complaint> get filteredComplaints =>
      throw _privateConstructorUsedError; // Pesan error jika terjadi kesalahan
  String? get error =>
      throw _privateConstructorUsedError; // Status untuk aksi penambahan keluhan
  bool get isSubmitting => throw _privateConstructorUsedError;
  String? get submissionError => throw _privateConstructorUsedError;
  String? get submissionSuccess => throw _privateConstructorUsedError;

  /// Create a copy of ComplaintState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComplaintStateCopyWith<ComplaintState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintStateCopyWith<$Res> {
  factory $ComplaintStateCopyWith(
    ComplaintState value,
    $Res Function(ComplaintState) then,
  ) = _$ComplaintStateCopyWithImpl<$Res, ComplaintState>;
  @useResult
  $Res call({
    bool isLoading,
    List<Complaint> allComplaints,
    List<Complaint> filteredComplaints,
    String? error,
    bool isSubmitting,
    String? submissionError,
    String? submissionSuccess,
  });
}

/// @nodoc
class _$ComplaintStateCopyWithImpl<$Res, $Val extends ComplaintState>
    implements $ComplaintStateCopyWith<$Res> {
  _$ComplaintStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComplaintState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? allComplaints = null,
    Object? filteredComplaints = null,
    Object? error = freezed,
    Object? isSubmitting = null,
    Object? submissionError = freezed,
    Object? submissionSuccess = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            allComplaints: null == allComplaints
                ? _value.allComplaints
                : allComplaints // ignore: cast_nullable_to_non_nullable
                      as List<Complaint>,
            filteredComplaints: null == filteredComplaints
                ? _value.filteredComplaints
                : filteredComplaints // ignore: cast_nullable_to_non_nullable
                      as List<Complaint>,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            submissionError: freezed == submissionError
                ? _value.submissionError
                : submissionError // ignore: cast_nullable_to_non_nullable
                      as String?,
            submissionSuccess: freezed == submissionSuccess
                ? _value.submissionSuccess
                : submissionSuccess // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComplaintStateImplCopyWith<$Res>
    implements $ComplaintStateCopyWith<$Res> {
  factory _$$ComplaintStateImplCopyWith(
    _$ComplaintStateImpl value,
    $Res Function(_$ComplaintStateImpl) then,
  ) = __$$ComplaintStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    List<Complaint> allComplaints,
    List<Complaint> filteredComplaints,
    String? error,
    bool isSubmitting,
    String? submissionError,
    String? submissionSuccess,
  });
}

/// @nodoc
class __$$ComplaintStateImplCopyWithImpl<$Res>
    extends _$ComplaintStateCopyWithImpl<$Res, _$ComplaintStateImpl>
    implements _$$ComplaintStateImplCopyWith<$Res> {
  __$$ComplaintStateImplCopyWithImpl(
    _$ComplaintStateImpl _value,
    $Res Function(_$ComplaintStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? allComplaints = null,
    Object? filteredComplaints = null,
    Object? error = freezed,
    Object? isSubmitting = null,
    Object? submissionError = freezed,
    Object? submissionSuccess = freezed,
  }) {
    return _then(
      _$ComplaintStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        allComplaints: null == allComplaints
            ? _value._allComplaints
            : allComplaints // ignore: cast_nullable_to_non_nullable
                  as List<Complaint>,
        filteredComplaints: null == filteredComplaints
            ? _value._filteredComplaints
            : filteredComplaints // ignore: cast_nullable_to_non_nullable
                  as List<Complaint>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        submissionError: freezed == submissionError
            ? _value.submissionError
            : submissionError // ignore: cast_nullable_to_non_nullable
                  as String?,
        submissionSuccess: freezed == submissionSuccess
            ? _value.submissionSuccess
            : submissionSuccess // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ComplaintStateImpl implements _ComplaintState {
  const _$ComplaintStateImpl({
    this.isLoading = false,
    final List<Complaint> allComplaints = const [],
    final List<Complaint> filteredComplaints = const [],
    this.error,
    this.isSubmitting = false,
    this.submissionError,
    this.submissionSuccess,
  }) : _allComplaints = allComplaints,
       _filteredComplaints = filteredComplaints;

  // Status loading keseluruhan halaman
  @override
  @JsonKey()
  final bool isLoading;
  // Daftar keluhan asli dari service
  final List<Complaint> _allComplaints;
  // Daftar keluhan asli dari service
  @override
  @JsonKey()
  List<Complaint> get allComplaints {
    if (_allComplaints is EqualUnmodifiableListView) return _allComplaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allComplaints);
  }

  // Daftar keluhan yang akan ditampilkan di UI setelah difilter
  final List<Complaint> _filteredComplaints;
  // Daftar keluhan yang akan ditampilkan di UI setelah difilter
  @override
  @JsonKey()
  List<Complaint> get filteredComplaints {
    if (_filteredComplaints is EqualUnmodifiableListView)
      return _filteredComplaints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredComplaints);
  }

  // Pesan error jika terjadi kesalahan
  @override
  final String? error;
  // Status untuk aksi penambahan keluhan
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? submissionError;
  @override
  final String? submissionSuccess;

  @override
  String toString() {
    return 'ComplaintState(isLoading: $isLoading, allComplaints: $allComplaints, filteredComplaints: $filteredComplaints, error: $error, isSubmitting: $isSubmitting, submissionError: $submissionError, submissionSuccess: $submissionSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._allComplaints,
              _allComplaints,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredComplaints,
              _filteredComplaints,
            ) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.submissionError, submissionError) ||
                other.submissionError == submissionError) &&
            (identical(other.submissionSuccess, submissionSuccess) ||
                other.submissionSuccess == submissionSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_allComplaints),
    const DeepCollectionEquality().hash(_filteredComplaints),
    error,
    isSubmitting,
    submissionError,
    submissionSuccess,
  );

  /// Create a copy of ComplaintState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintStateImplCopyWith<_$ComplaintStateImpl> get copyWith =>
      __$$ComplaintStateImplCopyWithImpl<_$ComplaintStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ComplaintState implements ComplaintState {
  const factory _ComplaintState({
    final bool isLoading,
    final List<Complaint> allComplaints,
    final List<Complaint> filteredComplaints,
    final String? error,
    final bool isSubmitting,
    final String? submissionError,
    final String? submissionSuccess,
  }) = _$ComplaintStateImpl;

  // Status loading keseluruhan halaman
  @override
  bool get isLoading; // Daftar keluhan asli dari service
  @override
  List<Complaint> get allComplaints; // Daftar keluhan yang akan ditampilkan di UI setelah difilter
  @override
  List<Complaint> get filteredComplaints; // Pesan error jika terjadi kesalahan
  @override
  String? get error; // Status untuk aksi penambahan keluhan
  @override
  bool get isSubmitting;
  @override
  String? get submissionError;
  @override
  String? get submissionSuccess;

  /// Create a copy of ComplaintState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComplaintStateImplCopyWith<_$ComplaintStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
