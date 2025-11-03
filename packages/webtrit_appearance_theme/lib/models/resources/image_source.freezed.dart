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
  ImageRenderSpec? get render => throw _privateConstructorUsedError;

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
      ImageRenderSpec? render,
      Metadata metadata});

  $ImageRenderSpecCopyWith<$Res>? get render;
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
    Object? render = freezed,
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
      render: freezed == render
          ? _value.render
          : render // ignore: cast_nullable_to_non_nullable
              as ImageRenderSpec?,
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
  $ImageRenderSpecCopyWith<$Res>? get render {
    if (_value.render == null) {
      return null;
    }

    return $ImageRenderSpecCopyWith<$Res>(_value.render!, (value) {
      return _then(_value.copyWith(render: value) as $Val);
    });
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
      ImageRenderSpec? render,
      Metadata metadata});

  @override
  $ImageRenderSpecCopyWith<$Res>? get render;
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
    Object? render = freezed,
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
      render: freezed == render
          ? _value.render
          : render // ignore: cast_nullable_to_non_nullable
              as ImageRenderSpec?,
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
      this.render,
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
  @override
  final ImageRenderSpec? render;

  /// Freeform metadata for build tools / CLI / pipelines.
  /// Example: `{ "preserveRemote": true }`
  @override
  @JsonKey()
  final Metadata metadata;

  @override
  String toString() {
    return 'ImageSource(id: $id, uri: $uri, ref: $ref, render: $render, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageSourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.render, render) || other.render == render) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uri, ref, render, metadata);

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
      final ImageRenderSpec? render,
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
  @override
  ImageRenderSpec? get render;

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

ImageRenderSpec _$ImageRenderSpecFromJson(Map<String, dynamic> json) {
  return _ImageRenderSpec.fromJson(json);
}

/// @nodoc
mixin _$ImageRenderSpec {
  /// The scale factor applied during rendering.
  double? get scale => throw _privateConstructorUsedError;

  /// Optional padding around the image.
  PaddingConfig? get padding => throw _privateConstructorUsedError;

  /// Serializes this ImageRenderSpec to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageRenderSpecCopyWith<ImageRenderSpec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageRenderSpecCopyWith<$Res> {
  factory $ImageRenderSpecCopyWith(
          ImageRenderSpec value, $Res Function(ImageRenderSpec) then) =
      _$ImageRenderSpecCopyWithImpl<$Res, ImageRenderSpec>;
  @useResult
  $Res call({double? scale, PaddingConfig? padding});

  $PaddingConfigCopyWith<$Res>? get padding;
}

/// @nodoc
class _$ImageRenderSpecCopyWithImpl<$Res, $Val extends ImageRenderSpec>
    implements $ImageRenderSpecCopyWith<$Res> {
  _$ImageRenderSpecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = freezed,
    Object? padding = freezed,
  }) {
    return _then(_value.copyWith(
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as PaddingConfig?,
    ) as $Val);
  }

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaddingConfigCopyWith<$Res>? get padding {
    if (_value.padding == null) {
      return null;
    }

    return $PaddingConfigCopyWith<$Res>(_value.padding!, (value) {
      return _then(_value.copyWith(padding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageRenderSpecImplCopyWith<$Res>
    implements $ImageRenderSpecCopyWith<$Res> {
  factory _$$ImageRenderSpecImplCopyWith(_$ImageRenderSpecImpl value,
          $Res Function(_$ImageRenderSpecImpl) then) =
      __$$ImageRenderSpecImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? scale, PaddingConfig? padding});

  @override
  $PaddingConfigCopyWith<$Res>? get padding;
}

/// @nodoc
class __$$ImageRenderSpecImplCopyWithImpl<$Res>
    extends _$ImageRenderSpecCopyWithImpl<$Res, _$ImageRenderSpecImpl>
    implements _$$ImageRenderSpecImplCopyWith<$Res> {
  __$$ImageRenderSpecImplCopyWithImpl(
      _$ImageRenderSpecImpl _value, $Res Function(_$ImageRenderSpecImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scale = freezed,
    Object? padding = freezed,
  }) {
    return _then(_$ImageRenderSpecImpl(
      scale: freezed == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
      padding: freezed == padding
          ? _value.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as PaddingConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageRenderSpecImpl implements _ImageRenderSpec {
  const _$ImageRenderSpecImpl({this.scale, this.padding});

  factory _$ImageRenderSpecImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageRenderSpecImplFromJson(json);

  /// The scale factor applied during rendering.
  @override
  final double? scale;

  /// Optional padding around the image.
  @override
  final PaddingConfig? padding;

  @override
  String toString() {
    return 'ImageRenderSpec(scale: $scale, padding: $padding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageRenderSpecImpl &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.padding, padding) || other.padding == padding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, scale, padding);

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageRenderSpecImplCopyWith<_$ImageRenderSpecImpl> get copyWith =>
      __$$ImageRenderSpecImplCopyWithImpl<_$ImageRenderSpecImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageRenderSpecImplToJson(
      this,
    );
  }
}

abstract class _ImageRenderSpec implements ImageRenderSpec {
  const factory _ImageRenderSpec(
      {final double? scale,
      final PaddingConfig? padding}) = _$ImageRenderSpecImpl;

  factory _ImageRenderSpec.fromJson(Map<String, dynamic> json) =
      _$ImageRenderSpecImpl.fromJson;

  /// The scale factor applied during rendering.
  @override
  double? get scale;

  /// Optional padding around the image.
  @override
  PaddingConfig? get padding;

  /// Create a copy of ImageRenderSpec
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageRenderSpecImplCopyWith<_$ImageRenderSpecImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
