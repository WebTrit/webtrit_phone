// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppLogined {
  String get coreUrl => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppLogined implements _AppLogined {
  const _$_AppLogined({required this.coreUrl, required this.token});

  @override
  final String coreUrl;
  @override
  final String token;

  @override
  String toString() {
    return 'AppLogined(coreUrl: $coreUrl, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppLogined &&
            const DeepCollectionEquality().equals(other.coreUrl, coreUrl) &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(coreUrl),
      const DeepCollectionEquality().hash(token));
}

abstract class _AppLogined implements AppLogined {
  const factory _AppLogined(
      {required final String coreUrl,
      required final String token}) = _$_AppLogined;

  @override
  String get coreUrl => throw _privateConstructorUsedError;
  @override
  String get token => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppLogouted {}

/// @nodoc

class _$_AppLogouted implements _AppLogouted {
  const _$_AppLogouted();

  @override
  String toString() {
    return 'AppLogouted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AppLogouted);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _AppLogouted implements AppLogouted {
  const factory _AppLogouted() = _$_AppLogouted;
}

/// @nodoc
mixin _$AppState {
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get webRegistrationInitialUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call(
      {String? coreUrl, String? token, String? webRegistrationInitialUrl});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? token = freezed,
    Object? webRegistrationInitialUrl = freezed,
  }) {
    return _then(_value.copyWith(
      coreUrl: coreUrl == freezed
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      webRegistrationInitialUrl: webRegistrationInitialUrl == freezed
          ? _value.webRegistrationInitialUrl
          : webRegistrationInitialUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? coreUrl, String? token, String? webRegistrationInitialUrl});
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, (v) => _then(v as _$_AppState));

  @override
  _$_AppState get _value => super._value as _$_AppState;

  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? token = freezed,
    Object? webRegistrationInitialUrl = freezed,
  }) {
    return _then(_$_AppState(
      coreUrl: coreUrl == freezed
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      webRegistrationInitialUrl: webRegistrationInitialUrl == freezed
          ? _value.webRegistrationInitialUrl
          : webRegistrationInitialUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  const _$_AppState({this.coreUrl, this.token, this.webRegistrationInitialUrl});

  @override
  final String? coreUrl;
  @override
  final String? token;
  @override
  final String? webRegistrationInitialUrl;

  @override
  String toString() {
    return 'AppState(coreUrl: $coreUrl, token: $token, webRegistrationInitialUrl: $webRegistrationInitialUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            const DeepCollectionEquality().equals(other.coreUrl, coreUrl) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality().equals(
                other.webRegistrationInitialUrl, webRegistrationInitialUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(coreUrl),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(webRegistrationInitialUrl));

  @JsonKey(ignore: true)
  @override
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final String? coreUrl,
      final String? token,
      final String? webRegistrationInitialUrl}) = _$_AppState;

  @override
  String? get coreUrl => throw _privateConstructorUsedError;
  @override
  String? get token => throw _privateConstructorUsedError;
  @override
  String? get webRegistrationInitialUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
