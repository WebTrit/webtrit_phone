class EmbeddedData {
  EmbeddedData({
    required this.id,
    required this.uri,
    this.titleL10n,
  });

  /// The URI representing either a local asset file path or a remote URL.
  final int id;
  final Uri uri;

  /// The key to use to look up the localized title.
  final String? titleL10n;
}
