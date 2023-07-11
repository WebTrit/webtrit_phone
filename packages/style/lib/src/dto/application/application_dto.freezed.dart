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
  GoogleServices? get googleServices => throw _privateConstructorUsedError;

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
      int? version,
      GoogleServices? googleServices});

  $GoogleServicesCopyWith<$Res>? get googleServices;
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
    Object? googleServices = freezed,
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
      googleServices: freezed == googleServices
          ? _value.googleServices
          : googleServices // ignore: cast_nullable_to_non_nullable
              as GoogleServices?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoogleServicesCopyWith<$Res>? get googleServices {
    if (_value.googleServices == null) {
      return null;
    }

    return $GoogleServicesCopyWith<$Res>(_value.googleServices!, (value) {
      return _then(_value.copyWith(googleServices: value) as $Val);
    });
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
      int? version,
      GoogleServices? googleServices});

  @override
  $GoogleServicesCopyWith<$Res>? get googleServices;
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
    Object? googleServices = freezed,
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
      googleServices: freezed == googleServices
          ? _value.googleServices
          : googleServices // ignore: cast_nullable_to_non_nullable
              as GoogleServices?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_ApplicationDTO implements _ApplicationDTO {
  const _$_ApplicationDTO(
      {this.id,
      this.name,
      this.platformIdentifier,
      this.theme,
      this.version,
      this.googleServices});

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
  final GoogleServices? googleServices;

  @override
  String toString() {
    return 'ApplicationDTO(id: $id, name: $name, platformIdentifier: $platformIdentifier, theme: $theme, version: $version, googleServices: $googleServices)';
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
            (identical(other.version, version) || other.version == version) &&
            (identical(other.googleServices, googleServices) ||
                other.googleServices == googleServices));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, platformIdentifier,
      theme, version, googleServices);

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
      final int? version,
      final GoogleServices? googleServices}) = _$_ApplicationDTO;

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
  GoogleServices? get googleServices;
  @override
  @JsonKey(ignore: true)
  _$$_ApplicationDTOCopyWith<_$_ApplicationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

GoogleServices _$GoogleServicesFromJson(Map<String, dynamic> json) {
  return _GoogleServicesDTO.fromJson(json);
}

/// @nodoc
mixin _$GoogleServices {
  String? get androidUrl => throw _privateConstructorUsedError;
  String? get androidPath => throw _privateConstructorUsedError;
  String? get iosUrl => throw _privateConstructorUsedError;
  String? get iosPath => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoogleServicesCopyWith<GoogleServices> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleServicesCopyWith<$Res> {
  factory $GoogleServicesCopyWith(
          GoogleServices value, $Res Function(GoogleServices) then) =
      _$GoogleServicesCopyWithImpl<$Res, GoogleServices>;
  @useResult
  $Res call(
      {String? androidUrl,
      String? androidPath,
      String? iosUrl,
      String? iosPath,
      String? projectId});
}

/// @nodoc
class _$GoogleServicesCopyWithImpl<$Res, $Val extends GoogleServices>
    implements $GoogleServicesCopyWith<$Res> {
  _$GoogleServicesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? androidUrl = freezed,
    Object? androidPath = freezed,
    Object? iosUrl = freezed,
    Object? iosPath = freezed,
    Object? projectId = freezed,
  }) {
    return _then(_value.copyWith(
      androidUrl: freezed == androidUrl
          ? _value.androidUrl
          : androidUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      androidPath: freezed == androidPath
          ? _value.androidPath
          : androidPath // ignore: cast_nullable_to_non_nullable
              as String?,
      iosUrl: freezed == iosUrl
          ? _value.iosUrl
          : iosUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iosPath: freezed == iosPath
          ? _value.iosPath
          : iosPath // ignore: cast_nullable_to_non_nullable
              as String?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoogleServicesDTOCopyWith<$Res>
    implements $GoogleServicesCopyWith<$Res> {
  factory _$$_GoogleServicesDTOCopyWith(_$_GoogleServicesDTO value,
          $Res Function(_$_GoogleServicesDTO) then) =
      __$$_GoogleServicesDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? androidUrl,
      String? androidPath,
      String? iosUrl,
      String? iosPath,
      String? projectId});
}

/// @nodoc
class __$$_GoogleServicesDTOCopyWithImpl<$Res>
    extends _$GoogleServicesCopyWithImpl<$Res, _$_GoogleServicesDTO>
    implements _$$_GoogleServicesDTOCopyWith<$Res> {
  __$$_GoogleServicesDTOCopyWithImpl(
      _$_GoogleServicesDTO _value, $Res Function(_$_GoogleServicesDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? androidUrl = freezed,
    Object? androidPath = freezed,
    Object? iosUrl = freezed,
    Object? iosPath = freezed,
    Object? projectId = freezed,
  }) {
    return _then(_$_GoogleServicesDTO(
      androidUrl: freezed == androidUrl
          ? _value.androidUrl
          : androidUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      androidPath: freezed == androidPath
          ? _value.androidPath
          : androidPath // ignore: cast_nullable_to_non_nullable
              as String?,
      iosUrl: freezed == iosUrl
          ? _value.iosUrl
          : iosUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iosPath: freezed == iosPath
          ? _value.iosPath
          : iosPath // ignore: cast_nullable_to_non_nullable
              as String?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_GoogleServicesDTO implements _GoogleServicesDTO {
  const _$_GoogleServicesDTO(
      {this.androidUrl,
      this.androidPath,
      this.iosUrl,
      this.iosPath,
      this.projectId});

  factory _$_GoogleServicesDTO.fromJson(Map<String, dynamic> json) =>
      _$$_GoogleServicesDTOFromJson(json);

  @override
  final String? androidUrl;
  @override
  final String? androidPath;
  @override
  final String? iosUrl;
  @override
  final String? iosPath;
  @override
  final String? projectId;

  @override
  String toString() {
    return 'GoogleServices(androidUrl: $androidUrl, androidPath: $androidPath, iosUrl: $iosUrl, iosPath: $iosPath, projectId: $projectId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoogleServicesDTO &&
            (identical(other.androidUrl, androidUrl) ||
                other.androidUrl == androidUrl) &&
            (identical(other.androidPath, androidPath) ||
                other.androidPath == androidPath) &&
            (identical(other.iosUrl, iosUrl) || other.iosUrl == iosUrl) &&
            (identical(other.iosPath, iosPath) || other.iosPath == iosPath) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, androidUrl, androidPath, iosUrl, iosPath, projectId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoogleServicesDTOCopyWith<_$_GoogleServicesDTO> get copyWith =>
      __$$_GoogleServicesDTOCopyWithImpl<_$_GoogleServicesDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoogleServicesDTOToJson(
      this,
    );
  }
}

abstract class _GoogleServicesDTO implements GoogleServices {
  const factory _GoogleServicesDTO(
      {final String? androidUrl,
      final String? androidPath,
      final String? iosUrl,
      final String? iosPath,
      final String? projectId}) = _$_GoogleServicesDTO;

  factory _GoogleServicesDTO.fromJson(Map<String, dynamic> json) =
      _$_GoogleServicesDTO.fromJson;

  @override
  String? get androidUrl;
  @override
  String? get androidPath;
  @override
  String? get iosUrl;
  @override
  String? get iosPath;
  @override
  String? get projectId;
  @override
  @JsonKey(ignore: true)
  _$$_GoogleServicesDTOCopyWith<_$_GoogleServicesDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
