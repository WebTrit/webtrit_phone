// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomColor _$CustomColorFromJson(Map<String, dynamic> json) {
  return _CustomColor.fromJson(json);
}

/// @nodoc
mixin _$CustomColor {
  String get color => throw _privateConstructorUsedError;
  bool get blend => throw _privateConstructorUsedError;

  /// Serializes this CustomColor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomColorCopyWith<CustomColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomColorCopyWith<$Res> {
  factory $CustomColorCopyWith(
    CustomColor value,
    $Res Function(CustomColor) then,
  ) = _$CustomColorCopyWithImpl<$Res, CustomColor>;
  @useResult
  $Res call({String color, bool blend});
}

/// @nodoc
class _$CustomColorCopyWithImpl<$Res, $Val extends CustomColor>
    implements $CustomColorCopyWith<$Res> {
  _$CustomColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null, Object? blend = null}) {
    return _then(
      _value.copyWith(
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            blend: null == blend
                ? _value.blend
                : blend // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomColorImplCopyWith<$Res>
    implements $CustomColorCopyWith<$Res> {
  factory _$$CustomColorImplCopyWith(
    _$CustomColorImpl value,
    $Res Function(_$CustomColorImpl) then,
  ) = __$$CustomColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String color, bool blend});
}

/// @nodoc
class __$$CustomColorImplCopyWithImpl<$Res>
    extends _$CustomColorCopyWithImpl<$Res, _$CustomColorImpl>
    implements _$$CustomColorImplCopyWith<$Res> {
  __$$CustomColorImplCopyWithImpl(
    _$CustomColorImpl _value,
    $Res Function(_$CustomColorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null, Object? blend = null}) {
    return _then(
      _$CustomColorImpl(
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        blend: null == blend
            ? _value.blend
            : blend // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomColorImpl implements _CustomColor {
  const _$CustomColorImpl({required this.color, this.blend = true});

  factory _$CustomColorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomColorImplFromJson(json);

  @override
  final String color;
  @override
  @JsonKey()
  final bool blend;

  @override
  String toString() {
    return 'CustomColor(color: $color, blend: $blend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomColorImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.blend, blend) || other.blend == blend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color, blend);

  /// Create a copy of CustomColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomColorImplCopyWith<_$CustomColorImpl> get copyWith =>
      __$$CustomColorImplCopyWithImpl<_$CustomColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomColorImplToJson(this);
  }
}

abstract class _CustomColor implements CustomColor {
  const factory _CustomColor({required final String color, final bool blend}) =
      _$CustomColorImpl;

  factory _CustomColor.fromJson(Map<String, dynamic> json) =
      _$CustomColorImpl.fromJson;

  @override
  String get color;
  @override
  bool get blend;

  /// Create a copy of CustomColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomColorImplCopyWith<_$CustomColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
