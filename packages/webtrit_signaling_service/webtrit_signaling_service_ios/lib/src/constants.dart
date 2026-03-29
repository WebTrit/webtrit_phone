/// Timeout for establishing a WebSocket connection.
const kSignalingClientConnectionTimeout = Duration(seconds: 10);

/// Delay between reconnect attempts after an unexpected disconnect.
const kSignalingClientReconnectDelay = Duration(seconds: 3);
