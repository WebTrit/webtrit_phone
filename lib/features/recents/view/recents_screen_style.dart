import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

class RecentsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const RecentsScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ContentThemeOverride? contentThemeOverride;
  final bool? applyToAppBar;

  RecentsScreenStyle copyWith({
    BackgroundStyle? background,
    ContentThemeOverride? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return RecentsScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static RecentsScreenStyle merge(RecentsScreenStyle? a, RecentsScreenStyle? b) {
    if (a == null) return b ?? const RecentsScreenStyle();
    if (b == null) return a;

    return RecentsScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static RecentsScreenStyle lerp(RecentsScreenStyle? a, RecentsScreenStyle? b, double t) {
    return RecentsScreenStyle(
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
