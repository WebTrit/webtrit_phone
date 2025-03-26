extension PathUtilExtension on String {
  bool get isImagePath {
    final ext = split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(ext);
  }
}
