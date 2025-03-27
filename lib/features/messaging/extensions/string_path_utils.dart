extension PathUtilExtension on String {
  Uri get toUri => Uri.parse(this);

  bool get isImagePath {
    final ext = toUri.path.split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(ext);
  }

  bool get isLocalPath => toUri.host.isEmpty && toUri.path.isNotEmpty;

  String get fileName {
    final segments = toUri.pathSegments;
    if (segments.isEmpty) return '';
    return segments.last.split('.').first;
  }

  String get fileExtension {
    final segments = toUri.pathSegments;
    if (segments.isEmpty) return '';
    return segments.last.split('.').last;
  }
}
