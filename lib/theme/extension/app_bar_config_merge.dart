import 'package:webtrit_appearance_theme/models/models.dart';

/// Field-wise cascade of app bar configurations: a page-level override on top
/// of the global bar config. Every field the page leaves unset falls through
/// to the global value - including the sub-fields of the nested styles - so
/// the usual resolution order holds for each property independently:
/// page -> global -> color scheme default.
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
      iconTheme: _mergeIconTheme(iconTheme, base.iconTheme),
      actionsIconTheme: _mergeIconTheme(actionsIconTheme, base.actionsIconTheme),
      titleTextStyle: _mergeTextStyle(titleTextStyle, base.titleTextStyle),
      toolbarTextStyle: _mergeTextStyle(toolbarTextStyle, base.toolbarTextStyle),
      systemOverlayStyle: _mergeOverlayStyle(systemOverlayStyle, base.systemOverlayStyle),
    );
  }
}

TextStyleConfig? _mergeTextStyle(TextStyleConfig? page, TextStyleConfig? base) {
  if (page == null) return base;
  if (base == null) return page;
  return TextStyleConfig(
    fontFamily: page.fontFamily ?? base.fontFamily,
    fontSize: page.fontSize ?? base.fontSize,
    fontWeight: page.fontWeight ?? base.fontWeight,
    fontStyle: page.fontStyle ?? base.fontStyle,
    color: page.color ?? base.color,
    letterSpacing: page.letterSpacing ?? base.letterSpacing,
    wordSpacing: page.wordSpacing ?? base.wordSpacing,
    height: page.height ?? base.height,
    decoration: page.decoration ?? base.decoration,
    backgroundColor: page.backgroundColor ?? base.backgroundColor,
    backgroundBorderRadius: page.backgroundBorderRadius ?? base.backgroundBorderRadius,
    backgroundPadding: page.backgroundPadding ?? base.backgroundPadding,
  );
}

IconThemeDataConfig? _mergeIconTheme(IconThemeDataConfig? page, IconThemeDataConfig? base) {
  if (page == null) return base;
  if (base == null) return page;
  return IconThemeDataConfig(
    size: page.size ?? base.size,
    fill: page.fill ?? base.fill,
    weight: page.weight ?? base.weight,
    grade: page.grade ?? base.grade,
    opticalSize: page.opticalSize ?? base.opticalSize,
    color: page.color ?? base.color,
    opacity: page.opacity ?? base.opacity,
    shadows: page.shadows ?? base.shadows,
    applyTextScaling: page.applyTextScaling ?? base.applyTextScaling,
  );
}

OverlayStyleModel? _mergeOverlayStyle(OverlayStyleModel? page, OverlayStyleModel? base) {
  if (page == null) return base;
  if (base == null) return page;
  return OverlayStyleModel(
    systemNavigationBarColor: page.systemNavigationBarColor ?? base.systemNavigationBarColor,
    systemNavigationBarIconBrightness: page.systemNavigationBarIconBrightness ?? base.systemNavigationBarIconBrightness,
    statusBarIconBrightness: page.statusBarIconBrightness ?? base.statusBarIconBrightness,
    statusBarBrightness: page.statusBarBrightness ?? base.statusBarBrightness,
  );
}
