enum LocalNotificationActionType { tap, dismiss, other }

class AppLocalNotificationAction {
  final int id;
  final LocalNotificationActionType type;
  final Map<String, dynamic> payload;

  AppLocalNotificationAction({
    required this.id,
    required this.type,
    required this.payload,
  });

  @override
  String toString() {
    return 'AppLocalNotificationAction{id: $id, type: $type, payload: $payload}';
  }
}
