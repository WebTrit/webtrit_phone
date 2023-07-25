// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SipStatus _$SipStatusFromJson(Map<String, dynamic> json) {
  return _SipStatus.fromJson(json);
}

/// @nodoc
mixin _$SipStatus {
  String? get displayName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SipStatusCopyWith<SipStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SipStatusCopyWith<$Res> {
  factory $SipStatusCopyWith(SipStatus value, $Res Function(SipStatus) then) =
      _$SipStatusCopyWithImpl<$Res, SipStatus>;
  @useResult
  $Res call({String? displayName, String status});
}

/// @nodoc
class _$SipStatusCopyWithImpl<$Res, $Val extends SipStatus>
    implements $SipStatusCopyWith<$Res> {
  _$SipStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SipStatusCopyWith<$Res> implements $SipStatusCopyWith<$Res> {
  factory _$$_SipStatusCopyWith(
          _$_SipStatus value, $Res Function(_$_SipStatus) then) =
      __$$_SipStatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? displayName, String status});
}

/// @nodoc
class __$$_SipStatusCopyWithImpl<$Res>
    extends _$SipStatusCopyWithImpl<$Res, _$_SipStatus>
    implements _$$_SipStatusCopyWith<$Res> {
  __$$_SipStatusCopyWithImpl(
      _$_SipStatus _value, $Res Function(_$_SipStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? status = null,
  }) {
    return _then(_$_SipStatus(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SipStatus implements _SipStatus {
  const _$_SipStatus({this.displayName, required this.status});

  factory _$_SipStatus.fromJson(Map<String, dynamic> json) =>
      _$$_SipStatusFromJson(json);

  @override
  final String? displayName;
  @override
  final String status;

  @override
  String toString() {
    return 'SipStatus(displayName: $displayName, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SipStatus &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SipStatusCopyWith<_$_SipStatus> get copyWith =>
      __$$_SipStatusCopyWithImpl<_$_SipStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SipStatusToJson(
      this,
    );
  }
}

abstract class _SipStatus implements SipStatus {
  const factory _SipStatus(
      {final String? displayName, required final String status}) = _$_SipStatus;

  factory _SipStatus.fromJson(Map<String, dynamic> json) =
      _$_SipStatus.fromJson;

  @override
  String? get displayName;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_SipStatusCopyWith<_$_SipStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

Numbers _$NumbersFromJson(Map<String, dynamic> json) {
  return _Numbers.fromJson(json);
}

/// @nodoc
mixin _$Numbers {
  String get main => throw _privateConstructorUsedError;
  String? get ext => throw _privateConstructorUsedError;
  List<String>? get additional => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NumbersCopyWith<Numbers> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NumbersCopyWith<$Res> {
  factory $NumbersCopyWith(Numbers value, $Res Function(Numbers) then) =
      _$NumbersCopyWithImpl<$Res, Numbers>;
  @useResult
  $Res call({String main, String? ext, List<String>? additional});
}

/// @nodoc
class _$NumbersCopyWithImpl<$Res, $Val extends Numbers>
    implements $NumbersCopyWith<$Res> {
  _$NumbersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? ext = freezed,
    Object? additional = freezed,
  }) {
    return _then(_value.copyWith(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      additional: freezed == additional
          ? _value.additional
          : additional // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NumbersCopyWith<$Res> implements $NumbersCopyWith<$Res> {
  factory _$$_NumbersCopyWith(
          _$_Numbers value, $Res Function(_$_Numbers) then) =
      __$$_NumbersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String main, String? ext, List<String>? additional});
}

/// @nodoc
class __$$_NumbersCopyWithImpl<$Res>
    extends _$NumbersCopyWithImpl<$Res, _$_Numbers>
    implements _$$_NumbersCopyWith<$Res> {
  __$$_NumbersCopyWithImpl(_$_Numbers _value, $Res Function(_$_Numbers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? ext = freezed,
    Object? additional = freezed,
  }) {
    return _then(_$_Numbers(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as String,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      additional: freezed == additional
          ? _value._additional
          : additional // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Numbers implements _Numbers {
  const _$_Numbers(
      {required this.main, this.ext, final List<String>? additional})
      : _additional = additional;

  factory _$_Numbers.fromJson(Map<String, dynamic> json) =>
      _$$_NumbersFromJson(json);

  @override
  final String main;
  @override
  final String? ext;
  final List<String>? _additional;
  @override
  List<String>? get additional {
    final value = _additional;
    if (value == null) return null;
    if (_additional is EqualUnmodifiableListView) return _additional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Numbers(main: $main, ext: $ext, additional: $additional)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Numbers &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.ext, ext) || other.ext == ext) &&
            const DeepCollectionEquality()
                .equals(other._additional, _additional));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, main, ext, const DeepCollectionEquality().hash(_additional));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NumbersCopyWith<_$_Numbers> get copyWith =>
      __$$_NumbersCopyWithImpl<_$_Numbers>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NumbersToJson(
      this,
    );
  }
}

abstract class _Numbers implements Numbers {
  const factory _Numbers(
      {required final String main,
      final String? ext,
      final List<String>? additional}) = _$_Numbers;

  factory _Numbers.fromJson(Map<String, dynamic> json) = _$_Numbers.fromJson;

  @override
  String get main;
  @override
  String? get ext;
  @override
  List<String>? get additional;
  @override
  @JsonKey(ignore: true)
  _$$_NumbersCopyWith<_$_Numbers> get copyWith =>
      throw _privateConstructorUsedError;
}

Balance _$BalanceFromJson(Map<String, dynamic> json) {
  return _Balance.fromJson(json);
}

/// @nodoc
mixin _$Balance {
  BalanceType? get balanceType => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
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
      {BalanceType? balanceType,
      double? amount,
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
    Object? balanceType = freezed,
    Object? amount = freezed,
    Object? creditLimit = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      balanceType: freezed == balanceType
          ? _value.balanceType
          : balanceType // ignore: cast_nullable_to_non_nullable
              as BalanceType?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
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
      {BalanceType? balanceType,
      double? amount,
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
    Object? balanceType = freezed,
    Object? amount = freezed,
    Object? creditLimit = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_Balance(
      balanceType: freezed == balanceType
          ? _value.balanceType
          : balanceType // ignore: cast_nullable_to_non_nullable
              as BalanceType?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
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
      {this.balanceType, this.amount, this.creditLimit, this.currency});

  factory _$_Balance.fromJson(Map<String, dynamic> json) =>
      _$$_BalanceFromJson(json);

  @override
  final BalanceType? balanceType;
  @override
  final double? amount;
  @override
  final int? creditLimit;
  @override
  final String? currency;

  @override
  String toString() {
    return 'Balance(balanceType: $balanceType, amount: $amount, creditLimit: $creditLimit, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Balance &&
            (identical(other.balanceType, balanceType) ||
                other.balanceType == balanceType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, balanceType, amount, creditLimit, currency);

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
      {final BalanceType? balanceType,
      final double? amount,
      final int? creditLimit,
      final String? currency}) = _$_Balance;

  factory _Balance.fromJson(Map<String, dynamic> json) = _$_Balance.fromJson;

  @override
  BalanceType? get balanceType;
  @override
  double? get amount;
  @override
  int? get creditLimit;
  @override
  String? get currency;
  @override
  @JsonKey(ignore: true)
  _$$_BalanceCopyWith<_$_Balance> get copyWith =>
      throw _privateConstructorUsedError;
}

SipInfo _$SipInfoFromJson(Map<String, dynamic> json) {
  return _SipInfo.fromJson(json);
}

/// @nodoc
mixin _$SipInfo {
  String? get displayName => throw _privateConstructorUsedError;
  String? get login => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  SipServer? get registrationServer => throw _privateConstructorUsedError;
  SipServer? get sipServer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SipInfoCopyWith<SipInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SipInfoCopyWith<$Res> {
  factory $SipInfoCopyWith(SipInfo value, $Res Function(SipInfo) then) =
      _$SipInfoCopyWithImpl<$Res, SipInfo>;
  @useResult
  $Res call(
      {String? displayName,
      String? login,
      String? password,
      SipServer? registrationServer,
      SipServer? sipServer});

  $SipServerCopyWith<$Res>? get registrationServer;
  $SipServerCopyWith<$Res>? get sipServer;
}

/// @nodoc
class _$SipInfoCopyWithImpl<$Res, $Val extends SipInfo>
    implements $SipInfoCopyWith<$Res> {
  _$SipInfoCopyWithImpl(this._value, this._then);

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
              as SipServer?,
      sipServer: freezed == sipServer
          ? _value.sipServer
          : sipServer // ignore: cast_nullable_to_non_nullable
              as SipServer?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SipServerCopyWith<$Res>? get registrationServer {
    if (_value.registrationServer == null) {
      return null;
    }

    return $SipServerCopyWith<$Res>(_value.registrationServer!, (value) {
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
abstract class _$$_SipInfoCopyWith<$Res> implements $SipInfoCopyWith<$Res> {
  factory _$$_SipInfoCopyWith(
          _$_SipInfo value, $Res Function(_$_SipInfo) then) =
      __$$_SipInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? displayName,
      String? login,
      String? password,
      SipServer? registrationServer,
      SipServer? sipServer});

  @override
  $SipServerCopyWith<$Res>? get registrationServer;
  @override
  $SipServerCopyWith<$Res>? get sipServer;
}

/// @nodoc
class __$$_SipInfoCopyWithImpl<$Res>
    extends _$SipInfoCopyWithImpl<$Res, _$_SipInfo>
    implements _$$_SipInfoCopyWith<$Res> {
  __$$_SipInfoCopyWithImpl(_$_SipInfo _value, $Res Function(_$_SipInfo) _then)
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
    return _then(_$_SipInfo(
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
              as SipServer?,
      sipServer: freezed == sipServer
          ? _value.sipServer
          : sipServer // ignore: cast_nullable_to_non_nullable
              as SipServer?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SipInfo implements _SipInfo {
  const _$_SipInfo(
      {this.displayName,
      this.login,
      this.password,
      this.registrationServer,
      this.sipServer});

  factory _$_SipInfo.fromJson(Map<String, dynamic> json) =>
      _$$_SipInfoFromJson(json);

  @override
  final String? displayName;
  @override
  final String? login;
  @override
  final String? password;
  @override
  final SipServer? registrationServer;
  @override
  final SipServer? sipServer;

  @override
  String toString() {
    return 'SipInfo(displayName: $displayName, login: $login, password: $password, registrationServer: $registrationServer, sipServer: $sipServer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SipInfo &&
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
  _$$_SipInfoCopyWith<_$_SipInfo> get copyWith =>
      __$$_SipInfoCopyWithImpl<_$_SipInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SipInfoToJson(
      this,
    );
  }
}

abstract class _SipInfo implements SipInfo {
  const factory _SipInfo(
      {final String? displayName,
      final String? login,
      final String? password,
      final SipServer? registrationServer,
      final SipServer? sipServer}) = _$_SipInfo;

  factory _SipInfo.fromJson(Map<String, dynamic> json) = _$_SipInfo.fromJson;

  @override
  String? get displayName;
  @override
  String? get login;
  @override
  String? get password;
  @override
  SipServer? get registrationServer;
  @override
  SipServer? get sipServer;
  @override
  @JsonKey(ignore: true)
  _$$_SipInfoCopyWith<_$_SipInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

SipServer _$SipServerFromJson(Map<String, dynamic> json) {
  return _SipServer.fromJson(json);
}

/// @nodoc
mixin _$SipServer {
  bool? get forceTcp => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;
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
  $Res call({bool? forceTcp, String host, int? port});
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
    Object? host = null,
    Object? port = freezed,
  }) {
    return _then(_value.copyWith(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({bool? forceTcp, String host, int? port});
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
    Object? host = null,
    Object? port = freezed,
  }) {
    return _then(_$_SipServer(
      forceTcp: freezed == forceTcp
          ? _value.forceTcp
          : forceTcp // ignore: cast_nullable_to_non_nullable
              as bool?,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
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
  const _$_SipServer({this.forceTcp, required this.host, this.port});

  factory _$_SipServer.fromJson(Map<String, dynamic> json) =>
      _$$_SipServerFromJson(json);

  @override
  final bool? forceTcp;
  @override
  final String host;
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
      required final String host,
      final int? port}) = _$_SipServer;

  factory _SipServer.fromJson(Map<String, dynamic> json) =
      _$_SipServer.fromJson;

  @override
  bool? get forceTcp;
  @override
  String get host;
  @override
  int? get port;
  @override
  @JsonKey(ignore: true)
  _$$_SipServerCopyWith<_$_SipServer> get copyWith =>
      throw _privateConstructorUsedError;
}
