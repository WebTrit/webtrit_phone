extension PathUtilExtension on String {
  Uri get toUri => Uri.parse(this);

  bool get isLocalPath => toUri.host.isEmpty && toUri.path.isNotEmpty;
  bool get isPartPath => toUri.path.endsWith('.part');

  bool get isImagePath => imageExts.contains(fileExtension);
  bool get isGifImagePath => gifExts.contains(fileExtension);
  bool get isVideoPath => videoExts.contains(fileExtension);
  bool get isAudioPath => audioExts.contains(fileExtension);
  bool get isDocumentPath => documentExts.contains(fileExtension);

  bool get isVideoPartPath {
    if (isPartPath) {
      final pathWithoutPart = toUri.path.replaceAll('.part', '');
      final ext = pathWithoutPart.split('.').last;
      return videoExts.contains(ext);
    }
    return false;
  }

  bool get isAudioPartPath {
    if (isPartPath) {
      final pathWithoutPart = toUri.path.replaceAll('.part', '');
      final ext = pathWithoutPart.split('.').last;
      return audioExts.contains(ext);
    }
    return false;
  }

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

  String get fileNameWithExtension {
    final segments = toUri.pathSegments;
    if (segments.isEmpty) return '';
    return segments.last;
  }
}

const imageExts = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'];
const gifExts = ['gif'];
const videoExts = ['mp4', 'mov', 'avi', 'mkv', 'flv', 'm3u8'];
const audioExts = ['mp3', 'wav', 'aac', 'flac', 'ogg'];
const documentExts = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'];
const archiveExts = ['zip', 'rar', '7z', 'tar', 'gz'];
const executableExts = ['exe', 'msi', 'apk', 'bat', 'sh'];
