// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmbeddedResource {
  String get id;
  String get uri;
  EmbeddedResourceType get type;
  Map<String, dynamic> get attributes;
  ToolbarConfig get toolbar;
  Metadata get metadata;
  List<String> get payload;
  bool get enableConsoleLogCapture;
  String? get reconnectStrategy;

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmbeddedResourceCopyWith<EmbeddedResource> get copyWith =>
      _$EmbeddedResourceCopyWithImpl<EmbeddedResource>(
          this as EmbeddedResource, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmbeddedResource &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other.attributes, attributes) &&
            (identical(other.toolbar, toolbar) || other.toolbar == toolbar) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            (identical(
                    other.enableConsoleLogCapture, enableConsoleLogCapture) ||
                other.enableConsoleLogCapture == enableConsoleLogCapture) &&
            (identical(other.reconnectStrategy, reconnectStrategy) ||
                other.reconnectStrategy == reconnectStrategy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uri,
      type,
      const DeepCollectionEquality().hash(attributes),
      toolbar,
      metadata,
      const DeepCollectionEquality().hash(payload),
      enableConsoleLogCapture,
      reconnectStrategy);

  @override
  String toString() {
    return 'EmbeddedResource(id: $id, uri: $uri, type: $type, attributes: $attributes, toolbar: $toolbar, metadata: $metadata, payload: $payload, enableConsoleLogCapture: $enableConsoleLogCapture, reconnectStrategy: $reconnectStrategy)';
  }
}

/// @nodoc
abstract mixin class $EmbeddedResourceCopyWith<$Res> {
  factory $EmbeddedResourceCopyWith(
          EmbeddedResource value, $Res Function(EmbeddedResource) _then) =
      _$EmbeddedResourceCopyWithImpl;
  @useResult
  $Res call(
      {@IntToStringConverter() String id,
      String uri,
      EmbeddedResourceType type,
      Map<String, dynamic> attributes,
      ToolbarConfig toolbar,
      Metadata metadata,
      List<String> payload,
      bool enableConsoleLogCapture,
      String? reconnectStrategy});
}

/// @nodoc
class _$EmbeddedResourceCopyWithImpl<$Res>
    implements $EmbeddedResourceCopyWith<$Res> {
  _$EmbeddedResourceCopyWithImpl(this._self, this._then);

  final EmbeddedResource _self;
  final $Res Function(EmbeddedResource) _then;

  /// Create a copy of EmbeddedResource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uri = null,
    Object? type = null,
    Object? attributes = null,
    Object? toolbar = null,
    Object? metadata = null,
    Object? payload = null,
    Object? enableConsoleLogCapture = null,
    Object? reconnectStrategy = freezed,
  }) {
    return _then(EmbeddedResource(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _self.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as EmbeddedResourceType,
      attributes: null == attributes
          ? _self.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      toolbar: null == toolbar
          ? _self.toolbar
          : toolbar // ignore: cast_nullable_to_non_nullable
              as ToolbarConfig,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as List<String>,
      enableConsoleLogCapture: null == enableConsoleLogCapture
          ? _self.enableConsoleLogCapture
          : enableConsoleLogCapture // ignore: cast_nullable_to_non_nullable
              as bool,
      reconnectStrategy: freezed == reconnectStrategy
          ? _self.reconnectStrategy
          : reconnectStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EmbeddedResource].
extension EmbeddedResourcePatterns on EmbeddedResource {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$ToolbarConfig {
  String? get titleL10n;
  bool get showToolbar;

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToolbarConfigCopyWith<ToolbarConfig> get copyWith =>
      _$ToolbarConfigCopyWithImpl<ToolbarConfig>(
          this as ToolbarConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToolbarConfig &&
            (identical(other.titleL10n, titleL10n) ||
                other.titleL10n == titleL10n) &&
            (identical(other.showToolbar, showToolbar) ||
                other.showToolbar == showToolbar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, titleL10n, showToolbar);

  @override
  String toString() {
    return 'ToolbarConfig(titleL10n: $titleL10n, showToolbar: $showToolbar)';
  }
}

/// @nodoc
abstract mixin class $ToolbarConfigCopyWith<$Res> {
  factory $ToolbarConfigCopyWith(
          ToolbarConfig value, $Res Function(ToolbarConfig) _then) =
      _$ToolbarConfigCopyWithImpl;
  @useResult
  $Res call({String? titleL10n, bool showToolbar});
}

/// @nodoc
class _$ToolbarConfigCopyWithImpl<$Res>
    implements $ToolbarConfigCopyWith<$Res> {
  _$ToolbarConfigCopyWithImpl(this._self, this._then);

  final ToolbarConfig _self;
  final $Res Function(ToolbarConfig) _then;

  /// Create a copy of ToolbarConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleL10n = freezed,
    Object? showToolbar = null,
  }) {
    return _then(ToolbarConfig(
      titleL10n: freezed == titleL10n
          ? _self.titleL10n
          : titleL10n // ignore: cast_nullable_to_non_nullable
              as String?,
      showToolbar: null == showToolbar
          ? _self.showToolbar
          : showToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ToolbarConfig].
extension ToolbarConfigPatterns on ToolbarConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

// dart format on
