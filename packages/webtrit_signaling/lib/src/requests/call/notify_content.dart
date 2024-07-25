class NotifyContent {
  static const String sip200OKContent = 'SIP/2.0 200 OK';

  static bool match200OK(String content) {
    return content.startsWith(sip200OKContent);
  }
}
