extension UriExtension on Uri {
  String get relativeUrl => query.isNotEmpty ? '$path?$query' : path;
}
