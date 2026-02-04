import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

/// A wrapper around [Scaffold] that provides enhanced theming and background capabilities.
///
/// This widget allows for:
/// - Custom background styles (Solid, Gradient, Image) via [BackgroundStyle].
/// - Automatic theme mode overriding (forcing light or dark mode) for the content
///   or the entire scaffold using the app's defined [ThemeProvider].
class ThemedScaffold extends StatelessWidget {
  const ThemedScaffold({
    super.key,
    required this.body,
    this.background,
    this.contentThemeOverride = ThemeMode.system,
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
  final ThemeMode? contentThemeOverride;

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
    // Get the ThemeProvider to access the app's true definitions of Light/Dark themes
    final themeProvider = ThemeProvider.of(context);
    final effectiveContentThemeOverride = contentThemeOverride ?? ThemeMode.system;

    // Resolve the specific ThemeData if an override is requested
    ThemeData? overrideTheme;
    if (effectiveContentThemeOverride == ThemeMode.light) {
      overrideTheme = themeProvider.light();
    } else if (effectiveContentThemeOverride == ThemeMode.dark) {
      overrideTheme = themeProvider.dark();
    }

    // Resolve background decoration (Gradient/Image)
    final boxDecoration = _resolveBoxDecoration(background);

    // Determine background color.
    final effectiveBackgroundColor = switch (background) {
      SolidBackgroundStyle s => s.color,
      _ => backgroundColor ?? overrideTheme?.scaffoldBackgroundColor,
    };

    final effectiveExtendBodyBehindAppBar =
        extendBodyBehindAppBar || (background is GradientBackgroundStyle || background is ImageBackgroundStyle);

    Widget currentBody = body;

    // Apply background decoration wrapper
    if (boxDecoration != null) {
      currentBody = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: boxDecoration,
        child: currentBody,
      );
    }

    // Apply override ONLY to body (AppBar keeps global theme)
    if (overrideTheme != null && !applyToAppBar) {
      currentBody = Theme(data: overrideTheme, child: currentBody);
    }

    Widget scaffold = Scaffold(
      backgroundColor: effectiveBackgroundColor,
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

    // CASE B: Apply override to the entire Scaffold (Body + AppBar + Drawers)
    if (overrideTheme != null && applyToAppBar) {
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
}
