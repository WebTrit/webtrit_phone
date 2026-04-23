class AppLocalPush {
  final int id;
  final String title;
  final String body;
  final Map<String, String>? payload;

  AppLocalPush(this.id, this.title, this.body, {this.payload});

  factory AppLocalPush.missedCall(String callId, String callerName) {
    return AppLocalPush(
      callId.hashCode,
      // TODO: Add localization
      'Missed Call',
      callerName,
      payload: {'callId': callId, 'type': 'missed_call'},
    );
  }

  @override
  String toString() {
    return 'AppLocalPush{id: $id, title: $title, body: $body, payload: $payload}';
  }
}
