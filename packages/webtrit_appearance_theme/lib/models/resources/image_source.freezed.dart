// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageSource _$ImageSourceFromJson(Map<String, dynamic> json) {
  return _ImageSource.fromJson(json);
}

/// @nodoc
mixin _$ImageSource {
  /// Backend asset ID (unique identifier in storage).
  /// Required for backend-side linking, optional in dev or local-only assets.
  String? get id => throw _privateConstructorUsedError;

  /// Unified URI pointing to the resource.
  /// Examples:
  /// - `asset://assets/logo.svg` (bundled asset inside the app)
  /// - `https://...` (signed URL or CDN reference)
  /// - `file://...` (local file reference, dev only)
  String? get uri => throw _privateConstructorUsedError;

  /// Semantic type of reference (default = "asset").
  /// Can be extended in future (e.g., "cdn", "inline").
  @JsonKey(name: r'$ref')
  String get ref => throw _privateConstructorUsedError;

  /// Freeform metadata for build tools / CLI / pipelines.
  /// Example: `{ "preserveRemote": true }`
  Metadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this ImageSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageSourceCopyWith<ImageSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageSourceCopyWith<$Res> {
  factory $ImageSourceCopyWith(
          ImageSource value, $Res Function(ImageSource) then) =
      _$ImageSourceCopyWithImpl<$Res, ImageSource>;
  @useResult
  $Res call(
      {String? id,
      String? uri,
      @JsonKey(name: r'$ref') String ref,
      Metadata metadata});

  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$ImageSourceCopyWithImpl<$Res, $Val extends ImageSource>
    implements $ImageSourceCopyWith<$Res> {
  _$ImageSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uri = freezed,
    Object? ref = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ) as $Val);
  }

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res> get metadata {
    return $MetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageSourceImplCopyWith<$Res>
    implements $ImageSourceCopyWith<$Res> {
  factory _$$ImageSourceImplCopyWith(
          _$ImageSourceImpl value, $Res Function(_$ImageSourceImpl) then) =
      __$$ImageSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? uri,
      @JsonKey(name: r'$ref') String ref,
      Metadata metadata});

  @override
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$ImageSourceImplCopyWithImpl<$Res>
    extends _$ImageSourceCopyWithImpl<$Res, _$ImageSourceImpl>
    implements _$$ImageSourceImplCopyWith<$Res> {
  __$$ImageSourceImplCopyWithImpl(
      _$ImageSourceImpl _value, $Res Function(_$ImageSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uri = freezed,
    Object? ref = null,
    Object? metadata = null,
  }) {
    return _then(_$ImageSourceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageSourceImpl extends _ImageSource {
  const _$ImageSourceImpl(
      {this.id,
      this.uri,
      @JsonKey(name: r'$ref') this.ref = 'asset',
      this.metadata = const Metadata()})
      : super._();

  factory _$ImageSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageSourceImplFromJson(json);

  /// Backend asset ID (unique identifier in storage).
  /// Required for backend-side linking, optional in dev or local-only assets.
  @override
  final String? id;

  /// Unified URI pointing to the resource.
  /// Examples:
  /// - `asset://assets/logo.svg` (bundled asset inside the app)
  /// - `https://...` (signed URL or CDN reference)
  /// - `file://...` (local file reference, dev only)
  @override
  final String? uri;

  /// Semantic type of reference (default = "asset").
  /// Can be extended in future (e.g., "cdn", "inline").
  @override
  @JsonKey(name: r'$ref')
  final String ref;

  /// Freeform metadata for build tools / CLI / pipelines.
  /// Example: `{ "preserveRemote": true }`
  @override
  @JsonKey()
  final Metadata metadata;

  @override
  String toString() {
    return 'ImageSource(id: $id, uri: $uri, ref: $ref, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageSourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uri, ref, metadata);

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageSourceImplCopyWith<_$ImageSourceImpl> get copyWith =>
      __$$ImageSourceImplCopyWithImpl<_$ImageSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageSourceImplToJson(
      this,
    );
  }
}

abstract class _ImageSource extends ImageSource {
  const factory _ImageSource(
      {final String? id,
      final String? uri,
      @JsonKey(name: r'$ref') final String ref,
      final Metadata metadata}) = _$ImageSourceImpl;
  const _ImageSource._() : super._();

  factory _ImageSource.fromJson(Map<String, dynamic> json) =
      _$ImageSourceImpl.fromJson;

  /// Backend asset ID (unique identifier in storage).
  /// Required for backend-side linking, optional in dev or local-only assets.
  @override
  String? get id;

  /// Unified URI pointing to the resource.
  /// Examples:
  /// - `asset://assets/logo.svg` (bundled asset inside the app)
  /// - `https://...` (signed URL or CDN reference)
  /// - `file://...` (local file reference, dev only)
  @override
  String? get uri;

  /// Semantic type of reference (default = "asset").
  /// Can be extended in future (e.g., "cdn", "inline").
  @override
  @JsonKey(name: r'$ref')
  String get ref;

  /// Freeform metadata for build tools / CLI / pipelines.
  /// Example: `{ "preserveRemote": true }`
  @override
  Metadata get metadata;

  /// Create a copy of ImageSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageSourceImplCopyWith<_$ImageSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
