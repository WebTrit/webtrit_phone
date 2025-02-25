import 'package:webtrit_appearance_theme/models/models.dart';

class EmbeddedResourceMissingException implements Exception {
  EmbeddedResourceMissingException({
    required this.message,
    required this.embeddedResourceType,
  });

  final String message;
  final EmbeddedResourceType embeddedResourceType;

  @override
  String toString() {
    return 'EmbeddedResourceMissingException: $message for $embeddedResourceType';
  }
}
