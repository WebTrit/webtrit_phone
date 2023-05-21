// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'texts_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TextsDTO _$TextsDTOFromJson(Map<String, dynamic> json) {
  return _TextsDTO.fromJson(json);
}

/// @nodoc
mixin _$TextsDTO {
  String? get greeting => throw _privateConstructorUsedError;
  String? get contact_email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextsDTOCopyWith<TextsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextsDTOCopyWith<$Res> {
  factory $TextsDTOCopyWith(TextsDTO value, $Res Function(TextsDTO) then) =
      _$TextsDTOCopyWithImpl<$Res, TextsDTO>;
  @useResult
  $Res call({String? greeting, String? contact_email});
}

/// @nodoc
class _$TextsDTOCopyWithImpl<$Res, $Val extends TextsDTO>
    implements $TextsDTOCopyWith<$Res> {
  _$TextsDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greeting = freezed,
    Object? contact_email = freezed,
  }) {
    return _then(_value.copyWith(
      greeting: freezed == greeting
          ? _value.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String?,
      contact_email: freezed == contact_email
          ? _value.contact_email
          : contact_email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TextsDTOCopyWith<$Res> implements $TextsDTOCopyWith<$Res> {
  factory _$$_TextsDTOCopyWith(
          _$_TextsDTO value, $Res Function(_$_TextsDTO) then) =
      __$$_TextsDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? greeting, String? contact_email});
}

/// @nodoc
class __$$_TextsDTOCopyWithImpl<$Res>
    extends _$TextsDTOCopyWithImpl<$Res, _$_TextsDTO>
    implements _$$_TextsDTOCopyWith<$Res> {
  __$$_TextsDTOCopyWithImpl(
      _$_TextsDTO _value, $Res Function(_$_TextsDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greeting = freezed,
    Object? contact_email = freezed,
  }) {
    return _then(_$_TextsDTO(
      greeting: freezed == greeting
          ? _value.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String?,
      contact_email: freezed == contact_email
          ? _value.contact_email
          : contact_email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TextsDTO implements _TextsDTO {
  const _$_TextsDTO({this.greeting, this.contact_email});

  factory _$_TextsDTO.fromJson(Map<String, dynamic> json) =>
      _$$_TextsDTOFromJson(json);

  @override
  final String? greeting;
  @override
  final String? contact_email;

  @override
  String toString() {
    return 'TextsDTO(greeting: $greeting, contact_email: $contact_email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextsDTO &&
            (identical(other.greeting, greeting) ||
                other.greeting == greeting) &&
            (identical(other.contact_email, contact_email) ||
                other.contact_email == contact_email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, greeting, contact_email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TextsDTOCopyWith<_$_TextsDTO> get copyWith =>
      __$$_TextsDTOCopyWithImpl<_$_TextsDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextsDTOToJson(
      this,
    );
  }
}

abstract class _TextsDTO implements TextsDTO {
  const factory _TextsDTO(
      {final String? greeting, final String? contact_email}) = _$_TextsDTO;

  factory _TextsDTO.fromJson(Map<String, dynamic> json) = _$_TextsDTO.fromJson;

  @override
  String? get greeting;
  @override
  String? get contact_email;
  @override
  @JsonKey(ignore: true)
  _$$_TextsDTOCopyWith<_$_TextsDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
