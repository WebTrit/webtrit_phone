enum LocalPushActionType { tap, dismiss, other }

class AppLocalPushAction {
  final int id;
  final LocalPushActionType type;
  final Map<String, dynamic> payload;

  AppLocalPushAction({required this.id, required this.type, required this.payload});

  @override
  String toString() {
    return 'AppLocalPushAction{id: $id, type: $type, payload: $payload}';
  }
}
