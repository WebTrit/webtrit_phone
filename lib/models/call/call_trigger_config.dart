/// Configuration that defines how incoming calls can be triggered.
class CallTriggerConfig {
  const CallTriggerConfig({
    this.primaryTrigger = IncomingCallTriggerType.pushNotification,
    this.availableTriggers = IncomingCallTriggerType.values,
    this.smsFallback = const SmsFallbackTriggerConfig(),
  });

  /// The main mechanism used to receive incoming calls.
  final IncomingCallTriggerType primaryTrigger;

  /// The list of supported trigger mechanisms available in this build or environment.
  final List<IncomingCallTriggerType> availableTriggers;

  /// Configuration for SMS-based fallback triggering.
  final SmsFallbackTriggerConfig smsFallback;
}

/// Represents different mechanisms for receiving incoming calls.
enum IncomingCallTriggerType {
  /// Trigger via push notifications.
  pushNotification,

  /// Persistent connection (e.g., WebSocket or SIP) for real-time triggering.
  persistentConnection,
}

/// Configuration related to SMS-based fallback triggering.
class SmsFallbackTriggerConfig {
  const SmsFallbackTriggerConfig({
    this.enabled = false,
    this.available = false,
  });

  /// Whether the SMS fallback mechanism is currently enabled by the user or system.
  final bool enabled;

  /// Whether the SMS fallback option should be available to the user in the UI.
  final bool available;
}
