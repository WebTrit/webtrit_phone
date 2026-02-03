import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/themed_scaffold.dart';

class ConversationsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const ConversationsScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ContentThemeOverride? contentThemeOverride;
  final bool? applyToAppBar;

  ConversationsScreenStyle copyWith({
    BackgroundStyle? background,
    ContentThemeOverride? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return ConversationsScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static ConversationsScreenStyle merge(ConversationsScreenStyle? a, ConversationsScreenStyle? b) {
    if (a == null) return b ?? const ConversationsScreenStyle();
    if (b == null) return a;

    return ConversationsScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static ConversationsScreenStyle lerp(ConversationsScreenStyle? a, ConversationsScreenStyle? b, double t) {
    return ConversationsScreenStyle(
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
