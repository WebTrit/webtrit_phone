import 'package:freezed_annotation/freezed_annotation.dart';

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
/// ```json
/// {
///   "id": "xxxx",
///   "uri": "https://firebasestorage.googleapis.com/.../logo.svg?token=abcd"
/// }
/// ```
///
/// ## 2. Production Build (CLI / App bundle)
/// - CLI downloads remote `uri` and replaces it with a local `file://` or `asset://` path.
/// - `id` remains for traceability, but `uri` points to bundled asset.
///
/// ```json
/// {
///   "id": "xxxx",
///   "uri": "asset://assets/logo.svg"
/// }
/// ```
///
/// ## 3. Remote Only (do not bundle locally)
/// - Some resources may stay remote (e.g., CDN branding assets).
/// - Marked with `metadata.preserveRemote = true`.
/// - CLI should **not replace** the URL with local path.
///
/// ```json
/// {
///   "id": "xxxx",
///   "uri": "https://cdn.example.com/logo.svg",
///   "metadata": { "preserveRemote": true }
/// }
/// ```
///
/// ## 4. Local file reference (during development)
/// - A developer can point to a file in the local FS with `file://`.
/// - Not recommended for production, but useful in dev/debug tooling.
///
/// ```json
/// {
///   "id": "local123",
///   "uri": "file:///Users/me/project/assets/logo.svg"
/// }
/// ```
@freezed
class ImageSource with _$ImageSource {
  const ImageSource._();

  const factory ImageSource({
    /// Backend asset ID (unique identifier in storage).
    /// Required for backend-side linking, optional in dev or local-only assets.
    String? id,

    /// Unified URI pointing to the resource.
    /// Examples:
    /// - `asset://assets/logo.svg` (bundled asset inside the app)
    /// - `https://...` (signed URL or CDN reference)
    /// - `file://...` (local file reference, dev only)
    String? uri,

    /// Semantic type of reference (default = "asset").
    /// Can be extended in future (e.g., "cdn", "inline").
    @JsonKey(name: r'$ref') @Default('asset') String ref,

    /// Freeform metadata for build tools / CLI / pipelines.
    /// Example: `{ "preserveRemote": true }`
    @Default(Metadata()) Metadata metadata,
  }) = _ImageSource;

  factory ImageSource.fromJson(Map<String, dynamic> json) => _$ImageSourceFromJson(json);

  /// Whether the remote URI should be preserved
  /// (i.e., not downloaded and replaced with a local path).
  bool get preserveRemote => metadata.getBool('preserveRemote') == true;
}
