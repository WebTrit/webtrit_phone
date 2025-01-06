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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomColor _$CustomColorFromJson(Map<String, dynamic> json) {
  return _CustomColor.fromJson(json);
}

/// @nodoc
mixin _$CustomColor {
  String get color => throw _privateConstructorUsedError;
  bool get blend => throw _privateConstructorUsedError;

  /// Serializes this CustomColor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
  Map<String, dynamic> toJson() {
    return _$$CustomColorImplToJson(
      this,
    );
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
}
