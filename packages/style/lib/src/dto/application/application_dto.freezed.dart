// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApplicationDTO _$ApplicationDTOFromJson(Map<String, dynamic> json) {
  return _ApplicationDTO.fromJson(json);
}

/// @nodoc
mixin _$ApplicationDTO {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get platformIdentifier => throw _privateConstructorUsedError;
  String? get theme => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplicationDTOCopyWith<ApplicationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationDTOCopyWith<$Res> {
  factory $ApplicationDTOCopyWith(
          ApplicationDTO value, $Res Function(ApplicationDTO) then) =
      _$ApplicationDTOCopyWithImpl<$Res, ApplicationDTO>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? platformIdentifier,
      String? theme,
      int? version});
}

/// @nodoc
class _$ApplicationDTOCopyWithImpl<$Res, $Val extends ApplicationDTO>
    implements $ApplicationDTOCopyWith<$Res> {
  _$ApplicationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? platformIdentifier = freezed,
    Object? theme = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      platformIdentifier: freezed == platformIdentifier
          ? _value.platformIdentifier
          : platformIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApplicationDTOCopyWith<$Res>
    implements $ApplicationDTOCopyWith<$Res> {
  factory _$$_ApplicationDTOCopyWith(
          _$_ApplicationDTO value, $Res Function(_$_ApplicationDTO) then) =
      __$$_ApplicationDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? platformIdentifier,
      String? theme,
      int? version});
}

/// @nodoc
class __$$_ApplicationDTOCopyWithImpl<$Res>
    extends _$ApplicationDTOCopyWithImpl<$Res, _$_ApplicationDTO>
    implements _$$_ApplicationDTOCopyWith<$Res> {
  __$$_ApplicationDTOCopyWithImpl(
      _$_ApplicationDTO _value, $Res Function(_$_ApplicationDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? platformIdentifier = freezed,
    Object? theme = freezed,
    Object? version = freezed,
  }) {
    return _then(_$_ApplicationDTO(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      platformIdentifier: freezed == platformIdentifier
          ? _value.platformIdentifier
          : platformIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_ApplicationDTO implements _ApplicationDTO {
  const _$_ApplicationDTO(
      {this.id, this.name, this.platformIdentifier, this.theme, this.version});

  factory _$_ApplicationDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ApplicationDTOFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? platformIdentifier;
  @override
  final String? theme;
  @override
  final int? version;

  @override
  String toString() {
    return 'ApplicationDTO(id: $id, name: $name, platformIdentifier: $platformIdentifier, theme: $theme, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApplicationDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.platformIdentifier, platformIdentifier) ||
                other.platformIdentifier == platformIdentifier) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, platformIdentifier, theme, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApplicationDTOCopyWith<_$_ApplicationDTO> get copyWith =>
      __$$_ApplicationDTOCopyWithImpl<_$_ApplicationDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApplicationDTOToJson(
      this,
    );
  }
}

abstract class _ApplicationDTO implements ApplicationDTO {
  const factory _ApplicationDTO(
      {final String? id,
      final String? name,
      final String? platformIdentifier,
      final String? theme,
      final int? version}) = _$_ApplicationDTO;

  factory _ApplicationDTO.fromJson(Map<String, dynamic> json) =
      _$_ApplicationDTO.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get platformIdentifier;
  @override
  String? get theme;
  @override
  int? get version;
  @override
  @JsonKey(ignore: true)
  _$$_ApplicationDTOCopyWith<_$_ApplicationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
