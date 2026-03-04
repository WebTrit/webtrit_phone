import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class ContactsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const ContactsScreenStyle({
    super.background,
    super.appBarBlurredSurface,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  ContactsScreenStyle copyWith({
    BackgroundStyle? background,
    BlurredSurfaceStyle? appBarBlurredSurface,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return ContactsScreenStyle(
      background: background ?? this.background,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static ContactsScreenStyle merge(ContactsScreenStyle? a, ContactsScreenStyle? b) {
    if (a == null) return b ?? const ContactsScreenStyle();
    if (b == null) return a;

    return ContactsScreenStyle(
      background: b.background ?? a.background,
      appBarBlurredSurface: BlurredSurfaceStyle.merge(a.appBarBlurredSurface, b.appBarBlurredSurface),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static ContactsScreenStyle lerp(ContactsScreenStyle? a, ContactsScreenStyle? b, double t) {
    return ContactsScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      appBarBlurredSurface: BlurredSurfaceStyle.lerp(a?.appBarBlurredSurface, b?.appBarBlurredSurface, t),
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
