import 'package:flutter/material.dart';

import 'popup_menu.dart';

/// One in-call action button (mute, hold, hangup, ...).
///
/// All the action-grid buttons share the same tooltip-labeled icon button
/// shape; this widget is that shape, so the buttons cannot drift apart and a
/// future change touches one place instead of ten call sites.
class CallActionButton extends StatelessWidget {
  const CallActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.statesController,
    this.style,
    required this.child,
  });

  /// Shown as the long-press tooltip.
  final String label;

  final VoidCallback? onPressed;
  final WidgetStatesController? statesController;
  final ButtonStyle? style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: TextButton(onPressed: onPressed, statesController: statesController, style: style, child: child),
    );
  }
}

/// The popup-menu flavor of [CallActionButton] (transfer, audio device).
///
/// The [TextButton] is decoration only: [IgnorePointer] keeps taps on the
/// popup trigger, and an empty callback (instead of null) keeps the button
/// out of the 'disabled' state, which would override the custom style with
/// default disabled theme colors.
class CallActionMenuButton<T> extends StatelessWidget {
  const CallActionMenuButton({
    super.key,
    required this.label,
    this.enabled = true,
    required this.items,
    this.onSelected,
    this.offset = Offset.zero,
    this.statesController,
    this.style,
    required this.child,
  });

  /// Shown as the long-press tooltip.
  final String label;

  final bool enabled;
  final List<PopupMenuItem<T>> items;
  final PopupMenuItemSelected<T>? onSelected;
  final Offset offset;
  final WidgetStatesController? statesController;
  final ButtonStyle? style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: CallPopupMenuButton<T>(
        items: items,
        onSelected: onSelected,
        offset: offset,
        child: IgnorePointer(
          child: TextButton(
            onPressed: enabled ? () {} : null,
            statesController: statesController,
            style: style,
            child: child,
          ),
        ),
      ),
    );
  }
}
