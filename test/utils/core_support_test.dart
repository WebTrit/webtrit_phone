import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  group('CoreSupport.fromFlags', () {
    test('returns all false when no flags provided', () {
      final cs = CoreSupport.fromFlags(<String>{});

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);

      // sanity for has()
      expect(cs.has('unknown-flag'), isFalse);
    });

    test('voicemail only', () {
      final cs = CoreSupport.fromFlags({kVoicemailFeatureFlag});

      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);

      expect(cs.has(kVoicemailFeatureFlag), isTrue);
      expect(cs.has(kSmsMessagingFeatureFlag), isFalse);
    });

    test('sms only', () {
      final cs = CoreSupport.fromFlags({kSmsMessagingFeatureFlag});

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isTrue);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('chats only', () {
      final cs = CoreSupport.fromFlags({kChatMessagingFeatureFlag});

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isTrue);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('system notifications only', () {
      final cs = CoreSupport.fromFlags({kSystemNotificationsFeatureFlag});

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isTrue);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('system push notifications only', () {
      final cs = CoreSupport.fromFlags({kSystemNotificationsPushFeatureFlag});

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isTrue);
    });

    test('all flags -> all getters true', () {
      final cs = CoreSupport.fromFlags({
        kVoicemailFeatureFlag,
        kSmsMessagingFeatureFlag,
        kChatMessagingFeatureFlag,
        kSystemNotificationsFeatureFlag,
        kSystemNotificationsPushFeatureFlag,
      });

      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isTrue);
      expect(cs.supportsChats, isTrue);
      expect(cs.supportsSystemNotifications, isTrue);
      expect(cs.supportsSystemPushNotifications, isTrue);
    });

    test('internal flags are immutable (defensive copy)', () {
      final source = <String>{kVoicemailFeatureFlag};
      final cs = CoreSupport.fromFlags(source);

      // mutate the original set after creating CoreSupport
      source.add(kSmsMessagingFeatureFlag);

      // CoreSupport should NOT see the mutation
      expect(cs.has(kVoicemailFeatureFlag), isTrue);
      expect(cs.has(kSmsMessagingFeatureFlag), isFalse);
    });
  });
}
