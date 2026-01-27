/// Represents the calculated feature flags for the messaging module.
class MessagingConfig {
  const MessagingConfig({
    required this.coreSmsSupport,
    required this.coreChatsSupport,
    required this.tabEnabled,
    required this.groupChatSupport,
    required this.contactInfoVideoCallSupport,
  });

  final bool coreSmsSupport;
  final bool coreChatsSupport;
  final bool tabEnabled;
  final bool groupChatSupport;
  final bool contactInfoVideoCallSupport;

  /// Check if any messaging feature is enabled.
  /// This is used to determine if messaging services should be initialized or can be skipped.
  bool get anyMessagingEnabled => (coreSmsSupport || coreChatsSupport) && tabEnabled;

  /// Check if the SMS messaging feature is enabled and supported by remote system.
  /// This is used to determine if SMS messaging UI components should be displayed or hidden.
  bool get smsPresent => coreSmsSupport && tabEnabled;

  /// Check if the internal messaging feature is enabled and supported by remote system.
  /// This is used to determine if internal messaging UI components should be displayed or hidden.
  bool get chatsPresent => coreChatsSupport && tabEnabled;
}
