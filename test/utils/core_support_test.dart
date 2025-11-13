import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/core_support.dart';

Future<void> main() async {
  final appPreferencesPure = await AppPreferencesPure.init();
  final SystemInfoLocalRepository systemInfoLocalRepository = SystemInfoLocalRepositoryPrefsImpl(appPreferencesPure);

  final cs = CoreSupportImpl(systemInfoLocalRepository);

  group('CoreSupport.fromFlags', () {
    test('returns all false when no flags provided', () {
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);

      // sanity for has()
      expect(cs.supportCustomPresence('unknown-flag'), isFalse);
    });

    test('voicemail only', () {
      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);

      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isFalse);
    });

    test('sms only', () {
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isTrue);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('chats only', () {
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isTrue);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('system notifications only', () {
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isTrue);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('system push notifications only', () {
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isTrue);
    });

    test('all flags -> all getters true', () {
      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isTrue);
      expect(cs.supportsChats, isTrue);
      expect(cs.supportsSystemNotifications, isTrue);
      expect(cs.supportsSystemPushNotifications, isTrue);
    });

    test('internal flags are immutable (defensive copy)', () {
      final source = <String>{kVoicemailFeatureFlag};

      // mutate the original set after creating CoreSupport
      source.add(kSmsMessagingFeatureFlag);

      // CoreSupport should NOT see the mutation
      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isFalse);
    });
  });
}
