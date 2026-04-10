import 'package:freezed_annotation/freezed_annotation.dart';

import '../common/common.dart';
import '../features_config/metadata.dart';

part 'image_source.freezed.dart';

part 'image_source.g.dart';

/// Represents a reference to an image resource that can come
/// from different environments: backend storage, local assets,
/// remote URLs, or build-time generated files.
///
/// # Typical fields
/// - [id]: backend asset ID, mandatory for server-side references.
/// - [uri]: unified location for the resource, can be `asset://`, `https://`, `file://`, etc.
/// - [ref]: semantic type of reference (defaults to "asset").
/// - [metadata]: freeform map for build-time/tooling hints (CLI, pipelines, etc.).
///
/// # Use cases:
///
/// ## 1. Preview in Configurator (Browser/UI)
/// - `id` comes from backend.
/// - `uri` is a **signed URL** with TTL, generated server-side.
/// - UI can render the image directly from `uri`.
///
/// ## 2. Production Build (CLI / App bundle)
/// - CLI downloads remote `uri` and replaces it with a local `file://` or `asset://` path.
/// - `id` remains for traceability, but `uri` points to bundled asset.
///
/// ## 3. Remote Only (do not bundle locally)
/// - Some resources may stay remote (e.g., CDN branding assets).
/// - Marked with `metadata.preserveRemote = true`.
/// - CLI should **not replace** the URL with local path.
///
/// ## 4. Local file reference (during development)
/// - A developer can point to a file in the local FS with `file://`.
/// - Not recommended for production, but useful in dev/debug tooling.
///
/// TODO: Rename ImageSource → ImageDescriptor to reflect that it now describes both source
/// and rendering metadata, not just URI.
@freezed
@JsonSerializable(explicitToJson: true)
class ImageSource with _$ImageSource {
  const ImageSource({
    /// Backend asset ID (unique identifier in storage).
    this.id,

    /// Unified URI pointing to the resource.
    this.uri,

    /// Semantic type of reference (default = "asset").
    @JsonKey(name: r'$ref') this.ref = 'asset',

    /// Optional rendering specification (scale, padding, etc.).
    this.render,

    /// Freeform metadata for build tools / CLI / pipelines.
    this.metadata = const Metadata(),
  });

  /// Backend asset ID (unique identifier in storage).
  @override
  final String? id;

  /// Unified URI pointing to the resource.
  @override
  final String? uri;

  /// Semantic type of reference (default = "asset").
  @override
  final String ref;

  /// Rendering specification (scale, padding, etc.).
  @override
  final ImageRenderSpec? render;

  /// Freeform metadata for CLI or pipeline tools.
  @override
  final Metadata metadata;

  static const _preserveRemoteKey = 'preserveRemote';

  /// Whether the remote URI should be preserved (not replaced locally).
  bool get preserveRemote => metadata.getBool(_preserveRemoteKey) == true;

  factory ImageSource.fromJson(Map<String, Object?> json) => _$ImageSourceFromJson(json);

  Map<String, Object?> toJson() => _$ImageSourceToJson(this);
}

/// Describes rendering options for an image resource.
/// Includes [scale], [padding], [alignment] and [fit].
@freezed
@JsonSerializable(explicitToJson: true)
class ImageRenderSpec with _$ImageRenderSpec {
  const ImageRenderSpec({
    /// The scale factor applied during rendering.
    this.scale,

    /// Padding around the image inside its container (e.g., top, right, bottom, left insets).
    this.padding,

    /// Alignment within the container (e.g., "center", "left", "topRight").
    this.alignment,

    /// How the image should be inscribed into the available space.
    /// Corresponds to the `BoxFit` enum (e.g. `contain`, `cover`, `fill`,
    /// `fitWidth`, `fitHeight`, `none`, `scaleDown`). Factories parse and
    /// serialize this value to/from strings when converting JSON.
    this.fit,
  });

  @override
  final double? scale;

  @override
  final PaddingConfig? padding;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final AlignmentConfig? alignment;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final BoxFitConfig? fit;

  factory ImageRenderSpec.fromJson(Map<String, Object?> json) => _$ImageRenderSpecFromJson(json);

  Map<String, Object?> toJson() => _$ImageRenderSpecToJson(this);
}
