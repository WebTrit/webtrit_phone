import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

/// How the app learns about an incoming call - and, as a consequence, where the
/// signaling connection lives on Android.
///
/// The two values are NOT equal alternatives:
///
/// - [pushNotification] is the DEFAULT on every platform
///   (`NetworkState.incomingCallType` falls back to it when nothing is
///   selected). The signaling client runs inside the application process, and
///   its events reach the call logic directly - no serialization is involved.
/// - [socket] is an OPT-IN chosen by the user in Settings > Network, offered on
///   Android 14+ only (see `NetworkCubit._buildIncomingCallTypesRemainder`).
///   A foreground service owns a persistent WebSocket in a separate isolate,
///   and every signaling event crosses the isolate boundary through the hub
///   codec as JSON - the only configuration where signaling events are
///   serialized at all.
///
/// Keep the distinction in mind when reasoning about the signaling pipeline:
/// conclusions drawn from the hub/FGS code path apply only to the opt-in
/// [socket] mode, not to the app at large.
enum IncomingCallType {
  /// Incoming calls arrive via push notifications; the signaling client lives
  /// in the application process. The default on every platform.
  pushNotification,

  /// Incoming calls arrive over a persistent WebSocket owned by a foreground
  /// service in its own isolate. User opt-in, Android 14+ only.
  socket;

  bool get isPushNotification => this == pushNotification;

  bool get isSocket => this == socket;

  SignalingServiceMode toSignalingServiceMode() => switch (this) {
    IncomingCallType.pushNotification => SignalingServiceMode.pushBound,
    IncomingCallType.socket => SignalingServiceMode.persistent,
  };
}
