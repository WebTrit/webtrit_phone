import 'call/call_status.dart';
import 'call/registration_rejection.dart';

class SessionStatus {
  const SessionStatus({
    required this.signalingStatus,
    this.pushTokenError,
    this.registrationRejection = RegistrationRejection.unspecified,
  });

  final CallStatus signalingStatus;

  /// Non-null when the push token registration failed. Independent of [signalingStatus].
  final String? pushTokenError;

  /// Refines what [signalingStatus] is told to the user when the phone system
  /// refused the registration for a reason we recognise. It never promotes or
  /// demotes the status itself, so a harder state - no network above all -
  /// keeps its own wording.
  final RegistrationRejection registrationRejection;

  bool get hasPushTokenError => pushTokenError != null;

  /// Signaling is connected — calls can be made and received.
  /// Push token state is intentionally excluded: call functionality works
  /// regardless of push notification delivery issues.
  bool get isReady => signalingStatus == CallStatus.ready;

  /// A request for a server-side account setting has a chance of succeeding.
  ///
  /// Only two signaling states rule it out: the device has no network at all,
  /// and the session is connecting (the cached value is about to be confirmed
  /// or corrected, so a change would race the fetch; SessionStatusCubit also
  /// deliberately presents the first moments after a network recovery as
  /// connecting while the derived state still carries a stale error). A
  /// connect error or issue that actually persisted onto the screen does not:
  /// those describe the signaling channel, while the settings travel over HTTP
  /// independently of it, so the attempt is allowed and its failure is
  /// reported to the user instead of being pre-empted here.
  ///
  /// Evaluate this on the smoothed status published by SessionStatusCubit, so
  /// the toggle availability always agrees with the status text next to it.
  bool get mayReachServer => signalingStatus != CallStatus.connectivityNone && signalingStatus != CallStatus.inProgress;

  /// App is actively trying to establish connection — show a progress indicator.
  /// Push token error is excluded because it is surfaced separately via the
  /// avatar ring color, matching previous behavior where pushTokenError overrode
  /// all signaling states in the old enum.
  bool get isEstablishing =>
      !hasPushTokenError && signalingStatus != CallStatus.ready && signalingStatus != CallStatus.appUnregistered;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionStatus &&
          signalingStatus == other.signalingStatus &&
          pushTokenError == other.pushTokenError &&
          registrationRejection == other.registrationRejection;

  @override
  int get hashCode => Object.hash(signalingStatus, pushTokenError, registrationRejection);

  @override
  String toString() =>
      'SessionStatus(signalingStatus: $signalingStatus, pushTokenError: $pushTokenError, '
      'registrationRejection: $registrationRejection)';
}
