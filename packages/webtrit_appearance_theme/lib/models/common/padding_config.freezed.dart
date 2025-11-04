// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'padding_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaddingConfig _$PaddingConfigFromJson(Map<String, dynamic> json) {
  return _PaddingConfig.fromJson(json);
}

/// @nodoc
mixin _$PaddingConfig {
  double get left => throw _privateConstructorUsedError;
  double get top => throw _privateConstructorUsedError;
  double get right => throw _privateConstructorUsedError;
  double get bottom => throw _privateConstructorUsedError;

  /// Serializes this PaddingConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaddingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaddingConfigCopyWith<PaddingConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaddingConfigCopyWith<$Res> {
  factory $PaddingConfigCopyWith(
    PaddingConfig value,
    $Res Function(PaddingConfig) then,
  ) = _$PaddingConfigCopyWithImpl<$Res, PaddingConfig>;
  @useResult
  $Res call({double left, double top, double right, double bottom});
}

/// @nodoc
class _$PaddingConfigCopyWithImpl<$Res, $Val extends PaddingConfig>
    implements $PaddingConfigCopyWith<$Res> {
  _$PaddingConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaddingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? right = null,
    Object? bottom = null,
  }) {
    return _then(
      _value.copyWith(
            left: null == left
                ? _value.left
                : left // ignore: cast_nullable_to_non_nullable
                      as double,
            top: null == top
                ? _value.top
                : top // ignore: cast_nullable_to_non_nullable
                      as double,
            right: null == right
                ? _value.right
                : right // ignore: cast_nullable_to_non_nullable
                      as double,
            bottom: null == bottom
                ? _value.bottom
                : bottom // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaddingConfigImplCopyWith<$Res>
    implements $PaddingConfigCopyWith<$Res> {
  factory _$$PaddingConfigImplCopyWith(
    _$PaddingConfigImpl value,
    $Res Function(_$PaddingConfigImpl) then,
  ) = __$$PaddingConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double left, double top, double right, double bottom});
}

/// @nodoc
class __$$PaddingConfigImplCopyWithImpl<$Res>
    extends _$PaddingConfigCopyWithImpl<$Res, _$PaddingConfigImpl>
    implements _$$PaddingConfigImplCopyWith<$Res> {
  __$$PaddingConfigImplCopyWithImpl(
    _$PaddingConfigImpl _value,
    $Res Function(_$PaddingConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaddingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? right = null,
    Object? bottom = null,
  }) {
    return _then(
      _$PaddingConfigImpl(
        left: null == left
            ? _value.left
            : left // ignore: cast_nullable_to_non_nullable
                  as double,
        top: null == top
            ? _value.top
            : top // ignore: cast_nullable_to_non_nullable
                  as double,
        right: null == right
            ? _value.right
            : right // ignore: cast_nullable_to_non_nullable
                  as double,
        bottom: null == bottom
            ? _value.bottom
            : bottom // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaddingConfigImpl implements _PaddingConfig {
  const _$PaddingConfigImpl({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  factory _$PaddingConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaddingConfigImplFromJson(json);

  @override
  @JsonKey()
  final double left;
  @override
  @JsonKey()
  final double top;
  @override
  @JsonKey()
  final double right;
  @override
  @JsonKey()
  final double bottom;

  @override
  String toString() {
    return 'PaddingConfig(left: $left, top: $top, right: $right, bottom: $bottom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaddingConfigImpl &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.right, right) || other.right == right) &&
            (identical(other.bottom, bottom) || other.bottom == bottom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, left, top, right, bottom);

  /// Create a copy of PaddingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaddingConfigImplCopyWith<_$PaddingConfigImpl> get copyWith =>
      __$$PaddingConfigImplCopyWithImpl<_$PaddingConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaddingConfigImplToJson(this);
  }
}

abstract class _PaddingConfig implements PaddingConfig {
  const factory _PaddingConfig({
    final double left,
    final double top,
    final double right,
    final double bottom,
  }) = _$PaddingConfigImpl;

  factory _PaddingConfig.fromJson(Map<String, dynamic> json) =
      _$PaddingConfigImpl.fromJson;

  @override
  double get left;
  @override
  double get top;
  @override
  double get right;
  @override
  double get bottom;

  /// Create a copy of PaddingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaddingConfigImplCopyWith<_$PaddingConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
