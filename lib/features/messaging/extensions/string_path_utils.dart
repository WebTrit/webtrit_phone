extension PathUtilExtension on String {
  Uri get toUri => Uri.parse(this);

  bool get isImagePath {
    final ext = toUri.path.split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(ext);
  }

  bool get isVideoPath {
    final ext = toUri.path.split('.').last;
    return ['mp4', 'mov', 'avi', 'mkv', 'flv', 'm3u8'].contains(ext);
  }

  bool get isAudioPath {
    final ext = toUri.path.split('.').last;
    return ['mp3', 'wav', 'aac', 'flac', 'ogg'].contains(ext);
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
