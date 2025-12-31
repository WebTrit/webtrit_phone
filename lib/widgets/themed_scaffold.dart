import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

/// A wrapper around [Scaffold] that applies custom [BackgroundStyle] configurations.
///
/// This widget handles complex background logic (Gradients, Images) by wrapping
/// the body in a decorated Container and automatically adjusting properties
/// like [extendBodyBehindAppBar] to ensure visual consistency.
class ThemedScaffold extends StatelessWidget {
  const ThemedScaffold({
    super.key,
    required this.body,
    this.background,
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

  final Widget body;

  /// Defines the background style (Solid, Gradient, or Image).
  ///
  /// If provided, this may override [backgroundColor] or force
  /// [extendBodyBehindAppBar] to true depending on the specific style.
  final BackgroundStyle? background;

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
    // Determines the scaffold background color.
    // If [SolidBackgroundStyle] is used, it takes precedence over the fallback [backgroundColor].
    // Complex styles (Gradient/Image) are handled via Container decoration, so this remains null/fallback.
    final scaffoldColor = switch (background) {
      SolidBackgroundStyle s => s.color,
      _ => backgroundColor,
    };

    // Automatically extends the body behind the AppBar if a complex background
    // (Gradient or Image) is present. This prevents a visual disconnect (e.g., a white strip)
    // at the top of the screen.
    final effectiveExtendBodyBehindAppBar =
        extendBodyBehindAppBar || (background is GradientBackgroundStyle || background is ImageBackgroundStyle);

    final boxDecoration = _resolveBoxDecoration(background);

    return Scaffold(
      backgroundColor: scaffoldColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: effectiveExtendBodyBehindAppBar,
      appBar: appBar,
      // If a complex decoration exists, wrap the body in a Container to apply it.
      // Otherwise, render the body directly to avoid unnecessary nesting.
      body: boxDecoration != null
          ? Container(width: double.infinity, height: double.infinity, decoration: boxDecoration, child: body)
          : body,
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
  }

  /// Converts the [BackgroundStyle] into a standard Flutter [BoxDecoration].
  ///
  /// Returns null for [SolidBackgroundStyle] as that is handled by the Scaffold's [backgroundColor].
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
