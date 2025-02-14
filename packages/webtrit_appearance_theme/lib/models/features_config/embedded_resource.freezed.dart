// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmbeddedResource _$EmbeddedResourceFromJson(Map<String, dynamic> json) {
  return _EmbeddedResource.fromJson(json);
}

/// @nodoc
mixin _$EmbeddedResource {
  int? get id => throw _privateConstructorUsedError;
  String get resource => throw _privateConstructorUsedError;
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;
  ToolbarConfig get toolbar => throw _privateConstructorUsedError;
  Metadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this EmbeddedResource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmbeddedResourceCopyWith<EmbeddedResource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmbeddedResourceCopyWith<$Res> {
  factory $EmbeddedResourceCopyWith(
          EmbeddedResource value, $Res Function(EmbeddedResource) then) =
      _$EmbeddedResourceCopyWithImpl<$Res, EmbeddedResource>;
  @useResult
  $Res call(
      {int? id,
      String resource,
      Map<String, dynamic> attributes,
      ToolbarConfig toolbar,
      Metadata metadata});

  $ToolbarConfigCopyWith<$Res> get toolbar;
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$EmbeddedResourceCopyWithImpl<$Res, $Val extends EmbeddedResource>
    implements $EmbeddedResourceCopyWith<$Res> {
  _$EmbeddedResourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resource = null,
    Object? attributes = null,
    Object? toolbar = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      toolbar: null == toolbar
          ? _value.toolbar
          : toolbar // ignore: cast_nullable_to_non_nullable
              as ToolbarConfig,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ) as $Val);
  }

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToolbarConfigCopyWith<$Res> get toolbar {
    return $ToolbarConfigCopyWith<$Res>(_value.toolbar, (value) {
      return _then(_value.copyWith(toolbar: value) as $Val);
    });
  }

  /// Create a copy of EmbeddedResource
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
abstract class _$$EmbeddedResourceImplCopyWith<$Res>
    implements $EmbeddedResourceCopyWith<$Res> {
  factory _$$EmbeddedResourceImplCopyWith(_$EmbeddedResourceImpl value,
          $Res Function(_$EmbeddedResourceImpl) then) =
      __$$EmbeddedResourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String resource,
      Map<String, dynamic> attributes,
      ToolbarConfig toolbar,
      Metadata metadata});

  @override
  $ToolbarConfigCopyWith<$Res> get toolbar;
  @override
  $MetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$EmbeddedResourceImplCopyWithImpl<$Res>
    extends _$EmbeddedResourceCopyWithImpl<$Res, _$EmbeddedResourceImpl>
    implements _$$EmbeddedResourceImplCopyWith<$Res> {
  __$$EmbeddedResourceImplCopyWithImpl(_$EmbeddedResourceImpl _value,
      $Res Function(_$EmbeddedResourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? resource = null,
    Object? attributes = null,
    Object? toolbar = null,
    Object? metadata = null,
  }) {
    return _then(_$EmbeddedResourceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      toolbar: null == toolbar
          ? _value.toolbar
          : toolbar // ignore: cast_nullable_to_non_nullable
              as ToolbarConfig,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EmbeddedResourceImpl extends _EmbeddedResource {
  const _$EmbeddedResourceImpl(
      {this.id,
      required this.resource,
      final Map<String, dynamic> attributes = const {},
      this.toolbar = const ToolbarConfig(),
      this.metadata = const Metadata()})
      : _attributes = attributes,
        super._();

  factory _$EmbeddedResourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmbeddedResourceImplFromJson(json);

  @override
  final int? id;
  @override
  final String resource;
  final Map<String, dynamic> _attributes;
  @override
  @JsonKey()
  Map<String, dynamic> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  @override
  @JsonKey()
  final ToolbarConfig toolbar;
  @override
  @JsonKey()
  final Metadata metadata;

  @override
  String toString() {
    return 'EmbeddedResource(id: $id, resource: $resource, attributes: $attributes, toolbar: $toolbar, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmbeddedResourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.toolbar, toolbar) || other.toolbar == toolbar) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, resource,
      const DeepCollectionEquality().hash(_attributes), toolbar, metadata);

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmbeddedResourceImplCopyWith<_$EmbeddedResourceImpl> get copyWith =>
      __$$EmbeddedResourceImplCopyWithImpl<_$EmbeddedResourceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmbeddedResourceImplToJson(
      this,
    );
  }
}

abstract class _EmbeddedResource extends EmbeddedResource {
  const factory _EmbeddedResource(
      {final int? id,
      required final String resource,
      final Map<String, dynamic> attributes,
      final ToolbarConfig toolbar,
      final Metadata metadata}) = _$EmbeddedResourceImpl;
  const _EmbeddedResource._() : super._();

  factory _EmbeddedResource.fromJson(Map<String, dynamic> json) =
      _$EmbeddedResourceImpl.fromJson;

  @override
  int? get id;
  @override
  String get resource;
  @override
  Map<String, dynamic> get attributes;
  @override
  ToolbarConfig get toolbar;
  @override
  Metadata get metadata;

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmbeddedResourceImplCopyWith<_$EmbeddedResourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ToolbarConfig _$ToolbarConfigFromJson(Map<String, dynamic> json) {
  return _ToolbarConfig.fromJson(json);
}

/// @nodoc
mixin _$ToolbarConfig {
  String? get titleL10n => throw _privateConstructorUsedError;
  bool get showToolbar => throw _privateConstructorUsedError;

  /// Serializes this ToolbarConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToolbarConfigCopyWith<ToolbarConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolbarConfigCopyWith<$Res> {
  factory $ToolbarConfigCopyWith(
          ToolbarConfig value, $Res Function(ToolbarConfig) then) =
      _$ToolbarConfigCopyWithImpl<$Res, ToolbarConfig>;
  @useResult
  $Res call({String? titleL10n, bool showToolbar});
}

/// @nodoc
class _$ToolbarConfigCopyWithImpl<$Res, $Val extends ToolbarConfig>
    implements $ToolbarConfigCopyWith<$Res> {
  _$ToolbarConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleL10n = freezed,
    Object? showToolbar = null,
  }) {
    return _then(_value.copyWith(
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      showToolbar: null == showToolbar
          ? _value.showToolbar
          : showToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ToolbarConfigImplCopyWith<$Res>
    implements $ToolbarConfigCopyWith<$Res> {
  factory _$$ToolbarConfigImplCopyWith(
          _$ToolbarConfigImpl value, $Res Function(_$ToolbarConfigImpl) then) =
      __$$ToolbarConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? titleL10n, bool showToolbar});
}

/// @nodoc
class __$$ToolbarConfigImplCopyWithImpl<$Res>
    extends _$ToolbarConfigCopyWithImpl<$Res, _$ToolbarConfigImpl>
    implements _$$ToolbarConfigImplCopyWith<$Res> {
  __$$ToolbarConfigImplCopyWithImpl(
      _$ToolbarConfigImpl _value, $Res Function(_$ToolbarConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleL10n = freezed,
    Object? showToolbar = null,
  }) {
    return _then(_$ToolbarConfigImpl(
      titleL10n: freezed == titleL10n
          ? _value.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      showToolbar: null == showToolbar
          ? _value.showToolbar
          : showToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ToolbarConfigImpl implements _ToolbarConfig {
  const _$ToolbarConfigImpl({this.titleL10n, this.showToolbar = false});

  factory _$ToolbarConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ToolbarConfigImplFromJson(json);

  @override
  final String? titleL10n;
  @override
  @JsonKey()
  final bool showToolbar;

  @override
  String toString() {
    return 'ToolbarConfig(titleL10n: $titleL10n, showToolbar: $showToolbar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolbarConfigImpl &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.showToolbar, showToolbar) ||
                other.showToolbar == showToolbar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, titleL10n, showToolbar);

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolbarConfigImplCopyWith<_$ToolbarConfigImpl> get copyWith =>
      __$$ToolbarConfigImplCopyWithImpl<_$ToolbarConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolbarConfigImplToJson(
      this,
    );
  }
}

abstract class _ToolbarConfig implements ToolbarConfig {
  const factory _ToolbarConfig(
      {final String? titleL10n, final bool showToolbar}) = _$ToolbarConfigImpl;

  factory _ToolbarConfig.fromJson(Map<String, dynamic> json) =
      _$ToolbarConfigImpl.fromJson;

  @override
  String? get titleL10n;
  @override
  bool get showToolbar;

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToolbarConfigImplCopyWith<_$ToolbarConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
