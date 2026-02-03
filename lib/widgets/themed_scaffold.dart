import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

/// Defines how the content theme should be overridden within the scaffold.
enum ContentThemeOverride { auto, light, dark }

/// A wrapper around [Scaffold] that provides enhanced theming and background capabilities.
///
/// This widget allows for:
/// - Custom background styles (Solid, Gradient, Image) via [BackgroundStyle].
/// - automatic theme mode overriding (forcing light or dark mode) for the content
///   or the entire scaffold.
class ThemedScaffold extends StatelessWidget {
  const ThemedScaffold({
    super.key,
    required this.body,
    this.background,
    this.contentThemeOverride = ContentThemeOverride.auto,
    this.applyToAppBar = true,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.persistentFooterDecoration,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  /// The primary content of the scaffold.
  final Widget body;

  /// Configuration for the scaffold's background (e.g., Gradient, Image).
  final BackgroundStyle? background;

  /// Determines if the theme brightness should be forced to Light or Dark.
  final ContentThemeOverride? contentThemeOverride;

  /// If true, the [contentThemeOverride] is applied to the entire Scaffold (including [appBar]).
  /// If false, it is applied only to the [body], allowing the [appBar] to retain the global theme.
  final bool applyToAppBar;

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final BoxDecoration? persistentFooterDecoration;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    final shouldOverride = contentThemeOverride != ContentThemeOverride.auto;
    final overrideTheme = shouldOverride ? _resolveThemeOverride(context) : null;

    final scaffoldBackgroundColor = switch (background) {
      SolidBackgroundStyle s => s.color,
      _ => backgroundColor,
    };

    final effectiveExtendBodyBehindAppBar =
        extendBodyBehindAppBar || (background is GradientBackgroundStyle || background is ImageBackgroundStyle);

    final boxDecoration = _resolveBoxDecoration(background);

    Widget currentBody = body;

    // Apply background decoration if available
    if (boxDecoration != null) {
      currentBody = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: boxDecoration,
        child: currentBody,
      );
    }

    // Apply theme override ONLY to body if applyToAppBar is FALSE.
    if (shouldOverride && !applyToAppBar && overrideTheme != null) {
      currentBody = Theme(data: overrideTheme, child: currentBody);
    }

    Widget scaffold = Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: effectiveExtendBodyBehindAppBar,
      appBar: appBar,
      body: currentBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterDecoration: persistentFooterDecoration,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      drawerScrimColor: drawerScrimColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );

    // Apply theme override to WHOLE Scaffold (including AppBar) if applyToAppBar is TRUE.
    if (shouldOverride && applyToAppBar && overrideTheme != null) {
      scaffold = Theme(data: overrideTheme, child: scaffold);
    }

    return scaffold;
  }

  BoxDecoration? _resolveBoxDecoration(BackgroundStyle? style) {
    return switch (style) {
      GradientBackgroundStyle g => BoxDecoration(gradient: g.gradient),
      ImageBackgroundStyle i => BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(image: NetworkImage(i.imageUrl), fit: i.fit, opacity: i.opacity),
      ),
      _ => null,
    };
  }

  ThemeData _resolveThemeOverride(BuildContext context) {
    final currentTheme = Theme.of(context);
    final targetBrightness = contentThemeOverride == ContentThemeOverride.light ? Brightness.light : Brightness.dark;

    final newColorScheme = ColorScheme.fromSeed(
      seedColor: currentTheme.colorScheme.primary,
      brightness: targetBrightness,
    );

    final newTextTheme = currentTheme.textTheme.apply(
      bodyColor: newColorScheme.onSurface,
      displayColor: newColorScheme.onSurface,
      decorationColor: newColorScheme.onSurface,
    );

    final newIconTheme = currentTheme.iconTheme.copyWith(color: newColorScheme.onSurface);

    // If ignoreAppBarOverride is false, we need to ensure the SystemUI overlay matches
    // the new brightness target.
    final overlayStyle = targetBrightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

    return currentTheme.copyWith(
      brightness: targetBrightness,
      colorScheme: newColorScheme,
      textTheme: newTextTheme,
      iconTheme: newIconTheme,
      scaffoldBackgroundColor: newColorScheme.surface,
      appBarTheme: currentTheme.appBarTheme.copyWith(
        systemOverlayStyle: overlayStyle,
        backgroundColor: Colors.transparent,
        foregroundColor: newColorScheme.onSurface,
      ),
    );
  }
}
