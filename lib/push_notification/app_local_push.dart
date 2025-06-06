class AppLocalPush {
  final int id;
  final String title;
  final String body;
  final Map<String, String>? payload;

  AppLocalPush(this.id, this.title, this.body, {this.payload});

  @override
  String toString() {
    return 'AppLocalPush{id: $id, title: $title, body: $body, payload: $payload}';
  }
}
