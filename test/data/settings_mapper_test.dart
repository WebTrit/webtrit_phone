import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() {
  group('SettingsMapper sessions gated by core version', () {
    // The sessions row is not a configurable item, so the configuration used
    // here is deliberately unrelated to it.
    const appConfig = AppConfig(
      settingsConfig: AppConfigSettings(
        sections: [
          AppConfigSettingsSection(
            enabled: true,
            titleL10n: 'section',
            items: [
              AppConfigSettingsItem(
                enabled: true,
                type: 'themeMode',
                titleL10n: 'settings_ListViewTileTitle_themeMode',
                icon: '0xe518',
              ),
            ],
          ),
        ],
      ),
    );

    WebtritSystemInfo systemInfoWithCore(Version version) => WebtritSystemInfo(
      core: CoreInfo(version: version),
      postgres: PostgresInfo(),
    );

    SettingsConfig mapped(WebtritSystemInfo? systemInfo) {
      return SettingsMapper.map(
        appConfig,
        const [],
        CoreSupportImpl(const []),
        TermsConfig(
          EmbeddedData(
            id: 'terms',
            uri: Uri.https('webtrit.com', '/terms'),
            reconnectStrategy: ReconnectStrategy.softReload,
          ),
        ),
        systemInfo,
      );
    }

    test('core that tracks sessions enables the sessions row', () {
      expect(mapped(systemInfoWithCore(Version(0, 35, 0))).sessionsEnabled, isTrue);
    });

    test('older core disables the sessions row', () {
      expect(mapped(systemInfoWithCore(Version(0, 34, 0))).sessionsEnabled, isFalse);
    });

    test('unknown system info disables the sessions row', () {
      expect(mapped(null).sessionsEnabled, isFalse);
    });

    test('the sessions row does not depend on the configured items', () {
      final config = mapped(systemInfoWithCore(Version(0, 35, 0)));
      final flavors = config.sections.expand((section) => section.items).map((item) => item.flavor).toList();

      expect(flavors, equals([SettingsFlavor.themeMode]));
      expect(config.sessionsEnabled, isTrue);
    });
  });
}
