import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class ContactsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const ContactsScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  ContactsScreenStyle copyWith({BackgroundStyle? background, ThemeMode? contentThemeOverride, bool? applyToAppBar}) {
    return ContactsScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static ContactsScreenStyle merge(ContactsScreenStyle? a, ContactsScreenStyle? b) {
    if (a == null) return b ?? const ContactsScreenStyle();
    if (b == null) return a;

    return ContactsScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static ContactsScreenStyle lerp(ContactsScreenStyle? a, ContactsScreenStyle? b, double t) {
    return ContactsScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride))
      ..add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
  }
}
