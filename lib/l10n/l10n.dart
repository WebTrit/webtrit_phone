import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.dart';

export 'package:webtrit_phone/l10n/app_localizations.g.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
