/// Controls how [SignalingServicePlatform] manages its lifecycle relative to
/// the host application.
enum SignalingServiceMode {
  /// The service runs independently of the application's Activity lifecycle.
  ///
  /// The service survives app backgrounding and is restarted after device
  /// reboot. Use this when a permanent signaling connection is required.
  persistent,

  /// The service is tied to the application's Activity lifecycle.
  ///
  /// Started by the push-notification isolate when a call arrives. The service
  /// stops automatically when the user closes the app ([onTaskRemoved]), which
  /// allows the next incoming push to start a fresh service instance.
  pushBound,
}
