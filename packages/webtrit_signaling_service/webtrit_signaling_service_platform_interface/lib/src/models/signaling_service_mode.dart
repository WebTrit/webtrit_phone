/// Controls how [SignalingServicePlatform] manages its lifecycle relative to
/// the host application.
enum SignalingServiceMode {
  /// The service runs independently of the application's Activity lifecycle.
  ///
  /// The service survives app backgrounding and is restarted after device
  /// reboot. Use this when a permanent signaling connection is required.
  ///
  /// This is the user OPT-IN path (the `socket` incoming-call type, offered on
  /// Android 14+ only): a foreground service owns the WebSocket in its own
  /// isolate, and every signaling event crosses the isolate boundary through
  /// the hub codec as JSON - the only mode where events are serialized.
  persistent,

  /// The service is tied to the application's Activity lifecycle.
  ///
  /// Started by the push-notification isolate when a call arrives. The service
  /// stops automatically when the user closes the app ([onTaskRemoved]), which
  /// allows the next incoming push to start a fresh service instance.
  ///
  /// This is the DEFAULT path (the `pushNotification` incoming-call type):
  /// signaling runs inside the application process and its events reach
  /// consumers directly, with no serialization involved.
  pushBound,
}
