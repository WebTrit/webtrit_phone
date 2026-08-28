import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

import '../helpers/helpers.dart';

void main() {
  // Voicemail is placed by configuration and its data layer is shared by every
  // placement, so what runs is asked of the feature, not of one of its
  // placements. These pin that separation: the settings row keeps naming the
  // row alone, and availability answers for the whole feature.
  group('voicemail availability is asked of the feature, not of the settings row', () {
    const voicemailItem = AppConfigSettingsItem(
      enabled: true,
      type: 'voicemail',
      titleL10n: 'settings_ListViewTileTitle_voicemail',
      icon: '0xe0b7',
    );

    const themeModeItem = AppConfigSettingsItem(
      enabled: true,
      type: 'themeMode',
      titleL10n: 'settings_ListViewTileTitle_themeMode',
      icon: '0xe518',
    );

    FeatureAccess access({required bool settingsRow, required List<String> flags}) {
      return FeatureAccess.create(
        AppConfig(
          settingsConfig: AppConfigSettings(
            sections: [
              AppConfigSettingsSection(
                enabled: true,
                titleL10n: 'section',
                items: [if (settingsRow) voicemailItem, themeModeItem],
              ),
            ],
          ),
        ),
        [createMockTermsResource()],
        CoreSupportImpl(flags),
        null,
        const FeatureOverrides(),
      );
    }

    test('a configured row on a core that advertises voicemail makes it available', () {
      final featureAccess = access(settingsRow: true, flags: [kVoicemailFeatureFlag]);

      expect(featureAccess.settingsConfig.voicemailsEnabled, isTrue);
      expect(featureAccess.voicemailAvailable, isTrue);
    });

    test('a core that does not advertise voicemail keeps it unavailable', () {
      final featureAccess = access(settingsRow: true, flags: const []);

      expect(featureAccess.settingsConfig.voicemailsEnabled, isFalse);
      expect(featureAccess.voicemailAvailable, isFalse);
    });

    test('no configured placement keeps it unavailable', () {
      final featureAccess = access(settingsRow: false, flags: [kVoicemailFeatureFlag]);

      expect(featureAccess.settingsConfig.voicemailsEnabled, isFalse);
      expect(featureAccess.voicemailAvailable, isFalse);
    });

    test('the settings row stays about the row: dropping it drops the row, not the core capability', () {
      final featureAccess = access(settingsRow: false, flags: [kVoicemailFeatureFlag]);
      final flavors = featureAccess.settingsConfig.sections.expand((section) => section.items).map((i) => i.flavor);

      expect(flavors, isNot(contains(SettingsFlavor.voicemail)));
      expect(featureAccess.coreSupport.supportsVoicemail, isTrue);
    });

    test('the route guard follows availability, not the settings row', () {
      expect(
        access(settingsRow: true, flags: [kVoicemailFeatureFlag]).checker.isEnabled(FeatureFlag.voicemail),
        isTrue,
      );
      expect(
        access(settingsRow: false, flags: [kVoicemailFeatureFlag]).checker.isEnabled(FeatureFlag.voicemail),
        isFalse,
      );
    });
  });
}
