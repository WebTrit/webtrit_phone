import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'popup_menu.dart';

/// One in-call action button (mute, hold, hangup, ...).
///
/// The former `Tooltip(TextButton(Icon))` shape left the spoken name on a
/// node without the action: a button widget forms its own semantics container
/// and the tooltip's label does not merge into it, so screen readers
/// announced a bare "button". This widget owns the whole accessibility
/// contract instead - the spoken [label], the stable [identifier] and the
/// tap action end up on a single node, while the visual long-press tooltip
/// is kept but excluded from semantics.
class CallActionButton extends StatelessWidget {
  const CallActionButton({
    super.key,
    required this.label,
    this.identifier,
    this.onPressed,
    this.statesController,
    this.style,
    required this.child,
  });

  /// Spoken name; also shown as the visual long-press tooltip.
  final String label;

  /// Stable automation id (see the `...Id` constants in keys.dart).
  final String? identifier;

  final VoidCallback? onPressed;
  final WidgetStatesController? statesController;
  final ButtonStyle? style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SemanticAction(
      label: label,
      identifier: identifier,
      child: Tooltip(
        message: label,
        excludeFromSemantics: true,
        child: TextButton(onPressed: onPressed, statesController: statesController, style: style, child: child),
      ),
    );
  }
}

/// The popup-menu flavor of [CallActionButton] (transfer, audio device).
///
/// The styling [TextButton] opens the menu itself: after the semantics merge
/// its handler is the node's tap action, and a decorative no-op there would
/// leave assistive technology activating nothing (while pointer taps keep
/// working - which is exactly how such a defect stays unnoticed).
class CallActionMenuButton<T> extends StatefulWidget {
  const CallActionMenuButton({
    super.key,
    required this.label,
    this.identifier,
    this.enabled = true,
    required this.items,
    this.onSelected,
    this.offset = Offset.zero,
    this.statesController,
    this.style,
    required this.child,
  });

  /// Spoken name; also shown as the visual long-press tooltip.
  final String label;

  /// Stable automation id (see the `...Id` constants in keys.dart).
  final String? identifier;

  /// Whether the trigger reacts. A trigger with no items is inert regardless:
  /// an empty menu opens nothing, so it must not announce an action either.
  final bool enabled;

  final List<PopupMenuItem<T>> items;
  final PopupMenuItemSelected<T>? onSelected;
  final Offset offset;
  final WidgetStatesController? statesController;
  final ButtonStyle? style;
  final Widget child;

  @override
  State<CallActionMenuButton<T>> createState() => _CallActionMenuButtonState<T>();
}

class _CallActionMenuButtonState<T> extends State<CallActionMenuButton<T>> {
  final _menuKey = GlobalKey<PopupMenuButtonState<T>>();

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled && widget.items.isNotEmpty;
    return SemanticAction(
      label: widget.label,
      identifier: widget.identifier,
      child: Tooltip(
        message: widget.label,
        excludeFromSemantics: true,
        child: CallPopupMenuButton<T>(
          menuKey: _menuKey,
          enabled: enabled,
          items: widget.items,
          onSelected: widget.onSelected,
          offset: widget.offset,
          child: TextButton(
            onPressed: enabled ? () => _menuKey.currentState?.showButtonMenu() : null,
            statesController: widget.statesController,
            style: widget.style,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
