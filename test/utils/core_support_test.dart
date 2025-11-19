import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/core_support.dart';

import '../mocks/mocks.dart';

void main() {
  CoreSupport createCoreSupportWithFlags(List<String> flags) {
    final jsonInfo = SystemInfoBuilder(adapterSupported: flags).build();

    final mockPrefs = MockAppPreferences(systemInfoJson: jsonInfo);

    final systemInfoRepository = SystemInfoLocalRepositoryPrefsImpl(mockPrefs);

    return CoreSupportImpl(systemInfoRepository.getSystemInfo());
  }

  group('CoreSupport Feature Flags', () {
    test('returns all false when no flags provided', () {
      final cs = createCoreSupportWithFlags([]);

      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
      expect(cs.supportsSystemNotifications, isFalse);
      expect(cs.supportsSystemPushNotifications, isFalse);
    });

    test('voicemail only', () {
      final cs = createCoreSupportWithFlags([kVoicemailFeatureFlag]);

      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isFalse);
      expect(cs.supportsChats, isFalse);
    });

    test('sms only', () {
      final cs = createCoreSupportWithFlags([kSmsMessagingFeatureFlag]);

      expect(cs.supportsSms, isTrue);
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsChats, isFalse);
    });

    test('chats only', () {
      final cs = createCoreSupportWithFlags([kChatMessagingFeatureFlag]);

      expect(cs.supportsChats, isTrue);
      expect(cs.supportsVoicemail, isFalse);
      expect(cs.supportsSms, isFalse);
    });

    test('system notifications only', () {
      final cs = createCoreSupportWithFlags([kSystemNotificationsFeatureFlag]);
      expect(cs.supportsSystemNotifications, isTrue);
    });

    test('all flags -> all getters true', () {
      final cs = createCoreSupportWithFlags([
        kVoicemailFeatureFlag,
        kSmsMessagingFeatureFlag,
        kChatMessagingFeatureFlag,
      ]);

      expect(cs.supportsVoicemail, isTrue);
      expect(cs.supportsSms, isTrue);
      expect(cs.supportsChats, isTrue);
    });
  });

  group('CoreSupport Immutability', () {
    test('internal flags are immutable (defensive copy check)', () {
      final sourceFlags = <String>[kVoicemailFeatureFlag];
      final json = SystemInfoBuilder(adapterSupported: sourceFlags).build();
      final prefs = MockAppPreferences(systemInfoJson: json);
      final repo = SystemInfoLocalRepositoryPrefsImpl(prefs);
      final cs = CoreSupportImpl(repo.getSystemInfo());

      expect(cs.supportsVoicemail, isTrue, reason: 'Should be true initially');
      sourceFlags.clear();

      expect(cs.supportsVoicemail, isTrue, reason: 'Should stay true despite source list clearing');
    });
  });
}
