// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  Balance? get balance => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  Numbers? get numbers => throw _privateConstructorUsedError;
  UserSipInfo? get sip => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get timeZone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res, UserInfo>;
  @useResult
  $Res call(
      {Balance? balance,
      String? companyName,
      String? email,
      String? firstName,
      String? lastName,
      Numbers? numbers,
      UserSipInfo? sip,
      String? status,
      String? timeZone});

  $BalanceCopyWith<$Res>? get balance;
  $NumbersCopyWith<$Res>? get numbers;
  $UserSipInfoCopyWith<$Res>? get sip;
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = freezed,
    Object? companyName = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? numbers = freezed,
    Object? sip = freezed,
    Object? status = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_value.copyWith(
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Balance?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      numbers: freezed == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers?,
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as UserSipInfo?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BalanceCopyWith<$Res>? get balance {
    if (_value.balance == null) {
      return null;
    }

    return $BalanceCopyWith<$Res>(_value.balance!, (value) {
      return _then(_value.copyWith(balance: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumbersCopyWith<$Res>? get numbers {
    if (_value.numbers == null) {
      return null;
    }

    return $NumbersCopyWith<$Res>(_value.numbers!, (value) {
      return _then(_value.copyWith(numbers: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserSipInfoCopyWith<$Res>? get sip {
    if (_value.sip == null) {
      return null;
    }

    return $UserSipInfoCopyWith<$Res>(_value.sip!, (value) {
      return _then(_value.copyWith(sip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$$_UserInfoCopyWith(
          _$_UserInfo value, $Res Function(_$_UserInfo) then) =
      __$$_UserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Balance? balance,
      String? companyName,
      String? email,
      String? firstName,
      String? lastName,
      Numbers? numbers,
      UserSipInfo? sip,
      String? status,
      String? timeZone});

  @override
  $BalanceCopyWith<$Res>? get balance;
  @override
  $NumbersCopyWith<$Res>? get numbers;
  @override
  $UserSipInfoCopyWith<$Res>? get sip;
}

/// @nodoc
class __$$_UserInfoCopyWithImpl<$Res>
    extends _$UserInfoCopyWithImpl<$Res, _$_UserInfo>
    implements _$$_UserInfoCopyWith<$Res> {
  __$$_UserInfoCopyWithImpl(
      _$_UserInfo _value, $Res Function(_$_UserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = freezed,
    Object? companyName = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? numbers = freezed,
    Object? sip = freezed,
    Object? status = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_$_UserInfo(
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Balance?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      numbers: freezed == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as Numbers?,
      sip: freezed == sip
          ? _value.sip
          : sip // ignore: cast_nullable_to_non_nullable
              as UserSipInfo?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UserInfo implements _UserInfo {
  const _$_UserInfo(
      {this.balance,
      this.companyName,
      this.email,
      this.firstName,
      this.lastName,
      this.numbers,
      this.sip,
      this.status,
      this.timeZone});

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  @override
  final Balance? balance;
  @override
  final String? companyName;
  @override
  final String? email;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final Numbers? numbers;
  @override
  final UserSipInfo? sip;
  @override
  final String? status;
  @override
  final String? timeZone;

  @override
  String toString() {
    return 'UserInfo(balance: $balance, companyName: $companyName, email: $email, firstName: $firstName, lastName: $lastName, numbers: $numbers, sip: $sip, status: $status, timeZone: $timeZone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfo &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.numbers, numbers) || other.numbers == numbers) &&
            (identical(other.sip, sip) || other.sip == sip) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, balance, companyName, email,
      firstName, lastName, numbers, sip, status, timeZone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      __$$_UserInfoCopyWithImpl<_$_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(
      this,
    );
  }
}

abstract class _UserInfo implements UserInfo {
  const factory _UserInfo(
      {final Balance? balance,
      final String? companyName,
      final String? email,
      final String? firstName,
      final String? lastName,
      final Numbers? numbers,
      final UserSipInfo? sip,
      final String? status,
      final String? timeZone}) = _$_UserInfo;

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override
  Balance? get balance;
  @override
  String? get companyName;
  @override
  String? get email;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  Numbers? get numbers;
  @override
  UserSipInfo? get sip;
  @override
  String? get status;
  @override
  String? get timeZone;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSipInfo _$UserSipInfoFromJson(Map<String, dynamic> json) {
  return _UserSipInfo.fromJson(json);
}

/// @nodoc
mixin _$UserSipInfo {
  String? get displayName => throw _privateConstructorUsedError;
  String? get login => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  RegistrationServer? get registrationServer =>
      throw _privateConstructorUsedError;
  SipServer? get sipServer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSipInfoCopyWith<UserSipInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSipInfoCopyWith<$Res> {
  factory $UserSipInfoCopyWith(
          UserSipInfo value, $Res Function(UserSipInfo) then) =
      _$UserSipInfoCopyWithImpl<$Res, UserSipInfo>;
  @useResult
  $Res call(
      {String? displayName,
      String? login,
      String? password,
      RegistrationServer? registrationServer,
      SipServer? sipServer});

  $RegistrationServerCopyWith<$Res>? get registrationServer;
  $SipServerCopyWith<$Res>? get sipServer;
}

/// @nodoc
class _$UserSipInfoCopyWithImpl<$Res, $Val extends UserSipInfo>
    implements $UserSipInfoCopyWith<$Res> {
  _$UserSipInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? login = freezed,
    Object? password = freezed,
    Object? registrationServer = freezed,
    Object? sipServer = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationServer: freezed == registrationServer
          ? _value.registrationServer
          : registrationServer // ignore: cast_nullable_to_non_nullable
              as RegistrationServer?,
      sipServer: freezed == sipServer
          ? _value.sipServer
          : sipServer // ignore: cast_nullable_to_non_nullable
              as SipServer?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RegistrationServerCopyWith<$Res>? get registrationServer {
    if (_value.registrationServer == null) {
      return null;
    }

    return $RegistrationServerCopyWith<$Res>(_value.registrationServer!,
        (value) {
      return _then(_value.copyWith(registrationServer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SipServerCopyWith<$Res>? get sipServer {
    if (_value.sipServer == null) {
      return null;
    }

    return $SipServerCopyWith<$Res>(_value.sipServer!, (value) {
      return _then(_value.copyWith(sipServer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserSipInfoCopyWith<$Res>
    implements $UserSipInfoCopyWith<$Res> {
  factory _$$_UserSipInfoCopyWith(
          _$_UserSipInfo value, $Res Function(_$_UserSipInfo) then) =
      __$$_UserSipInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? displayName,
      String? login,
      String? password,
      RegistrationServer? registrationServer,
      SipServer? sipServer});

  @override
  $RegistrationServerCopyWith<$Res>? get registrationServer;
  @override
  $SipServerCopyWith<$Res>? get sipServer;
}

/// @nodoc
class __$$_UserSipInfoCopyWithImpl<$Res>
    extends _$UserSipInfoCopyWithImpl<$Res, _$_UserSipInfo>
    implements _$$_UserSipInfoCopyWith<$Res> {
  __$$_UserSipInfoCopyWithImpl(
      _$_UserSipInfo _value, $Res Function(_$_UserSipInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? login = freezed,
    Object? password = freezed,
    Object? registrationServer = freezed,
    Object? sipServer = freezed,
  }) {
    return _then(_$_UserSipInfo(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationServer: freezed == registrationServer
          ? _value.registrationServer
          : registrationServer // ignore: cast_nullable_to_non_nullable
              as RegistrationServer?,
      sipServer: freezed == sipServer
          ? _value.sipServer
          : sipServer // ignore: cast_nullable_to_non_nullable
              as SipServer?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UserSipInfo implements _UserSipInfo {
  const _$_UserSipInfo(
      {this.displayName,
      this.login,
      this.password,
      this.registrationServer,
      this.sipServer});

  factory _$_UserSipInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserSipInfoFromJson(json);

  @override
  final String? displayName;
  @override
  final String? login;
  @override
  final String? password;
  @override
  final RegistrationServer? registrationServer;
  @override
  final SipServer? sipServer;

  @override
  String toString() {
    return 'UserSipInfo(displayName: $displayName, login: $login, password: $password, registrationServer: $registrationServer, sipServer: $sipServer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserSipInfo &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.registrationServer, registrationServer) ||
                other.registrationServer == registrationServer) &&
            (identical(other.sipServer, sipServer) ||
                other.sipServer == sipServer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, displayName, login, password, registrationServer, sipServer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserSipInfoCopyWith<_$_UserSipInfo> get copyWith =>
      __$$_UserSipInfoCopyWithImpl<_$_UserSipInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserSipInfoToJson(
      this,
    );
  }
}

abstract class _UserSipInfo implements UserSipInfo {
  const factory _UserSipInfo(
      {final String? displayName,
      final String? login,
      final String? password,
      final RegistrationServer? registrationServer,
      final SipServer? sipServer}) = _$_UserSipInfo;

  factory _UserSipInfo.fromJson(Map<String, dynamic> json) =
      _$_UserSipInfo.fromJson;

  @override
  String? get displayName;
  @override
  String? get login;
  @override
  String? get password;
  @override
  RegistrationServer? get registrationServer;
  @override
  SipServer? get sipServer;
  @override
  @JsonKey(ignore: true)
  _$$_UserSipInfoCopyWith<_$_UserSipInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

SipServer _$SipServerFromJson(Map<String, dynamic> json) {
  return _SipServer.fromJson(json);
}

/// @nodoc
mixin _$SipServer {
  bool? get forceTcp => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SipServerCopyWith<SipServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SipServerCopyWith<$Res> {
  factory $SipServerCopyWith(SipServer value, $Res Function(SipServer) then) =
      _$SipServerCopyWithImpl<$Res, SipServer>;
  @useResult
  $Res call({bool? forceTcp, String? host, int? port});
}

/// @nodoc
class _$SipServerCopyWithImpl<$Res, $Val extends SipServer>
    implements $SipServerCopyWith<$Res> {
  _$SipServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forceTcp = freezed,
    Object? host = freezed,
    Object? port = freezed,
  }) {
    return _then(_value.copyWith(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SipServerCopyWith<$Res> implements $SipServerCopyWith<$Res> {
  factory _$$_SipServerCopyWith(
          _$_SipServer value, $Res Function(_$_SipServer) then) =
      __$$_SipServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? forceTcp, String? host, int? port});
}

/// @nodoc
class __$$_SipServerCopyWithImpl<$Res>
    extends _$SipServerCopyWithImpl<$Res, _$_SipServer>
    implements _$$_SipServerCopyWith<$Res> {
  __$$_SipServerCopyWithImpl(
      _$_SipServer _value, $Res Function(_$_SipServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forceTcp = freezed,
    Object? host = freezed,
    Object? port = freezed,
  }) {
    return _then(_$_SipServer(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SipServer implements _SipServer {
  const _$_SipServer({this.forceTcp, this.host, this.port});

  factory _$_SipServer.fromJson(Map<String, dynamic> json) =>
      _$$_SipServerFromJson(json);

  @override
  final bool? forceTcp;
  @override
  final String? host;
  @override
  final int? port;

  @override
  String toString() {
    return 'SipServer(forceTcp: $forceTcp, host: $host, port: $port)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SipServer &&
            (identical(other.forceTcp, forceTcp) ||
                other.forceTcp == forceTcp) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, forceTcp, host, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SipServerCopyWith<_$_SipServer> get copyWith =>
      __$$_SipServerCopyWithImpl<_$_SipServer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SipServerToJson(
      this,
    );
  }
}

abstract class _SipServer implements SipServer {
  const factory _SipServer(
      {final bool? forceTcp,
      final String? host,
      final int? port}) = _$_SipServer;

  factory _SipServer.fromJson(Map<String, dynamic> json) =
      _$_SipServer.fromJson;

  @override
  bool? get forceTcp;
  @override
  String? get host;
  @override
  int? get port;
  @override
  @JsonKey(ignore: true)
  _$$_SipServerCopyWith<_$_SipServer> get copyWith =>
      throw _privateConstructorUsedError;
}

RegistrationServer _$RegistrationServerFromJson(Map<String, dynamic> json) {
  return _RegistrationServer.fromJson(json);
}

/// @nodoc
mixin _$RegistrationServer {
  bool? get forceTcp => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegistrationServerCopyWith<RegistrationServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationServerCopyWith<$Res> {
  factory $RegistrationServerCopyWith(
          RegistrationServer value, $Res Function(RegistrationServer) then) =
      _$RegistrationServerCopyWithImpl<$Res, RegistrationServer>;
  @useResult
  $Res call({bool? forceTcp, String? host, int? port});
}

/// @nodoc
class _$RegistrationServerCopyWithImpl<$Res, $Val extends RegistrationServer>
    implements $RegistrationServerCopyWith<$Res> {
  _$RegistrationServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forceTcp = freezed,
    Object? host = freezed,
    Object? port = freezed,
  }) {
    return _then(_value.copyWith(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegistrationServerCopyWith<$Res>
    implements $RegistrationServerCopyWith<$Res> {
  factory _$$_RegistrationServerCopyWith(_$_RegistrationServer value,
          $Res Function(_$_RegistrationServer) then) =
      __$$_RegistrationServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? forceTcp, String? host, int? port});
}

/// @nodoc
class __$$_RegistrationServerCopyWithImpl<$Res>
    extends _$RegistrationServerCopyWithImpl<$Res, _$_RegistrationServer>
    implements _$$_RegistrationServerCopyWith<$Res> {
  __$$_RegistrationServerCopyWithImpl(
      _$_RegistrationServer _value, $Res Function(_$_RegistrationServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forceTcp = freezed,
    Object? host = freezed,
    Object? port = freezed,
  }) {
    return _then(_$_RegistrationServer(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_RegistrationServer implements _RegistrationServer {
  const _$_RegistrationServer({this.forceTcp, this.host, this.port});

  factory _$_RegistrationServer.fromJson(Map<String, dynamic> json) =>
      _$$_RegistrationServerFromJson(json);

  @override
  final bool? forceTcp;
  @override
  final String? host;
  @override
  final int? port;

  @override
  String toString() {
    return 'RegistrationServer(forceTcp: $forceTcp, host: $host, port: $port)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistrationServer &&
            (identical(other.forceTcp, forceTcp) ||
                other.forceTcp == forceTcp) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, forceTcp, host, port);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegistrationServerCopyWith<_$_RegistrationServer> get copyWith =>
      __$$_RegistrationServerCopyWithImpl<_$_RegistrationServer>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RegistrationServerToJson(
      this,
    );
  }
}

abstract class _RegistrationServer implements RegistrationServer {
  const factory _RegistrationServer(
      {final bool? forceTcp,
      final String? host,
      final int? port}) = _$_RegistrationServer;

  factory _RegistrationServer.fromJson(Map<String, dynamic> json) =
      _$_RegistrationServer.fromJson;

  @override
  bool? get forceTcp;
  @override
  String? get host;
  @override
  int? get port;
  @override
  @JsonKey(ignore: true)
  _$$_RegistrationServerCopyWith<_$_RegistrationServer> get copyWith =>
      throw _privateConstructorUsedError;
}

Balance _$BalanceFromJson(Map<String, dynamic> json) {
  return _Balance.fromJson(json);
}

/// @nodoc
mixin _$Balance {
  double? get amount => throw _privateConstructorUsedError;
  BalanceType? get balanceType => throw _privateConstructorUsedError;
  int? get creditLimit => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BalanceCopyWith<Balance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceCopyWith<$Res> {
  factory $BalanceCopyWith(Balance value, $Res Function(Balance) then) =
      _$BalanceCopyWithImpl<$Res, Balance>;
  @useResult
  $Res call(
      {double? amount,
      BalanceType? balanceType,
      int? creditLimit,
      String? currency});
}

/// @nodoc
class _$BalanceCopyWithImpl<$Res, $Val extends Balance>
    implements $BalanceCopyWith<$Res> {
  _$BalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? balanceType = freezed,
    Object? creditLimit = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      balanceType: freezed == balanceType
          ? _value.balanceType
          : balanceType // ignore: cast_nullable_to_non_nullable
              as BalanceType?,
      creditLimit: freezed == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BalanceCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$_BalanceCopyWith(
          _$_Balance value, $Res Function(_$_Balance) then) =
      __$$_BalanceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? amount,
      BalanceType? balanceType,
      int? creditLimit,
      String? currency});
}

/// @nodoc
class __$$_BalanceCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$_Balance>
    implements _$$_BalanceCopyWith<$Res> {
  __$$_BalanceCopyWithImpl(_$_Balance _value, $Res Function(_$_Balance) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? balanceType = freezed,
    Object? creditLimit = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_Balance(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      balanceType: freezed == balanceType
          ? _value.balanceType
          : balanceType // ignore: cast_nullable_to_non_nullable
              as BalanceType?,
      creditLimit: freezed == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Balance implements _Balance {
  const _$_Balance(
      {this.amount, this.balanceType, this.creditLimit, this.currency});

  factory _$_Balance.fromJson(Map<String, dynamic> json) =>
      _$$_BalanceFromJson(json);

  @override
  final double? amount;
  @override
  final BalanceType? balanceType;
  @override
  final int? creditLimit;
  @override
  final String? currency;

  @override
  String toString() {
    return 'Balance(amount: $amount, balanceType: $balanceType, creditLimit: $creditLimit, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Balance &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceType, balanceType) ||
                other.balanceType == balanceType) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, balanceType, creditLimit, currency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BalanceCopyWith<_$_Balance> get copyWith =>
      __$$_BalanceCopyWithImpl<_$_Balance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BalanceToJson(
      this,
    );
  }
}

abstract class _Balance implements Balance {
  const factory _Balance(
      {final double? amount,
      final BalanceType? balanceType,
      final int? creditLimit,
      final String? currency}) = _$_Balance;

  factory _Balance.fromJson(Map<String, dynamic> json) = _$_Balance.fromJson;

  @override
  double? get amount;
  @override
  BalanceType? get balanceType;
  @override
  int? get creditLimit;
  @override
  String? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_BalanceCopyWith<_$_Balance> get copyWith =>
      throw _privateConstructorUsedError;
}
