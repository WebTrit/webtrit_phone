import 'package:webtrit_appearance_theme/models/models.dart';

/// Field-wise cascade of app bar configurations: a page-level override on top
/// of the global bar config. Every field the page leaves unset falls through
/// to the global value, so the usual resolution order holds for each property
/// independently: page -> global -> color scheme default.
extension AppBarConfigMerge on AppBarConfig {
  AppBarConfig mergeOver(AppBarConfig base) {
    return AppBarConfig(
      // The two booleans are non-nullable behavior flags consumed straight from
      // the page config (AppBarTheme cannot carry them) - take the page values.
      primary: primary,
      showBackButton: showBackButton,
      backgroundColor: backgroundColor ?? base.backgroundColor,
      foregroundColor: foregroundColor ?? base.foregroundColor,
      shadowColor: shadowColor ?? base.shadowColor,
      surfaceTintColor: surfaceTintColor ?? base.surfaceTintColor,
      elevation: elevation ?? base.elevation,
      scrolledUnderElevation: scrolledUnderElevation ?? base.scrolledUnderElevation,
      titleSpacing: titleSpacing ?? base.titleSpacing,
      leadingWidth: leadingWidth ?? base.leadingWidth,
      toolbarHeight: toolbarHeight ?? base.toolbarHeight,
      centerTitle: centerTitle ?? base.centerTitle,
      iconTheme: iconTheme ?? base.iconTheme,
      actionsIconTheme: actionsIconTheme ?? base.actionsIconTheme,
      titleTextStyle: titleTextStyle ?? base.titleTextStyle,
      toolbarTextStyle: toolbarTextStyle ?? base.toolbarTextStyle,
      systemOverlayStyle: systemOverlayStyle ?? base.systemOverlayStyle,
    );
  }
}
