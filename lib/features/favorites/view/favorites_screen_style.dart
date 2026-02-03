import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

class FavoritesScreenStyle extends BaseScreenStyle with Diagnosticable {
  const FavoritesScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ContentThemeOverride? contentThemeOverride;
  final bool? applyToAppBar;

  FavoritesScreenStyle copyWith({
    BackgroundStyle? background,
    ContentThemeOverride? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return FavoritesScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static FavoritesScreenStyle merge(FavoritesScreenStyle? a, FavoritesScreenStyle? b) {
    if (a == null) return b ?? const FavoritesScreenStyle();
    if (b == null) return a;

    return FavoritesScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static FavoritesScreenStyle lerp(FavoritesScreenStyle? a, FavoritesScreenStyle? b, double t) {
    return FavoritesScreenStyle(
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
