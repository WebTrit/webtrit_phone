// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cdr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CdrRecord _$CdrRecordFromJson(Map<String, dynamic> json) {
  return _CdrRecord.fromJson(json);
}

/// @nodoc
mixin _$CdrRecord {
  String get callId => throw _privateConstructorUsedError;
  String get callee => throw _privateConstructorUsedError;
  String get caller => throw _privateConstructorUsedError;
  DateTime get connectTime => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get disconnectReason => throw _privateConstructorUsedError;
  DateTime get disconnectTime => throw _privateConstructorUsedError;
  int get duration =>
      throw _privateConstructorUsedError; // TODO: fix once backend side, sometimes it's int, sometimes it's string
  dynamic get recordingId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this CdrRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CdrRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CdrRecordCopyWith<CdrRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CdrRecordCopyWith<$Res> {
  factory $CdrRecordCopyWith(CdrRecord value, $Res Function(CdrRecord) then) =
      _$CdrRecordCopyWithImpl<$Res, CdrRecord>;
  @useResult
  $Res call({
    String callId,
    String callee,
    String caller,
    DateTime connectTime,
    String direction,
    String disconnectReason,
    DateTime disconnectTime,
    int duration,
    dynamic recordingId,
    String status,
  });
}

/// @nodoc
class _$CdrRecordCopyWithImpl<$Res, $Val extends CdrRecord>
    implements $CdrRecordCopyWith<$Res> {
  _$CdrRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CdrRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? callee = null,
    Object? caller = null,
    Object? connectTime = null,
    Object? direction = null,
    Object? disconnectReason = null,
    Object? disconnectTime = null,
    Object? duration = null,
    Object? recordingId = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            callId: null == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String,
            callee: null == callee
                ? _value.callee
                : callee // ignore: cast_nullable_to_non_nullable
                      as String,
            caller: null == caller
                ? _value.caller
                : caller // ignore: cast_nullable_to_non_nullable
                      as String,
            connectTime: null == connectTime
                ? _value.connectTime
                : connectTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            direction: null == direction
                ? _value.direction
                : direction // ignore: cast_nullable_to_non_nullable
                      as String,
            disconnectReason: null == disconnectReason
                ? _value.disconnectReason
                : disconnectReason // ignore: cast_nullable_to_non_nullable
                      as String,
            disconnectTime: null == disconnectTime
                ? _value.disconnectTime
                : disconnectTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            recordingId: freezed == recordingId
                ? _value.recordingId
                : recordingId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CdrRecordImplCopyWith<$Res>
    implements $CdrRecordCopyWith<$Res> {
  factory _$$CdrRecordImplCopyWith(
    _$CdrRecordImpl value,
    $Res Function(_$CdrRecordImpl) then,
  ) = __$$CdrRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String callId,
    String callee,
    String caller,
    DateTime connectTime,
    String direction,
    String disconnectReason,
    DateTime disconnectTime,
    int duration,
    dynamic recordingId,
    String status,
  });
}

/// @nodoc
class __$$CdrRecordImplCopyWithImpl<$Res>
    extends _$CdrRecordCopyWithImpl<$Res, _$CdrRecordImpl>
    implements _$$CdrRecordImplCopyWith<$Res> {
  __$$CdrRecordImplCopyWithImpl(
    _$CdrRecordImpl _value,
    $Res Function(_$CdrRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CdrRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? callee = null,
    Object? caller = null,
    Object? connectTime = null,
    Object? direction = null,
    Object? disconnectReason = null,
    Object? disconnectTime = null,
    Object? duration = null,
    Object? recordingId = freezed,
    Object? status = null,
  }) {
    return _then(
      _$CdrRecordImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        callee: null == callee
            ? _value.callee
            : callee // ignore: cast_nullable_to_non_nullable
                  as String,
        caller: null == caller
            ? _value.caller
            : caller // ignore: cast_nullable_to_non_nullable
                  as String,
        connectTime: null == connectTime
            ? _value.connectTime
            : connectTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        direction: null == direction
            ? _value.direction
            : direction // ignore: cast_nullable_to_non_nullable
                  as String,
        disconnectReason: null == disconnectReason
            ? _value.disconnectReason
            : disconnectReason // ignore: cast_nullable_to_non_nullable
                  as String,
        disconnectTime: null == disconnectTime
            ? _value.disconnectTime
            : disconnectTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        recordingId: freezed == recordingId
            ? _value.recordingId
            : recordingId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CdrRecordImpl implements _CdrRecord {
  const _$CdrRecordImpl({
    required this.callId,
    required this.callee,
    required this.caller,
    required this.connectTime,
    required this.direction,
    required this.disconnectReason,
    required this.disconnectTime,
    required this.duration,
    this.recordingId,
    required this.status,
  });

  factory _$CdrRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$CdrRecordImplFromJson(json);

  @override
  final String callId;
  @override
  final String callee;
  @override
  final String caller;
  @override
  final DateTime connectTime;
  @override
  final String direction;
  @override
  final String disconnectReason;
  @override
  final DateTime disconnectTime;
  @override
  final int duration;
  // TODO: fix once backend side, sometimes it's int, sometimes it's string
  @override
  final dynamic recordingId;
  @override
  final String status;

  @override
  String toString() {
    return 'CdrRecord(callId: $callId, callee: $callee, caller: $caller, connectTime: $connectTime, direction: $direction, disconnectReason: $disconnectReason, disconnectTime: $disconnectTime, duration: $duration, recordingId: $recordingId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CdrRecordImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.connectTime, connectTime) ||
                other.connectTime == connectTime) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.disconnectReason, disconnectReason) ||
                other.disconnectReason == disconnectReason) &&
            (identical(other.disconnectTime, disconnectTime) ||
                other.disconnectTime == disconnectTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(
              other.recordingId,
              recordingId,
            ) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    callId,
    callee,
    caller,
    connectTime,
    direction,
    disconnectReason,
    disconnectTime,
    duration,
    const DeepCollectionEquality().hash(recordingId),
    status,
  );

  /// Create a copy of CdrRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CdrRecordImplCopyWith<_$CdrRecordImpl> get copyWith =>
      __$$CdrRecordImplCopyWithImpl<_$CdrRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CdrRecordImplToJson(this);
  }
}

abstract class _CdrRecord implements CdrRecord {
  const factory _CdrRecord({
    required final String callId,
    required final String callee,
    required final String caller,
    required final DateTime connectTime,
    required final String direction,
    required final String disconnectReason,
    required final DateTime disconnectTime,
    required final int duration,
    final dynamic recordingId,
    required final String status,
  }) = _$CdrRecordImpl;

  factory _CdrRecord.fromJson(Map<String, dynamic> json) =
      _$CdrRecordImpl.fromJson;

  @override
  String get callId;
  @override
  String get callee;
  @override
  String get caller;
  @override
  DateTime get connectTime;
  @override
  String get direction;
  @override
  String get disconnectReason;
  @override
  DateTime get disconnectTime;
  @override
  int get duration; // TODO: fix once backend side, sometimes it's int, sometimes it's string
  @override
  dynamic get recordingId;
  @override
  String get status;

  /// Create a copy of CdrRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CdrRecordImplCopyWith<_$CdrRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CdrHistoryResponse _$CdrHistoryResponseFromJson(Map<String, dynamic> json) {
  return _CdrHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$CdrHistoryResponse {
  List<CdrRecord> get items => throw _privateConstructorUsedError;

  /// Serializes this CdrHistoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CdrHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CdrHistoryResponseCopyWith<CdrHistoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CdrHistoryResponseCopyWith<$Res> {
  factory $CdrHistoryResponseCopyWith(
    CdrHistoryResponse value,
    $Res Function(CdrHistoryResponse) then,
  ) = _$CdrHistoryResponseCopyWithImpl<$Res, CdrHistoryResponse>;
  @useResult
  $Res call({List<CdrRecord> items});
}

/// @nodoc
class _$CdrHistoryResponseCopyWithImpl<$Res, $Val extends CdrHistoryResponse>
    implements $CdrHistoryResponseCopyWith<$Res> {
  _$CdrHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CdrHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CdrRecord>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CdrHistoryResponseImplCopyWith<$Res>
    implements $CdrHistoryResponseCopyWith<$Res> {
  factory _$$CdrHistoryResponseImplCopyWith(
    _$CdrHistoryResponseImpl value,
    $Res Function(_$CdrHistoryResponseImpl) then,
  ) = __$$CdrHistoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CdrRecord> items});
}

/// @nodoc
class __$$CdrHistoryResponseImplCopyWithImpl<$Res>
    extends _$CdrHistoryResponseCopyWithImpl<$Res, _$CdrHistoryResponseImpl>
    implements _$$CdrHistoryResponseImplCopyWith<$Res> {
  __$$CdrHistoryResponseImplCopyWithImpl(
    _$CdrHistoryResponseImpl _value,
    $Res Function(_$CdrHistoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CdrHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null}) {
    return _then(
      _$CdrHistoryResponseImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CdrRecord>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CdrHistoryResponseImpl implements _CdrHistoryResponse {
  const _$CdrHistoryResponseImpl({required final List<CdrRecord> items})
    : _items = items;

  factory _$CdrHistoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CdrHistoryResponseImplFromJson(json);

  final List<CdrRecord> _items;
  @override
  List<CdrRecord> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'CdrHistoryResponse(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CdrHistoryResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of CdrHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CdrHistoryResponseImplCopyWith<_$CdrHistoryResponseImpl> get copyWith =>
      __$$CdrHistoryResponseImplCopyWithImpl<_$CdrHistoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CdrHistoryResponseImplToJson(this);
  }
}

abstract class _CdrHistoryResponse implements CdrHistoryResponse {
  const factory _CdrHistoryResponse({required final List<CdrRecord> items}) =
      _$CdrHistoryResponseImpl;

  factory _CdrHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$CdrHistoryResponseImpl.fromJson;

  @override
  List<CdrRecord> get items;

  /// Create a copy of CdrHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CdrHistoryResponseImplCopyWith<_$CdrHistoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
