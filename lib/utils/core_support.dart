import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';

/// Abstraction for checking core system feature support.
abstract class CoreSupport {
  /// Returns true if the given feature flag is supported.
  bool has(String flag);

  /// Check if the voicemail feature is supported by remote system.
  bool get supportsVoicemail;

  /// Check if the SMS messaging feature is supported by remote system.
  bool get supportsSms;

  /// Check if the internal messaging feature is supported by remote system.
  bool get supportsChats;

  /// Check if the core system supports system notifications and push sending.
  bool get supportsSystemNotifications;

  /// Check if the system push notifications feature is supported by remote system.
  bool get supportsSystemPushNotifications;

  /// Factory for real implementation backed by [AppPreferences].
  factory CoreSupport.fromPrefs(AppPreferences prefs) {
    final flags = {...?prefs.getSystemInfo()?.adapter?.supported};
    return CoreSupport.fromFlags(flags);
  }

  /// Factory for an implementation backed by an explicit set of flags.
  /// Useful for tests and previews.
  factory CoreSupport.fromFlags(Set<String> flags) => _CoreSupportImpl(flags);
}

class _CoreSupportImpl implements CoreSupport {
  _CoreSupportImpl(Set<String> flags) : _flags = Set.unmodifiable(flags);

  final Set<String> _flags;

  @override
  bool has(String flag) => _flags.contains(flag);

  @override
  bool get supportsVoicemail => has(kVoicemailFeatureFlag);

  @override
  bool get supportsSms => has(kSmsMessagingFeatureFlag);

  @override
  bool get supportsChats => has(kChatMessagingFeatureFlag);

  @override
  bool get supportsSystemNotifications => has(kSystemNotificationsFeatureFlag);

  @override
  bool get supportsSystemPushNotifications => has(kSystemNotificationsPushFeatureFlag);
}
