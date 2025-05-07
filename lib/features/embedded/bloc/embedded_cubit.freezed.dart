// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmbeddedState {
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  bool get payloadReady => throw _privateConstructorUsedError;
  bool get webViewReady => throw _privateConstructorUsedError;
  WebResourceError? get webResourceError => throw _privateConstructorUsedError;
  EmbeddedIntents? get intent => throw _privateConstructorUsedError;

  /// Create a copy of EmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmbeddedStateCopyWith<EmbeddedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedStateCopyWith<$Res> {
  factory $EmbeddedStateCopyWith(
          EmbeddedState value, $Res Function(EmbeddedState) then) =
      _$EmbeddedStateCopyWithImpl<$Res, EmbeddedState>;
  @useResult
  $Res call(
      {Map<String, dynamic> payload,
      bool payloadReady,
      bool webViewReady,
      WebResourceError? webResourceError,
      EmbeddedIntents? intent});
}

/// @nodoc
class _$EmbeddedStateCopyWithImpl<$Res, $Val extends EmbeddedState>
    implements $EmbeddedStateCopyWith<$Res> {
  _$EmbeddedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? payloadReady = null,
    Object? webViewReady = null,
    Object? webResourceError = freezed,
    Object? intent = freezed,
  }) {
    return _then(_value.copyWith(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      payloadReady: null == payloadReady
          ? _value.payloadReady
          : payloadReady // ignore: cast_nullable_to_non_nullable
              as bool,
      webViewReady: null == webViewReady
          ? _value.webViewReady
          : webViewReady // ignore: cast_nullable_to_non_nullable
              as bool,
      webResourceError: freezed == webResourceError
          ? _value.webResourceError
          : webResourceError // ignore: cast_nullable_to_non_nullable
              as WebResourceError?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as EmbeddedIntents?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $EmbeddedStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> payload,
      bool payloadReady,
      bool webViewReady,
      WebResourceError? webResourceError,
      EmbeddedIntents? intent});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$EmbeddedStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? payloadReady = null,
    Object? webViewReady = null,
    Object? webResourceError = freezed,
    Object? intent = freezed,
  }) {
    return _then(_$InitialImpl(
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      payloadReady: null == payloadReady
          ? _value.payloadReady
          : payloadReady // ignore: cast_nullable_to_non_nullable
              as bool,
      webViewReady: null == webViewReady
          ? _value.webViewReady
          : webViewReady // ignore: cast_nullable_to_non_nullable
              as bool,
      webResourceError: freezed == webResourceError
          ? _value.webResourceError
          : webResourceError // ignore: cast_nullable_to_non_nullable
              as WebResourceError?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as EmbeddedIntents?,
    ));
  }
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl(
      {final Map<String, dynamic> payload = const {},
      this.payloadReady = false,
      this.webViewReady = false,
      this.webResourceError,
      this.intent})
      : _payload = payload,
        super._();

  final Map<String, dynamic> _payload;
  @override
  @JsonKey()
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  @JsonKey()
  final bool payloadReady;
  @override
  @JsonKey()
  final bool webViewReady;
  @override
  final WebResourceError? webResourceError;
  @override
  final EmbeddedIntents? intent;

  @override
  String toString() {
    return 'EmbeddedState(payload: $payload, payloadReady: $payloadReady, webViewReady: $webViewReady, webResourceError: $webResourceError, intent: $intent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.payloadReady, payloadReady) ||
                other.payloadReady == payloadReady) &&
            (identical(other.webViewReady, webViewReady) ||
                other.webViewReady == webViewReady) &&
            (identical(other.webResourceError, webResourceError) ||
                other.webResourceError == webResourceError) &&
            (identical(other.intent, intent) || other.intent == intent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_payload),
      payloadReady,
      webViewReady,
      webResourceError,
      intent);

  /// Create a copy of EmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial extends EmbeddedState {
  const factory _Initial(
      {final Map<String, dynamic> payload,
      final bool payloadReady,
      final bool webViewReady,
      final WebResourceError? webResourceError,
      final EmbeddedIntents? intent}) = _$InitialImpl;
  const _Initial._() : super._();

  @override
  Map<String, dynamic> get payload;
  @override
  bool get payloadReady;
  @override
  bool get webViewReady;
  @override
  WebResourceError? get webResourceError;
  @override
  EmbeddedIntents? get intent;

  /// Create a copy of EmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
