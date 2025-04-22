import 'embedded_payload_data.dart';

class EmbeddedData {
  EmbeddedData({
    required this.id,
    required this.uri,
    this.titleL10n,
    this.payload = const [],
  });

  /// The URI representing either a local asset file path or a remote URL.
  final int id;
  final Uri uri;
  final List<EmbeddedPayloadData> payload;

  /// The key to use to look up the localized title.
  final String? titleL10n;
}
