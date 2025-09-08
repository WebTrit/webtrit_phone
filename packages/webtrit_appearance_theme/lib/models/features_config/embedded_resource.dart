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
/// - [reconnectStrategy]: An optional string that defines the strategy to apply when the network
@freezed
class EmbeddedResource with _$EmbeddedResource {
  const EmbeddedResource._();

  @JsonSerializable(explicitToJson: true)
  const factory EmbeddedResource({
    /// TODO: Migration workaround — accepts both int and string IDs.
    /// Remove [IntToStringConverter] once all JSONs use string IDs only.
    @IntToStringConverter() required String id,
    required String uri,
    @Default(EmbeddedResourceType.unknown) EmbeddedResourceType type,
    @Default({}) Map<String, dynamic> attributes,
    @Default(ToolbarConfig()) ToolbarConfig toolbar,
    @Default(Metadata()) Metadata metadata,

    /// Optional payload that can be used to pass additional data to the embedded resource.
    @Default([]) List<String> payload,

    /// Enables capturing `console.*` logs from inside the WebView
    @Default(false) bool enableConsoleLogCapture,

    /// Strategy to apply when network reconnects
    String? reconnectStrategy,
  }) = _EmbeddedResource;

  factory EmbeddedResource.fromJson(Map<String, dynamic> json) => _$EmbeddedResourceFromJson(json);

  /// Safely parses `resource` to a `uri`, returning `null` if invalid
  Uri? get uriOrNull => Uri.tryParse(uri);

  /// A globally consistent metadata key used to associate asset IDs
  static const String metadataAssetId = 'id';

  /// A globally consistent metadata key used to associate asset sources
  static const String metadataAssetSource = 'source';
}

/// Configuration for the toolbar associated with an embedded resource.
///
/// - [titleL10n]: The localized title for the toolbar. This field can be used to provide a dynamic or translated title.
/// - [showToolbar]: A boolean flag that determines whether the toolbar should be visible. Defaults to `false`.
@freezed
class ToolbarConfig with _$ToolbarConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ToolbarConfig({
    String? titleL10n,
    @Default(false) bool showToolbar,
  }) = _ToolbarConfig;

  factory ToolbarConfig.fromJson(Map<String, dynamic> json) => _$ToolbarConfigFromJson(json);
}
