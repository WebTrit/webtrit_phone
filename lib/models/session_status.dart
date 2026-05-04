import 'call/call_status.dart';

class SessionStatus {
  const SessionStatus({required this.signalingStatus, this.pushTokenError});

  final CallStatus signalingStatus;

  /// Non-null when the push token registration failed. Independent of [signalingStatus].
  final String? pushTokenError;

  bool get hasPushTokenError => pushTokenError != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionStatus && signalingStatus == other.signalingStatus && pushTokenError == other.pushTokenError;

  @override
  int get hashCode => Object.hash(signalingStatus, pushTokenError);
}
