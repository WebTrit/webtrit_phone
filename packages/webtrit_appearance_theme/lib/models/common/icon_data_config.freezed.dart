// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_data_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IconDataConfig _$IconDataConfigFromJson(Map<String, dynamic> json) {
  return _IconDataConfig.fromJson(json);
}

/// @nodoc
mixin _$IconDataConfig {
  /// e.g. 0xe491 (58513)
  @HexCodePointConverter()
  int get codePoint => throw _privateConstructorUsedError;

  /// e.g. "MaterialIcons"
  String get fontFamily => throw _privateConstructorUsedError;

  /// Mirrors IconData.matchTextDirection
  bool get matchTextDirection => throw _privateConstructorUsedError;

  /// Serializes this IconDataConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IconDataConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IconDataConfigCopyWith<IconDataConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IconDataConfigCopyWith<$Res> {
  factory $IconDataConfigCopyWith(
          IconDataConfig value, $Res Function(IconDataConfig) then) =
      _$IconDataConfigCopyWithImpl<$Res, IconDataConfig>;
  @useResult
  $Res call(
      {@HexCodePointConverter() int codePoint,
      String fontFamily,
      bool matchTextDirection});
}

/// @nodoc
class _$IconDataConfigCopyWithImpl<$Res, $Val extends IconDataConfig>
    implements $IconDataConfigCopyWith<$Res> {
  _$IconDataConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IconDataConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codePoint = null,
    Object? fontFamily = null,
    Object? matchTextDirection = null,
  }) {
    return _then(_value.copyWith(
      codePoint: null == codePoint
          ? _value.codePoint
          : codePoint // ignore: cast_nullable_to_non_nullable
              as int,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      matchTextDirection: null == matchTextDirection
          ? _value.matchTextDirection
          : matchTextDirection // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IconDataConfigImplCopyWith<$Res>
    implements $IconDataConfigCopyWith<$Res> {
  factory _$$IconDataConfigImplCopyWith(_$IconDataConfigImpl value,
          $Res Function(_$IconDataConfigImpl) then) =
      __$$IconDataConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HexCodePointConverter() int codePoint,
      String fontFamily,
      bool matchTextDirection});
}

/// @nodoc
class __$$IconDataConfigImplCopyWithImpl<$Res>
    extends _$IconDataConfigCopyWithImpl<$Res, _$IconDataConfigImpl>
    implements _$$IconDataConfigImplCopyWith<$Res> {
  __$$IconDataConfigImplCopyWithImpl(
      _$IconDataConfigImpl _value, $Res Function(_$IconDataConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of IconDataConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codePoint = null,
    Object? fontFamily = null,
    Object? matchTextDirection = null,
  }) {
    return _then(_$IconDataConfigImpl(
      codePoint: null == codePoint
          ? _value.codePoint
          : codePoint // ignore: cast_nullable_to_non_nullable
              as int,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      matchTextDirection: null == matchTextDirection
          ? _value.matchTextDirection
          : matchTextDirection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IconDataConfigImpl implements _IconDataConfig {
  const _$IconDataConfigImpl(
      {@HexCodePointConverter() required this.codePoint,
      this.fontFamily = 'MaterialIcons',
      this.matchTextDirection = false});

  factory _$IconDataConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$IconDataConfigImplFromJson(json);

  /// e.g. 0xe491 (58513)
  @override
  @HexCodePointConverter()
  final int codePoint;

  /// e.g. "MaterialIcons"
  @override
  @JsonKey()
  final String fontFamily;

  /// Mirrors IconData.matchTextDirection
  @override
  @JsonKey()
  final bool matchTextDirection;

  @override
  String toString() {
    return 'IconDataConfig(codePoint: $codePoint, fontFamily: $fontFamily, matchTextDirection: $matchTextDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IconDataConfigImpl &&
            (identical(other.codePoint, codePoint) ||
                other.codePoint == codePoint) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.matchTextDirection, matchTextDirection) ||
                other.matchTextDirection == matchTextDirection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, codePoint, fontFamily, matchTextDirection);

  /// Create a copy of IconDataConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IconDataConfigImplCopyWith<_$IconDataConfigImpl> get copyWith =>
      __$$IconDataConfigImplCopyWithImpl<_$IconDataConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IconDataConfigImplToJson(
      this,
    );
  }
}

abstract class _IconDataConfig implements IconDataConfig {
  const factory _IconDataConfig(
      {@HexCodePointConverter() required final int codePoint,
      final String fontFamily,
      final bool matchTextDirection}) = _$IconDataConfigImpl;

  factory _IconDataConfig.fromJson(Map<String, dynamic> json) =
      _$IconDataConfigImpl.fromJson;

  /// e.g. 0xe491 (58513)
  @override
  @HexCodePointConverter()
  int get codePoint;

  /// e.g. "MaterialIcons"
  @override
  String get fontFamily;

  /// Mirrors IconData.matchTextDirection
  @override
  bool get matchTextDirection;

  /// Create a copy of IconDataConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IconDataConfigImplCopyWith<_$IconDataConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
