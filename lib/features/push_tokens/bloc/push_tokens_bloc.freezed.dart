// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_tokens_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PushTokensEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
    required TResult Function() fcmTokenDeletionRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
    TResult? Function()? fcmTokenDeletionRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    TResult Function()? fcmTokenDeletionRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
    required TResult Function(PushTokensFcmTokenDeletionRequested value)
        fcmTokenDeletionRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
    TResult? Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    TResult Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushTokensEventCopyWith<$Res> {
  factory $PushTokensEventCopyWith(
          PushTokensEvent value, $Res Function(PushTokensEvent) then) =
      _$PushTokensEventCopyWithImpl<$Res, PushTokensEvent>;
}

/// @nodoc
class _$PushTokensEventCopyWithImpl<$Res, $Val extends PushTokensEvent>
    implements $PushTokensEventCopyWith<$Res> {
  _$PushTokensEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PushTokensStartedImplCopyWith<$Res> {
  factory _$$PushTokensStartedImplCopyWith(_$PushTokensStartedImpl value,
          $Res Function(_$PushTokensStartedImpl) then) =
      __$$PushTokensStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PushTokensStartedImplCopyWithImpl<$Res>
    extends _$PushTokensEventCopyWithImpl<$Res, _$PushTokensStartedImpl>
    implements _$$PushTokensStartedImplCopyWith<$Res> {
  __$$PushTokensStartedImplCopyWithImpl(_$PushTokensStartedImpl _value,
      $Res Function(_$PushTokensStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PushTokensStartedImpl implements PushTokensStarted {
  const _$PushTokensStartedImpl();

  @override
  String toString() {
    return 'PushTokensEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PushTokensStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
    required TResult Function() fcmTokenDeletionRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
    TResult? Function()? fcmTokenDeletionRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    TResult Function()? fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
    required TResult Function(PushTokensFcmTokenDeletionRequested value)
        fcmTokenDeletionRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
    TResult? Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    TResult Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class PushTokensStarted implements PushTokensEvent {
  const factory PushTokensStarted() = _$PushTokensStartedImpl;
}

/// @nodoc
abstract class _$$PushTokensInsertedOrUpdatedImplCopyWith<$Res> {
  factory _$$PushTokensInsertedOrUpdatedImplCopyWith(
          _$PushTokensInsertedOrUpdatedImpl value,
          $Res Function(_$PushTokensInsertedOrUpdatedImpl) then) =
      __$$PushTokensInsertedOrUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppPushTokenType type, String value});
}

/// @nodoc
class __$$PushTokensInsertedOrUpdatedImplCopyWithImpl<$Res>
    extends _$PushTokensEventCopyWithImpl<$Res,
        _$PushTokensInsertedOrUpdatedImpl>
    implements _$$PushTokensInsertedOrUpdatedImplCopyWith<$Res> {
  __$$PushTokensInsertedOrUpdatedImplCopyWithImpl(
      _$PushTokensInsertedOrUpdatedImpl _value,
      $Res Function(_$PushTokensInsertedOrUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(_$PushTokensInsertedOrUpdatedImpl(
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppPushTokenType,
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PushTokensInsertedOrUpdatedImpl implements PushTokensInsertedOrUpdated {
  const _$PushTokensInsertedOrUpdatedImpl(this.type, this.value);

  @override
  final AppPushTokenType type;
  @override
  final String value;

  @override
  String toString() {
    return 'PushTokensEvent.insertedOrUpdated(type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushTokensInsertedOrUpdatedImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, value);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushTokensInsertedOrUpdatedImplCopyWith<_$PushTokensInsertedOrUpdatedImpl>
      get copyWith => __$$PushTokensInsertedOrUpdatedImplCopyWithImpl<
          _$PushTokensInsertedOrUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
    required TResult Function() fcmTokenDeletionRequested,
  }) {
    return insertedOrUpdated(type, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
    TResult? Function()? fcmTokenDeletionRequested,
  }) {
    return insertedOrUpdated?.call(type, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    TResult Function()? fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (insertedOrUpdated != null) {
      return insertedOrUpdated(type, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
    required TResult Function(PushTokensFcmTokenDeletionRequested value)
        fcmTokenDeletionRequested,
  }) {
    return insertedOrUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
    TResult? Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
  }) {
    return insertedOrUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    TResult Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (insertedOrUpdated != null) {
      return insertedOrUpdated(this);
    }
    return orElse();
  }
}

abstract class PushTokensInsertedOrUpdated implements PushTokensEvent {
  const factory PushTokensInsertedOrUpdated(
          final AppPushTokenType type, final String value) =
      _$PushTokensInsertedOrUpdatedImpl;

  AppPushTokenType get type;
  String get value;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushTokensInsertedOrUpdatedImplCopyWith<_$PushTokensInsertedOrUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PushTokensErrorImplCopyWith<$Res> {
  factory _$$PushTokensErrorImplCopyWith(_$PushTokensErrorImpl value,
          $Res Function(_$PushTokensErrorImpl) then) =
      __$$PushTokensErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$PushTokensErrorImplCopyWithImpl<$Res>
    extends _$PushTokensEventCopyWithImpl<$Res, _$PushTokensErrorImpl>
    implements _$$PushTokensErrorImplCopyWith<$Res> {
  __$$PushTokensErrorImplCopyWithImpl(
      _$PushTokensErrorImpl _value, $Res Function(_$PushTokensErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$PushTokensErrorImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PushTokensErrorImpl implements _PushTokensError {
  const _$PushTokensErrorImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'PushTokensEvent.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushTokensErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushTokensErrorImplCopyWith<_$PushTokensErrorImpl> get copyWith =>
      __$$PushTokensErrorImplCopyWithImpl<_$PushTokensErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
    required TResult Function() fcmTokenDeletionRequested,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
    TResult? Function()? fcmTokenDeletionRequested,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    TResult Function()? fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
    required TResult Function(PushTokensFcmTokenDeletionRequested value)
        fcmTokenDeletionRequested,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
    TResult? Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    TResult Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _PushTokensError implements PushTokensEvent {
  const factory _PushTokensError(final String errorMessage) =
      _$PushTokensErrorImpl;

  String get errorMessage;

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushTokensErrorImplCopyWith<_$PushTokensErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PushTokensFcmTokenDeletionRequestedImplCopyWith<$Res> {
  factory _$$PushTokensFcmTokenDeletionRequestedImplCopyWith(
          _$PushTokensFcmTokenDeletionRequestedImpl value,
          $Res Function(_$PushTokensFcmTokenDeletionRequestedImpl) then) =
      __$$PushTokensFcmTokenDeletionRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PushTokensFcmTokenDeletionRequestedImplCopyWithImpl<$Res>
    extends _$PushTokensEventCopyWithImpl<$Res,
        _$PushTokensFcmTokenDeletionRequestedImpl>
    implements _$$PushTokensFcmTokenDeletionRequestedImplCopyWith<$Res> {
  __$$PushTokensFcmTokenDeletionRequestedImplCopyWithImpl(
      _$PushTokensFcmTokenDeletionRequestedImpl _value,
      $Res Function(_$PushTokensFcmTokenDeletionRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushTokensEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PushTokensFcmTokenDeletionRequestedImpl
    implements PushTokensFcmTokenDeletionRequested {
  const _$PushTokensFcmTokenDeletionRequestedImpl();

  @override
  String toString() {
    return 'PushTokensEvent.fcmTokenDeletionRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushTokensFcmTokenDeletionRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(AppPushTokenType type, String value)
        insertedOrUpdated,
    required TResult Function(String errorMessage) error,
    required TResult Function() fcmTokenDeletionRequested,
  }) {
    return fcmTokenDeletionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult? Function(String errorMessage)? error,
    TResult? Function()? fcmTokenDeletionRequested,
  }) {
    return fcmTokenDeletionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(AppPushTokenType type, String value)? insertedOrUpdated,
    TResult Function(String errorMessage)? error,
    TResult Function()? fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (fcmTokenDeletionRequested != null) {
      return fcmTokenDeletionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PushTokensStarted value) started,
    required TResult Function(PushTokensInsertedOrUpdated value)
        insertedOrUpdated,
    required TResult Function(_PushTokensError value) error,
    required TResult Function(PushTokensFcmTokenDeletionRequested value)
        fcmTokenDeletionRequested,
  }) {
    return fcmTokenDeletionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PushTokensStarted value)? started,
    TResult? Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult? Function(_PushTokensError value)? error,
    TResult? Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
  }) {
    return fcmTokenDeletionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PushTokensStarted value)? started,
    TResult Function(PushTokensInsertedOrUpdated value)? insertedOrUpdated,
    TResult Function(_PushTokensError value)? error,
    TResult Function(PushTokensFcmTokenDeletionRequested value)?
        fcmTokenDeletionRequested,
    required TResult orElse(),
  }) {
    if (fcmTokenDeletionRequested != null) {
      return fcmTokenDeletionRequested(this);
    }
    return orElse();
  }
}

abstract class PushTokensFcmTokenDeletionRequested implements PushTokensEvent {
  const factory PushTokensFcmTokenDeletionRequested() =
      _$PushTokensFcmTokenDeletionRequestedImpl;
}

/// @nodoc
mixin _$PushTokensState {
  String? get pushToken => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushTokensStateCopyWith<PushTokensState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushTokensStateCopyWith<$Res> {
  factory $PushTokensStateCopyWith(
          PushTokensState value, $Res Function(PushTokensState) then) =
      _$PushTokensStateCopyWithImpl<$Res, PushTokensState>;
  @useResult
  $Res call({String? pushToken, String? errorMessage});
}

/// @nodoc
class _$PushTokensStateCopyWithImpl<$Res, $Val extends PushTokensState>
    implements $PushTokensStateCopyWith<$Res> {
  _$PushTokensStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushTokensStateImplCopyWith<$Res>
    implements $PushTokensStateCopyWith<$Res> {
  factory _$$PushTokensStateImplCopyWith(_$PushTokensStateImpl value,
          $Res Function(_$PushTokensStateImpl) then) =
      __$$PushTokensStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? pushToken, String? errorMessage});
}

/// @nodoc
class __$$PushTokensStateImplCopyWithImpl<$Res>
    extends _$PushTokensStateCopyWithImpl<$Res, _$PushTokensStateImpl>
    implements _$$PushTokensStateImplCopyWith<$Res> {
  __$$PushTokensStateImplCopyWithImpl(
      _$PushTokensStateImpl _value, $Res Function(_$PushTokensStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushToken = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$PushTokensStateImpl(
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PushTokensStateImpl implements _PushTokensState {
  const _$PushTokensStateImpl({this.pushToken, this.errorMessage});

  @override
  final String? pushToken;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PushTokensState(pushToken: $pushToken, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushTokensStateImpl &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pushToken, errorMessage);

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushTokensStateImplCopyWith<_$PushTokensStateImpl> get copyWith =>
      __$$PushTokensStateImplCopyWithImpl<_$PushTokensStateImpl>(
          this, _$identity);
}

abstract class _PushTokensState implements PushTokensState {
  const factory _PushTokensState(
      {final String? pushToken,
      final String? errorMessage}) = _$PushTokensStateImpl;

  @override
  String? get pushToken;
  @override
  String? get errorMessage;

  /// Create a copy of PushTokensState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushTokensStateImplCopyWith<_$PushTokensStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
