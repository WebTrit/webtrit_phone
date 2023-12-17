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
abstract class _$$NumbersImplCopyWith<$Res> implements $NumbersCopyWith<$Res> {
  factory _$$NumbersImplCopyWith(
          _$NumbersImpl value, $Res Function(_$NumbersImpl) then) =
      __$$NumbersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String main, String? ext, List<String>? additional});
}

/// @nodoc
class __$$NumbersImplCopyWithImpl<$Res>
    extends _$NumbersCopyWithImpl<$Res, _$NumbersImpl>
    implements _$$NumbersImplCopyWith<$Res> {
  __$$NumbersImplCopyWithImpl(
      _$NumbersImpl _value, $Res Function(_$NumbersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
    Object? ext = freezed,
    Object? additional = freezed,
  }) {
    return _then(_$NumbersImpl(
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
class _$NumbersImpl implements _Numbers {
  const _$NumbersImpl(
      {required this.main, this.ext, final List<String>? additional})
      : _additional = additional;

  factory _$NumbersImpl.fromJson(Map<String, dynamic> json) =>
      _$$NumbersImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NumbersImpl &&
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
  _$$NumbersImplCopyWith<_$NumbersImpl> get copyWith =>
      __$$NumbersImplCopyWithImpl<_$NumbersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NumbersImplToJson(
      this,
    );
  }
}

abstract class _Numbers implements Numbers {
  const factory _Numbers(
      {required final String main,
      final String? ext,
      final List<String>? additional}) = _$NumbersImpl;

  factory _Numbers.fromJson(Map<String, dynamic> json) = _$NumbersImpl.fromJson;

  @override
  String get main;
  @override
  String? get ext;
  @override
  List<String>? get additional;
  @override
  @JsonKey(ignore: true)
  _$$NumbersImplCopyWith<_$NumbersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Balance _$BalanceFromJson(Map<String, dynamic> json) {
  return _Balance.fromJson(json);
}

/// @nodoc
mixin _$Balance {
  BalanceType? get balanceType => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  double? get creditLimit => throw _privateConstructorUsedError;
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
      double? creditLimit,
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
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceImplCopyWith<$Res> implements $BalanceCopyWith<$Res> {
  factory _$$BalanceImplCopyWith(
          _$BalanceImpl value, $Res Function(_$BalanceImpl) then) =
      __$$BalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BalanceType? balanceType,
      double? amount,
      double? creditLimit,
      String? currency});
}

/// @nodoc
class __$$BalanceImplCopyWithImpl<$Res>
    extends _$BalanceCopyWithImpl<$Res, _$BalanceImpl>
    implements _$$BalanceImplCopyWith<$Res> {
  __$$BalanceImplCopyWithImpl(
      _$BalanceImpl _value, $Res Function(_$BalanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balanceType = freezed,
    Object? amount = freezed,
    Object? creditLimit = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$BalanceImpl(
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
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$BalanceImpl implements _Balance {
  const _$BalanceImpl(
      {this.balanceType, this.amount, this.creditLimit, this.currency});

  factory _$BalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceImplFromJson(json);

  @override
  final BalanceType? balanceType;
  @override
  final double? amount;
  @override
  final double? creditLimit;
  @override
  final String? currency;

  @override
  String toString() {
    return 'Balance(balanceType: $balanceType, amount: $amount, creditLimit: $creditLimit, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceImpl &&
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
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      __$$BalanceImplCopyWithImpl<_$BalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceImplToJson(
      this,
    );
  }
}

abstract class _Balance implements Balance {
  const factory _Balance(
      {final BalanceType? balanceType,
      final double? amount,
      final double? creditLimit,
      final String? currency}) = _$BalanceImpl;

  factory _Balance.fromJson(Map<String, dynamic> json) = _$BalanceImpl.fromJson;

  @override
  BalanceType? get balanceType;
  @override
  double? get amount;
  @override
  double? get creditLimit;
  @override
  String? get currency;
  @override
  @JsonKey(ignore: true)
  _$$BalanceImplCopyWith<_$BalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
