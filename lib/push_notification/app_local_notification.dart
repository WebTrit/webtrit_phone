class AppLocalNotification {
  final int id;
  final String title;
  final String body;
  final Map<String, String>? payload;

  AppLocalNotification(this.id, this.title, this.body, {this.payload});

  @override
  String toString() {
    return 'AppLocalNotification{id: $id, title: $title, body: $body, payload: $payload}';
  }
}
