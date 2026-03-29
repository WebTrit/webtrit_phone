/// [IsolateNameServer] port name used by [SignalingHub] to expose its
/// [SendPort] to other isolates.
const kSignalingHubPortName = 'webtrit.signaling.hub';

/// Timeout for establishing a WebSocket connection.
const kSignalingClientConnectionTimeout = Duration(seconds: 10);

/// Delay between reconnect attempts after an unexpected disconnect.
const kSignalingClientReconnectDelay = Duration(seconds: 3);
