extension UriExtension on Uri {
  Uri removeScheme() {
    final uriString = toString().replaceFirst(RegExp(r'^[a-zA-Z]+://'), '');
    return Uri.parse(uriString);
  }
}
