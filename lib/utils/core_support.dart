import 'package:webtrit_phone/app/constants.dart';

import 'package:webtrit_phone/models/system_info/system_info.dart';

/// Abstraction for checking core system feature support.
abstract class CoreSupport {
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

  /// Check if the SIP presence feature is supported by remote system.
  bool get supportsSipPresence;
}

class CoreSupportImpl implements CoreSupport {
  CoreSupportImpl(this.webtritSystemInfo);

  final WebtritSystemInfo? Function()? webtritSystemInfo;

  /// Warning: do not refactor this into a value; it must remain a getter that is evaluated on each call.
  Set<String> get _flags => {...?webtritSystemInfo?.call()?.adapter?.supported};

  bool _has(String flag) => _flags.contains(flag);

  @override
  bool get supportsVoicemail => _has(kVoicemailFeatureFlag);

  @override
  bool get supportsSms => _has(kSmsMessagingFeatureFlag);

  @override
  bool get supportsChats => _has(kChatMessagingFeatureFlag);

  @override
  bool get supportsSystemNotifications => _has(kSystemNotificationsFeatureFlag);

  @override
  bool get supportsSystemPushNotifications => _has(kSystemNotificationsPushFeatureFlag);

  @override
  bool get supportsSipPresence => _has(kSipPresenceFeatureFlag);
}
