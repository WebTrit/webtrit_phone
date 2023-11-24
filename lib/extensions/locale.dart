import 'package:flutter/widgets.dart';

import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension LocaleExtension on Locale {
  static const Locale defaultNull = Locale.fromSubtags(languageCode: 'und', scriptCode: 'und', countryCode: 'und');

  static Locale fromLanguageTag(String languageTag) {
    final subtags = List<String?>.from(languageTag.split('-'));
    if (subtags.length == 1) {
      return Locale(subtags[0]!);
    } else if (subtags.length == 2) {
      return Locale(subtags[0]!, subtags[1]);
    } else if (subtags.length == 3) {
      return Locale.fromSubtags(languageCode: subtags[0]!, scriptCode: subtags[1], countryCode: subtags[2]);
    } else {
      throw ArgumentError();
    }
  }

  bool get isDefaultNull => this == defaultNull;
}

extension LocaleL10n on Locale {
  String l10n(BuildContext context) {
    if (this == LocaleExtension.defaultNull) {
      return context.l10n.locale_default;
    } else {
      final locale = LocaleNames.of(context)!.nameOf(languageCode);
      return locale ?? toString();
    }
  }
}
