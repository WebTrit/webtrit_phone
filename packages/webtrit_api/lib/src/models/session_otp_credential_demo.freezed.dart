// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_otp_credential_demo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionOtpCredentialDemo _$SessionOtpCredentialDemoFromJson(
    Map<String, dynamic> json) {
  return _SessionOtpCredentialDemo.fromJson(json);
}

/// @nodoc
mixin _$SessionOtpCredentialDemo {
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionOtpCredentialDemoCopyWith<SessionOtpCredentialDemo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOtpCredentialDemoCopyWith<$Res> {
  factory $SessionOtpCredentialDemoCopyWith(SessionOtpCredentialDemo value,
          $Res Function(SessionOtpCredentialDemo) then) =
      _$SessionOtpCredentialDemoCopyWithImpl<$Res, SessionOtpCredentialDemo>;
  @useResult
  $Res call({AppType type, String identifier, String email});
}

/// @nodoc
class _$SessionOtpCredentialDemoCopyWithImpl<$Res,
        $Val extends SessionOtpCredentialDemo>
    implements $SessionOtpCredentialDemoCopyWith<$Res> {
  _$SessionOtpCredentialDemoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionOtpCredentialDemoCopyWith<$Res>
    implements $SessionOtpCredentialDemoCopyWith<$Res> {
  factory _$$_SessionOtpCredentialDemoCopyWith(
          _$_SessionOtpCredentialDemo value,
          $Res Function(_$_SessionOtpCredentialDemo) then) =
      __$$_SessionOtpCredentialDemoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppType type, String identifier, String email});
}

/// @nodoc
class __$$_SessionOtpCredentialDemoCopyWithImpl<$Res>
    extends _$SessionOtpCredentialDemoCopyWithImpl<$Res,
        _$_SessionOtpCredentialDemo>
    implements _$$_SessionOtpCredentialDemoCopyWith<$Res> {
  __$$_SessionOtpCredentialDemoCopyWithImpl(_$_SessionOtpCredentialDemo _value,
      $Res Function(_$_SessionOtpCredentialDemo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
  }) {
    return _then(_$_SessionOtpCredentialDemo(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionOtpCredentialDemo implements _SessionOtpCredentialDemo {
  const _$_SessionOtpCredentialDemo(
      {required this.type, required this.identifier, required this.email});

  factory _$_SessionOtpCredentialDemo.fromJson(Map<String, dynamic> json) =>
      _$$_SessionOtpCredentialDemoFromJson(json);

  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String email;

  @override
  String toString() {
    return 'SessionOtpCredentialDemo(type: $type, identifier: $identifier, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionOtpCredentialDemo &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, identifier, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionOtpCredentialDemoCopyWith<_$_SessionOtpCredentialDemo>
      get copyWith => __$$_SessionOtpCredentialDemoCopyWithImpl<
          _$_SessionOtpCredentialDemo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionOtpCredentialDemoToJson(
      this,
    );
  }
}

abstract class _SessionOtpCredentialDemo implements SessionOtpCredentialDemo {
  const factory _SessionOtpCredentialDemo(
      {required final AppType type,
      required final String identifier,
      required final String email}) = _$_SessionOtpCredentialDemo;

  factory _SessionOtpCredentialDemo.fromJson(Map<String, dynamic> json) =
      _$_SessionOtpCredentialDemo.fromJson;

  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_SessionOtpCredentialDemoCopyWith<_$_SessionOtpCredentialDemo>
      get copyWith => throw _privateConstructorUsedError;
}
