extension UriExtension on Uri {
  /// The URI without its scheme, in both spellings a resource can be written
  /// in: `scheme:payload` and `scheme://payload`.
  ///
  /// Note what the two spellings cost. Everything after `//` is the authority,
  /// which is case-folded when the URI is parsed, so a payload written there
  /// loses its capitals before this ever runs and cannot be recovered. A
  /// payload that is case-sensitive - a base64 blob, an asset path with
  /// capitals - belongs after a single colon, where it stays a path.
  Uri removeScheme() {
    final uriString = toString().replaceFirst(RegExp(r'^[a-zA-Z]+:(//)?'), '');
    return Uri.parse(uriString);
  }
}
