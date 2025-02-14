import 'package:freezed_annotation/freezed_annotation.dart';

import 'metadata.dart';

part 'embedded_resource.freezed.dart';

part 'embedded_resource.g.dart';

@freezed
class EmbeddedResource with _$EmbeddedResource {
  const EmbeddedResource._();

  @JsonSerializable(explicitToJson: true)
  const factory EmbeddedResource({
    int? id,
    required String resource,
    @Default({}) Map<String, dynamic> attributes,
    @Default(ToolbarConfig()) ToolbarConfig toolbar,
    @Default(Metadata()) Metadata metadata,
  }) = _EmbeddedResource;

  factory EmbeddedResource.fromJson(Map<String, dynamic> json) => _$EmbeddedResourceFromJson(json);

  /// Safely parses `resource` to a `uri`, returning `null` if invalid
  Uri? get uri => Uri.tryParse(resource);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceUrl = 'resourceUrl';

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceId = 'resourceId';

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataResourceURI = 'resourceURI';
}

@freezed
class ToolbarConfig with _$ToolbarConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ToolbarConfig({
    String? titleL10n,
    @Default(false) bool showToolbar,
  }) = _ToolbarConfig;

  factory ToolbarConfig.fromJson(Map<String, dynamic> json) => _$ToolbarConfigFromJson(json);
}
