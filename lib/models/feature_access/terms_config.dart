import 'package:equatable/equatable.dart';

import '../embedded/embedded_data.dart';

/// Represents the configuration of the terms and privacy policy feature in the app.
class TermsConfig extends Equatable {
  const TermsConfig(this.configData);

  final EmbeddedData configData;

  @override
  List<Object?> get props => [configData];
}
