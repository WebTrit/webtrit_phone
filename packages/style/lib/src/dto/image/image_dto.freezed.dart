// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageDTO _$ImageDTOFromJson(Map<String, dynamic> json) {
  return _ImageDTO.fromJson(json);
}

/// @nodoc
mixin _$ImageDTO {
  String? get data => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get mime => throw _privateConstructorUsedError;
  String? get extension => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageDTOCopyWith<ImageDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDTOCopyWith<$Res> {
  factory $ImageDTOCopyWith(ImageDTO value, $Res Function(ImageDTO) then) =
      _$ImageDTOCopyWithImpl<$Res, ImageDTO>;
  @useResult
  $Res call({String? data, String? name, String? mime, String? extension});
}

/// @nodoc
class _$ImageDTOCopyWithImpl<$Res, $Val extends ImageDTO>
    implements $ImageDTOCopyWith<$Res> {
  _$ImageDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? name = freezed,
    Object? mime = freezed,
    Object? extension = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mime: freezed == mime
          ? _value.mime
          : mime // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: freezed == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageDTOCopyWith<$Res> implements $ImageDTOCopyWith<$Res> {
  factory _$$_ImageDTOCopyWith(
          _$_ImageDTO value, $Res Function(_$_ImageDTO) then) =
      __$$_ImageDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? data, String? name, String? mime, String? extension});
}

/// @nodoc
class __$$_ImageDTOCopyWithImpl<$Res>
    extends _$ImageDTOCopyWithImpl<$Res, _$_ImageDTO>
    implements _$$_ImageDTOCopyWith<$Res> {
  __$$_ImageDTOCopyWithImpl(
      _$_ImageDTO _value, $Res Function(_$_ImageDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? name = freezed,
    Object? mime = freezed,
    Object? extension = freezed,
  }) {
    return _then(_$_ImageDTO(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mime: freezed == mime
          ? _value.mime
          : mime // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: freezed == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageDTO implements _ImageDTO {
  const _$_ImageDTO({this.data, this.name, this.mime, this.extension});

  factory _$_ImageDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ImageDTOFromJson(json);

  @override
  final String? data;
  @override
  final String? name;
  @override
  final String? mime;
  @override
  final String? extension;

  @override
  String toString() {
    return 'ImageDTO(data: $data, name: $name, mime: $mime, extension: $extension)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageDTO &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mime, mime) || other.mime == mime) &&
            (identical(other.extension, extension) ||
                other.extension == extension));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, name, mime, extension);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageDTOCopyWith<_$_ImageDTO> get copyWith =>
      __$$_ImageDTOCopyWithImpl<_$_ImageDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageDTOToJson(
      this,
    );
  }
}

abstract class _ImageDTO implements ImageDTO {
  const factory _ImageDTO(
      {final String? data,
      final String? name,
      final String? mime,
      final String? extension}) = _$_ImageDTO;

  factory _ImageDTO.fromJson(Map<String, dynamic> json) = _$_ImageDTO.fromJson;

  @override
  String? get data;
  @override
  String? get name;
  @override
  String? get mime;
  @override
  String? get extension;
  @override
  @JsonKey(ignore: true)
  _$$_ImageDTOCopyWith<_$_ImageDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
