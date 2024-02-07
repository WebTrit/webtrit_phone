// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mode_select_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModeSelectState {
  String get url => throw _privateConstructorUsedError;
  String get defaultTenantId => throw _privateConstructorUsedError;
  ModeSelectStatus? get status => throw _privateConstructorUsedError;
  bool get demo => throw _privateConstructorUsedError;
  List<SupportedLoginType> get supportedLogin =>
      throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModeSelectStateCopyWith<ModeSelectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModeSelectStateCopyWith<$Res> {
  factory $ModeSelectStateCopyWith(
          ModeSelectState value, $Res Function(ModeSelectState) then) =
      _$ModeSelectStateCopyWithImpl<$Res, ModeSelectState>;
  @useResult
  $Res call(
      {String url,
      String defaultTenantId,
      ModeSelectStatus? status,
      bool demo,
      List<SupportedLoginType> supportedLogin,
      Exception? error});
}

/// @nodoc
class _$ModeSelectStateCopyWithImpl<$Res, $Val extends ModeSelectState>
    implements $ModeSelectStateCopyWith<$Res> {
  _$ModeSelectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? defaultTenantId = null,
    Object? status = freezed,
    Object? demo = null,
    Object? supportedLogin = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTenantId: null == defaultTenantId
          ? _value.defaultTenantId
          : defaultTenantId // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ModeSelectStatus?,
      demo: null == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool,
      supportedLogin: null == supportedLogin
          ? _value.supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModeSelectStateStateImplCopyWith<$Res>
    implements $ModeSelectStateCopyWith<$Res> {
  factory _$$ModeSelectStateStateImplCopyWith(_$ModeSelectStateStateImpl value,
          $Res Function(_$ModeSelectStateStateImpl) then) =
      __$$ModeSelectStateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String defaultTenantId,
      ModeSelectStatus? status,
      bool demo,
      List<SupportedLoginType> supportedLogin,
      Exception? error});
}

/// @nodoc
class __$$ModeSelectStateStateImplCopyWithImpl<$Res>
    extends _$ModeSelectStateCopyWithImpl<$Res, _$ModeSelectStateStateImpl>
    implements _$$ModeSelectStateStateImplCopyWith<$Res> {
  __$$ModeSelectStateStateImplCopyWithImpl(_$ModeSelectStateStateImpl _value,
      $Res Function(_$ModeSelectStateStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? defaultTenantId = null,
    Object? status = freezed,
    Object? demo = null,
    Object? supportedLogin = null,
    Object? error = freezed,
  }) {
    return _then(_$ModeSelectStateStateImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTenantId: null == defaultTenantId
          ? _value.defaultTenantId
          : defaultTenantId // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ModeSelectStatus?,
      demo: null == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool,
      supportedLogin: null == supportedLogin
          ? _value._supportedLogin
          : supportedLogin // ignore: cast_nullable_to_non_nullable
              as List<SupportedLoginType>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$ModeSelectStateStateImpl extends _ModeSelectStateState {
  const _$ModeSelectStateStateImpl(
      {required this.url,
      required this.defaultTenantId,
      this.status,
      required this.demo,
      final List<SupportedLoginType> supportedLogin = const [],
      this.error})
      : _supportedLogin = supportedLogin,
        super._();

  @override
  final String url;
  @override
  final String defaultTenantId;
  @override
  final ModeSelectStatus? status;
  @override
  final bool demo;
  final List<SupportedLoginType> _supportedLogin;
  @override
  @JsonKey()
  List<SupportedLoginType> get supportedLogin {
    if (_supportedLogin is EqualUnmodifiableListView) return _supportedLogin;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLogin);
  }

  @override
  final Exception? error;

  @override
  String toString() {
    return 'ModeSelectState(url: $url, defaultTenantId: $defaultTenantId, status: $status, demo: $demo, supportedLogin: $supportedLogin, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModeSelectStateStateImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.defaultTenantId, defaultTenantId) ||
                other.defaultTenantId == defaultTenantId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.demo, demo) || other.demo == demo) &&
            const DeepCollectionEquality()
                .equals(other._supportedLogin, _supportedLogin) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, defaultTenantId, status,
      demo, const DeepCollectionEquality().hash(_supportedLogin), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModeSelectStateStateImplCopyWith<_$ModeSelectStateStateImpl>
      get copyWith =>
          __$$ModeSelectStateStateImplCopyWithImpl<_$ModeSelectStateStateImpl>(
              this, _$identity);
}

abstract class _ModeSelectStateState extends ModeSelectState {
  const factory _ModeSelectStateState(
      {required final String url,
      required final String defaultTenantId,
      final ModeSelectStatus? status,
      required final bool demo,
      final List<SupportedLoginType> supportedLogin,
      final Exception? error}) = _$ModeSelectStateStateImpl;
  const _ModeSelectStateState._() : super._();

  @override
  String get url;
  @override
  String get defaultTenantId;
  @override
  ModeSelectStatus? get status;
  @override
  bool get demo;
  @override
  List<SupportedLoginType> get supportedLogin;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$ModeSelectStateStateImplCopyWith<_$ModeSelectStateStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
