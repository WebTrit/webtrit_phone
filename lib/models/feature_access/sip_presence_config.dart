/// Configuration for the SIP presence feature.
class SipPresenceConfig {
  const SipPresenceConfig({required this.sipPresenceSupport});

  /// Whether the SIP presence feature is enabled and supported by the remote system.
  final bool sipPresenceSupport;
}
