// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transfer {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Transfer);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Transfer()';
  }
}

/// @nodoc
class $TransferCopyWith<$Res> {
  $TransferCopyWith(Transfer _, $Res Function(Transfer) __);
}

/// Adds pattern-matching-related methods to [Transfer].
extension TransferPatterns on Transfer {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlindTransferInitiated value)? blindTransferInitiated,
    TResult Function(BlindTransferTransferSubmitted value)?
        blindTransferTransferSubmitted,
    TResult Function(AttendedTransferTransferSubmitted value)?
        attendedTransferTransferSubmitted,
    TResult Function(Transfering value)? transfering,
    TResult Function(AttendedTransferConfirmationRequested value)?
        attendedTransferConfirmationRequested,
    TResult Function(InviteToAttendedTransfer value)? inviteToAttendedTransfer,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated() when blindTransferInitiated != null:
        return blindTransferInitiated(_that);
      case BlindTransferTransferSubmitted()
          when blindTransferTransferSubmitted != null:
        return blindTransferTransferSubmitted(_that);
      case AttendedTransferTransferSubmitted()
          when attendedTransferTransferSubmitted != null:
        return attendedTransferTransferSubmitted(_that);
      case Transfering() when transfering != null:
        return transfering(_that);
      case AttendedTransferConfirmationRequested()
          when attendedTransferConfirmationRequested != null:
        return attendedTransferConfirmationRequested(_that);
      case InviteToAttendedTransfer() when inviteToAttendedTransfer != null:
        return inviteToAttendedTransfer(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(BlindTransferTransferSubmitted value)
        blindTransferTransferSubmitted,
    required TResult Function(AttendedTransferTransferSubmitted value)
        attendedTransferTransferSubmitted,
    required TResult Function(Transfering value) transfering,
    required TResult Function(AttendedTransferConfirmationRequested value)
        attendedTransferConfirmationRequested,
    required TResult Function(InviteToAttendedTransfer value)
        inviteToAttendedTransfer,
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated():
        return blindTransferInitiated(_that);
      case BlindTransferTransferSubmitted():
        return blindTransferTransferSubmitted(_that);
      case AttendedTransferTransferSubmitted():
        return attendedTransferTransferSubmitted(_that);
      case Transfering():
        return transfering(_that);
      case AttendedTransferConfirmationRequested():
        return attendedTransferConfirmationRequested(_that);
      case InviteToAttendedTransfer():
        return inviteToAttendedTransfer(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlindTransferInitiated value)? blindTransferInitiated,
    TResult? Function(BlindTransferTransferSubmitted value)?
        blindTransferTransferSubmitted,
    TResult? Function(AttendedTransferTransferSubmitted value)?
        attendedTransferTransferSubmitted,
    TResult? Function(Transfering value)? transfering,
    TResult? Function(AttendedTransferConfirmationRequested value)?
        attendedTransferConfirmationRequested,
    TResult? Function(InviteToAttendedTransfer value)? inviteToAttendedTransfer,
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated() when blindTransferInitiated != null:
        return blindTransferInitiated(_that);
      case BlindTransferTransferSubmitted()
          when blindTransferTransferSubmitted != null:
        return blindTransferTransferSubmitted(_that);
      case AttendedTransferTransferSubmitted()
          when attendedTransferTransferSubmitted != null:
        return attendedTransferTransferSubmitted(_that);
      case Transfering() when transfering != null:
        return transfering(_that);
      case AttendedTransferConfirmationRequested()
          when attendedTransferConfirmationRequested != null:
        return attendedTransferConfirmationRequested(_that);
      case InviteToAttendedTransfer() when inviteToAttendedTransfer != null:
        return inviteToAttendedTransfer(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? blindTransferInitiated,
    TResult Function(String toNumber)? blindTransferTransferSubmitted,
    TResult Function(String replaceCallId)? attendedTransferTransferSubmitted,
    TResult Function(bool fromAttendedTransfer, bool fromBlindTransfer)?
        transfering,
    TResult Function(String referId, String referTo, String referredBy)?
        attendedTransferConfirmationRequested,
    TResult Function(String replaceCallId, String referredBy)?
        inviteToAttendedTransfer,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated() when blindTransferInitiated != null:
        return blindTransferInitiated();
      case BlindTransferTransferSubmitted()
          when blindTransferTransferSubmitted != null:
        return blindTransferTransferSubmitted(_that.toNumber);
      case AttendedTransferTransferSubmitted()
          when attendedTransferTransferSubmitted != null:
        return attendedTransferTransferSubmitted(_that.replaceCallId);
      case Transfering() when transfering != null:
        return transfering(_that.fromAttendedTransfer, _that.fromBlindTransfer);
      case AttendedTransferConfirmationRequested()
          when attendedTransferConfirmationRequested != null:
        return attendedTransferConfirmationRequested(
            _that.referId, _that.referTo, _that.referredBy);
      case InviteToAttendedTransfer() when inviteToAttendedTransfer != null:
        return inviteToAttendedTransfer(_that.replaceCallId, _that.referredBy);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() blindTransferInitiated,
    required TResult Function(String toNumber) blindTransferTransferSubmitted,
    required TResult Function(String replaceCallId)
        attendedTransferTransferSubmitted,
    required TResult Function(bool fromAttendedTransfer, bool fromBlindTransfer)
        transfering,
    required TResult Function(String referId, String referTo, String referredBy)
        attendedTransferConfirmationRequested,
    required TResult Function(String replaceCallId, String referredBy)
        inviteToAttendedTransfer,
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated():
        return blindTransferInitiated();
      case BlindTransferTransferSubmitted():
        return blindTransferTransferSubmitted(_that.toNumber);
      case AttendedTransferTransferSubmitted():
        return attendedTransferTransferSubmitted(_that.replaceCallId);
      case Transfering():
        return transfering(_that.fromAttendedTransfer, _that.fromBlindTransfer);
      case AttendedTransferConfirmationRequested():
        return attendedTransferConfirmationRequested(
            _that.referId, _that.referTo, _that.referredBy);
      case InviteToAttendedTransfer():
        return inviteToAttendedTransfer(_that.replaceCallId, _that.referredBy);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? blindTransferInitiated,
    TResult? Function(String toNumber)? blindTransferTransferSubmitted,
    TResult? Function(String replaceCallId)? attendedTransferTransferSubmitted,
    TResult? Function(bool fromAttendedTransfer, bool fromBlindTransfer)?
        transfering,
    TResult? Function(String referId, String referTo, String referredBy)?
        attendedTransferConfirmationRequested,
    TResult? Function(String replaceCallId, String referredBy)?
        inviteToAttendedTransfer,
  }) {
    final _that = this;
    switch (_that) {
      case BlindTransferInitiated() when blindTransferInitiated != null:
        return blindTransferInitiated();
      case BlindTransferTransferSubmitted()
          when blindTransferTransferSubmitted != null:
        return blindTransferTransferSubmitted(_that.toNumber);
      case AttendedTransferTransferSubmitted()
          when attendedTransferTransferSubmitted != null:
        return attendedTransferTransferSubmitted(_that.replaceCallId);
      case Transfering() when transfering != null:
        return transfering(_that.fromAttendedTransfer, _that.fromBlindTransfer);
      case AttendedTransferConfirmationRequested()
          when attendedTransferConfirmationRequested != null:
        return attendedTransferConfirmationRequested(
            _that.referId, _that.referTo, _that.referredBy);
      case InviteToAttendedTransfer() when inviteToAttendedTransfer != null:
        return inviteToAttendedTransfer(_that.replaceCallId, _that.referredBy);
      case _:
        return null;
    }
  }
}

/// @nodoc

class BlindTransferInitiated extends Transfer {
  const BlindTransferInitiated() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BlindTransferInitiated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Transfer.blindTransferInitiated()';
  }
}

/// @nodoc

class BlindTransferTransferSubmitted extends Transfer {
  const BlindTransferTransferSubmitted({required this.toNumber}) : super._();

  final String toNumber;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BlindTransferTransferSubmittedCopyWith<BlindTransferTransferSubmitted>
      get copyWith => _$BlindTransferTransferSubmittedCopyWithImpl<
          BlindTransferTransferSubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlindTransferTransferSubmitted &&
            (identical(other.toNumber, toNumber) ||
                other.toNumber == toNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toNumber);

  @override
  String toString() {
    return 'Transfer.blindTransferTransferSubmitted(toNumber: $toNumber)';
  }
}

/// @nodoc
abstract mixin class $BlindTransferTransferSubmittedCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory $BlindTransferTransferSubmittedCopyWith(
          BlindTransferTransferSubmitted value,
          $Res Function(BlindTransferTransferSubmitted) _then) =
      _$BlindTransferTransferSubmittedCopyWithImpl;
  @useResult
  $Res call({String toNumber});
}

/// @nodoc
class _$BlindTransferTransferSubmittedCopyWithImpl<$Res>
    implements $BlindTransferTransferSubmittedCopyWith<$Res> {
  _$BlindTransferTransferSubmittedCopyWithImpl(this._self, this._then);

  final BlindTransferTransferSubmitted _self;
  final $Res Function(BlindTransferTransferSubmitted) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? toNumber = null,
  }) {
    return _then(BlindTransferTransferSubmitted(
      toNumber: null == toNumber
          ? _self.toNumber
          : toNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AttendedTransferTransferSubmitted extends Transfer {
  const AttendedTransferTransferSubmitted({required this.replaceCallId})
      : super._();

  final String replaceCallId;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttendedTransferTransferSubmittedCopyWith<AttendedTransferTransferSubmitted>
      get copyWith => _$AttendedTransferTransferSubmittedCopyWithImpl<
          AttendedTransferTransferSubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttendedTransferTransferSubmitted &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replaceCallId);

  @override
  String toString() {
    return 'Transfer.attendedTransferTransferSubmitted(replaceCallId: $replaceCallId)';
  }
}

/// @nodoc
abstract mixin class $AttendedTransferTransferSubmittedCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory $AttendedTransferTransferSubmittedCopyWith(
          AttendedTransferTransferSubmitted value,
          $Res Function(AttendedTransferTransferSubmitted) _then) =
      _$AttendedTransferTransferSubmittedCopyWithImpl;
  @useResult
  $Res call({String replaceCallId});
}

/// @nodoc
class _$AttendedTransferTransferSubmittedCopyWithImpl<$Res>
    implements $AttendedTransferTransferSubmittedCopyWith<$Res> {
  _$AttendedTransferTransferSubmittedCopyWithImpl(this._self, this._then);

  final AttendedTransferTransferSubmitted _self;
  final $Res Function(AttendedTransferTransferSubmitted) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replaceCallId = null,
  }) {
    return _then(AttendedTransferTransferSubmitted(
      replaceCallId: null == replaceCallId
          ? _self.replaceCallId
          : replaceCallId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Transfering extends Transfer {
  const Transfering(
      {required this.fromAttendedTransfer, required this.fromBlindTransfer})
      : super._();

  final bool fromAttendedTransfer;
  final bool fromBlindTransfer;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransferingCopyWith<Transfering> get copyWith =>
      _$TransferingCopyWithImpl<Transfering>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Transfering &&
            (identical(other.fromAttendedTransfer, fromAttendedTransfer) ||
                other.fromAttendedTransfer == fromAttendedTransfer) &&
            (identical(other.fromBlindTransfer, fromBlindTransfer) ||
                other.fromBlindTransfer == fromBlindTransfer));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fromAttendedTransfer, fromBlindTransfer);

  @override
  String toString() {
    return 'Transfer.transfering(fromAttendedTransfer: $fromAttendedTransfer, fromBlindTransfer: $fromBlindTransfer)';
  }
}

/// @nodoc
abstract mixin class $TransferingCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory $TransferingCopyWith(
          Transfering value, $Res Function(Transfering) _then) =
      _$TransferingCopyWithImpl;
  @useResult
  $Res call({bool fromAttendedTransfer, bool fromBlindTransfer});
}

/// @nodoc
class _$TransferingCopyWithImpl<$Res> implements $TransferingCopyWith<$Res> {
  _$TransferingCopyWithImpl(this._self, this._then);

  final Transfering _self;
  final $Res Function(Transfering) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fromAttendedTransfer = null,
    Object? fromBlindTransfer = null,
  }) {
    return _then(Transfering(
      fromAttendedTransfer: null == fromAttendedTransfer
          ? _self.fromAttendedTransfer
          : fromAttendedTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
      fromBlindTransfer: null == fromBlindTransfer
          ? _self.fromBlindTransfer
          : fromBlindTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class AttendedTransferConfirmationRequested extends Transfer {
  const AttendedTransferConfirmationRequested(
      {required this.referId, required this.referTo, required this.referredBy})
      : super._();

  final String referId;
  final String referTo;
  final String referredBy;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttendedTransferConfirmationRequestedCopyWith<
          AttendedTransferConfirmationRequested>
      get copyWith => _$AttendedTransferConfirmationRequestedCopyWithImpl<
          AttendedTransferConfirmationRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttendedTransferConfirmationRequested &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.referTo, referTo) || other.referTo == referTo) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referId, referTo, referredBy);

  @override
  String toString() {
    return 'Transfer.attendedTransferConfirmationRequested(referId: $referId, referTo: $referTo, referredBy: $referredBy)';
  }
}

/// @nodoc
abstract mixin class $AttendedTransferConfirmationRequestedCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory $AttendedTransferConfirmationRequestedCopyWith(
          AttendedTransferConfirmationRequested value,
          $Res Function(AttendedTransferConfirmationRequested) _then) =
      _$AttendedTransferConfirmationRequestedCopyWithImpl;
  @useResult
  $Res call({String referId, String referTo, String referredBy});
}

/// @nodoc
class _$AttendedTransferConfirmationRequestedCopyWithImpl<$Res>
    implements $AttendedTransferConfirmationRequestedCopyWith<$Res> {
  _$AttendedTransferConfirmationRequestedCopyWithImpl(this._self, this._then);

  final AttendedTransferConfirmationRequested _self;
  final $Res Function(AttendedTransferConfirmationRequested) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? referId = null,
    Object? referTo = null,
    Object? referredBy = null,
  }) {
    return _then(AttendedTransferConfirmationRequested(
      referId: null == referId
          ? _self.referId
          : referId // ignore: cast_nullable_to_non_nullable
              as String,
      referTo: null == referTo
          ? _self.referTo
          : referTo // ignore: cast_nullable_to_non_nullable
              as String,
      referredBy: null == referredBy
          ? _self.referredBy
          : referredBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class InviteToAttendedTransfer extends Transfer {
  const InviteToAttendedTransfer(
      {required this.replaceCallId, required this.referredBy})
      : super._();

  final String replaceCallId;
  final String referredBy;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InviteToAttendedTransferCopyWith<InviteToAttendedTransfer> get copyWith =>
      _$InviteToAttendedTransferCopyWithImpl<InviteToAttendedTransfer>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InviteToAttendedTransfer &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replaceCallId, referredBy);

  @override
  String toString() {
    return 'Transfer.inviteToAttendedTransfer(replaceCallId: $replaceCallId, referredBy: $referredBy)';
  }
}

/// @nodoc
abstract mixin class $InviteToAttendedTransferCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory $InviteToAttendedTransferCopyWith(InviteToAttendedTransfer value,
          $Res Function(InviteToAttendedTransfer) _then) =
      _$InviteToAttendedTransferCopyWithImpl;
  @useResult
  $Res call({String replaceCallId, String referredBy});
}

/// @nodoc
class _$InviteToAttendedTransferCopyWithImpl<$Res>
    implements $InviteToAttendedTransferCopyWith<$Res> {
  _$InviteToAttendedTransferCopyWithImpl(this._self, this._then);

  final InviteToAttendedTransfer _self;
  final $Res Function(InviteToAttendedTransfer) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replaceCallId = null,
    Object? referredBy = null,
  }) {
    return _then(InviteToAttendedTransfer(
      replaceCallId: null == replaceCallId
          ? _self.replaceCallId
          : replaceCallId // ignore: cast_nullable_to_non_nullable
              as String,
      referredBy: null == referredBy
          ? _self.referredBy
          : referredBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
