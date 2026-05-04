import 'call/call_status.dart';

class SessionStatus {
  const SessionStatus({required this.signalingStatus, this.pushTokenError});

  final CallStatus signalingStatus;

  /// Non-null when the push token registration failed. Independent of [signalingStatus].
  final String? pushTokenError;

  bool get hasPushTokenError => pushTokenError != null;

  /// Signaling is ready and push token is operational — app is fully connected.
  bool get isReady => signalingStatus == CallStatus.ready && !hasPushTokenError;

  /// App is actively trying to establish connection — show a progress indicator.
  bool get isEstablishing =>
      !hasPushTokenError && signalingStatus != CallStatus.ready && signalingStatus != CallStatus.appUnregistered;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionStatus && signalingStatus == other.signalingStatus && pushTokenError == other.pushTokenError;

  @override
  int get hashCode => Object.hash(signalingStatus, pushTokenError);
}
