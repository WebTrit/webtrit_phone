class NotifyContent {
  // ignore: constant_identifier_names
  static const String _200OK = 'SIP/2.0 200 OK';

  static bool match200OK(String content) {
    return content.startsWith(_200OK);
  }
}
