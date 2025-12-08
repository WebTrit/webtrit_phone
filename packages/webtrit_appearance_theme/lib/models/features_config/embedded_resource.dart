import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converters/converters.dart';
import 'embedded_resource_type.dart';
import 'metadata.dart';

part 'embedded_resource.freezed.dart';

part 'embedded_resource.g.dart';

/// Represents an embedded resource, which includes a URI, type, attributes, toolbar, and metadata.
///
/// - [id]: A unique identifier for the resource, necessary for linking the resource to other features or components.
/// - [uri]: A required URI that points to the embedded resource, enabling navigation to it.
/// - [type]: The type of the resource, which helps determine how the resource is handled or displayed (e.g., web, file, etc.). The default is `EmbeddedResourceType.unknown`.
/// - [attributes]: Optional attributes that can store additional information related to the resource, such as configuration or metadata.
/// - [toolbar]: Optional toolbar configuration for the resource, including title and visibility. The default is an empty configuration.
/// - [metadata]: Optional metadata associated with the resource, which can store custom data relevant to the resource's context.
/// - [payload]: An optional list of strings that can be used to pass additional data to the embedded resource, such as parameters or identifiers.
/// - [enableConsoleLogCapture]: A boolean flag that enables capturing `console.*` logs from inside the WebView, useful for debugging or logging purposes. The default is `false`.
/// - [reconnectStrategy]: An optional string that defines the strategy to apply when the network reconnects.
@freezed
@JsonSerializable(explicitToJson: true)
class EmbeddedResource with _$EmbeddedResource {
  /// Creates an [EmbeddedResource].
  const EmbeddedResource({
    /// TODO: Migration workaround — accepts both int and string IDs.
    /// Remove [IntToStringConverter] once all JSONs use string IDs only.
    @IntToStringConverter() required this.id,
    required this.uri,
    this.type = EmbeddedResourceType.unknown,
    this.attributes = const {},
    this.toolbar = const ToolbarConfig(),
    this.metadata = const Metadata(),

    /// Optional payload that can be used to pass additional data to the embedded resource.
    this.payload = const [],

    /// Enables capturing `console.*` logs from inside the WebView
    this.enableConsoleLogCapture = false,

    /// Strategy to apply when network reconnects
    this.reconnectStrategy,
  });

  /// Unique identifier for this resource.
  @override
  @IntToStringConverter()
  final String id;

  /// The URI that points to the embedded resource.
  @override
  final String uri;

  /// The type of the resource (e.g., web, file, etc.).
  @override
  final EmbeddedResourceType type;

  /// Optional key–value attributes associated with the resource.
  @override
  final Map<String, dynamic> attributes;

  /// Toolbar configuration for the resource.
  @override
  final ToolbarConfig toolbar;

  /// Metadata attached to this resource.
  @override
  final Metadata metadata;

  /// Optional payload data to pass to the embedded resource.
  @override
  final List<String> payload;

  /// Whether to capture `console.*` logs from inside the WebView.
  @override
  final bool enableConsoleLogCapture;

  /// Strategy applied when network reconnects.
  @override
  final String? reconnectStrategy;

  /// Safely parses `resource` to a `uri`, returning `null` if invalid.
  Uri? get uriOrNull => Uri.tryParse(uri);

  /// A globally consistent metadata key used to associate asset IDs.
  static const String metadataAssetId = 'id';

  /// A globally consistent metadata key used to associate asset sources.
  static const String metadataAssetSource = 'source';

  factory EmbeddedResource.fromJson(Map<String, Object?> json) => _$EmbeddedResourceFromJson(json);

  Map<String, Object?> toJson() => _$EmbeddedResourceToJson(this);
}

/// Configuration for the toolbar associated with an embedded resource.
///
/// - [titleL10n]: The localized title for the toolbar. This field can be used to provide a dynamic or translated title.
/// - [showToolbar]: A boolean flag that determines whether the toolbar should be visible. Defaults to `false`.
@freezed
@JsonSerializable(explicitToJson: true)
class ToolbarConfig with _$ToolbarConfig {
  /// Creates a [ToolbarConfig].
  const ToolbarConfig({this.titleL10n, this.showToolbar = false});

  /// The localized title for the toolbar.
  @override
  final String? titleL10n;

  /// Whether the toolbar should be visible.
  @override
  final bool showToolbar;

  factory ToolbarConfig.fromJson(Map<String, Object?> json) => _$ToolbarConfigFromJson(json);

  Map<String, Object?> toJson() => _$ToolbarConfigToJson(this);
}
