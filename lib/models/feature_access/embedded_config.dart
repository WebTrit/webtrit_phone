import 'package:equatable/equatable.dart';

import '../embedded/embedded_data.dart';

/// Container for processed embedded resources data.
class EmbeddedConfig extends Equatable {
  EmbeddedConfig(List<EmbeddedData> embeddedResources) : embeddedResources = List.unmodifiable(embeddedResources);

  final List<EmbeddedData> embeddedResources;

  @override
  List<Object?> get props => [embeddedResources];
}
