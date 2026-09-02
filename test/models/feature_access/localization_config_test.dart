import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

/// The app offers the languages it was built with, and has nothing to decide.
///
/// A brand's languages are settled before the app exists: the build carries
/// only the ones its brand enables. The configuration used to name them too,
/// and reading that at runtime could only disagree with the files on disk - a
/// language present in the build but missing from the list was hidden, one
/// named in the list but absent from the build was silently ignored.
void main() {
  test('offers exactly what the build carries', () {
    expect(LocalizationMapper.map().supportedLocales, AppLocalizations.supportedLocales);
  });
}
