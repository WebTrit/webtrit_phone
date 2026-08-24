import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

/// The app offers the languages it was built with.
///
/// It used to decide instead: every language the app had ever had was bundled,
/// and an allowlist in the brand's configuration was intersected with it at
/// runtime. The build settles it now - a brand's build carries only the
/// languages its theme enables - so deciding again here could only disagree
/// with the files that are actually present.
void main() {
  test('offers what the build carries, whatever the configuration says', () {
    final narrowed = LocalizationMapper.map(
      const AppConfig(localization: AppConfigLocalization(enabledLanguages: ['uk'])),
    );

    expect(narrowed.supportedLocales, AppLocalizations.supportedLocales);
  });

  test('offers what the build carries when the configuration says nothing', () {
    final open = LocalizationMapper.map(const AppConfig());

    expect(open.supportedLocales, AppLocalizations.supportedLocales);
  });
}
