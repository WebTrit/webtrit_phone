/// [IsolateNameServer] port name used by [SignalingHub] to expose its
/// [SendPort] to other isolates.
const kSignalingHubPortName = 'webtrit.signaling.hub';

/// [IsolateNameServer] port name registered by the push isolate in direct
/// push-bound mode. The Activity sends null to this port on [SignalingConnected]
/// so the push isolate can close early without waiting for the 20-second timeout.
const kPushHandoffPortName = 'webtrit.signaling.push_handoff';

/// Timeout for establishing a WebSocket connection.
const kSignalingClientConnectionTimeout = Duration(seconds: 10);

/// Delay between reconnect attempts after an unexpected disconnect.
const kSignalingClientReconnectDelay = Duration(seconds: 3);
