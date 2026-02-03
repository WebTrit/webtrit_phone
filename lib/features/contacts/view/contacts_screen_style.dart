import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

class ContactsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const ContactsScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ContentThemeOverride? contentThemeOverride;
  final bool? applyToAppBar;

  ContactsScreenStyle copyWith({
    BackgroundStyle? background,
    ContentThemeOverride? contentThemeOverride,
    bool? applyToAppBar,
  }) {
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
      ..add(EnumProperty<ContentThemeOverride?>('contentThemeOverride', contentThemeOverride))
      ..add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
  }
}
