import 'package:flutter/material.dart';

class CallPopupMenuButton<T> extends StatelessWidget {
  const CallPopupMenuButton({
    super.key,
    this.menuKey,
    this.enabled = true,
    this.onSelected,
    this.child,
    this.offset = Offset.zero,
    required this.items,
  });

  /// Key of the inner [PopupMenuButton]; lets the caller open the menu
  /// programmatically via [PopupMenuButtonState.showButtonMenu].
  final GlobalKey<PopupMenuButtonState<T>>? menuKey;

  /// Whether the trigger reacts at all. Disabling it also drops the tap action
  /// from the accessibility tree, so assistive technology does not announce an
  /// action that would open nothing.
  final bool enabled;

  final PopupMenuItemSelected<T>? onSelected;
  final Widget? child;
  final Offset offset;
  final List<PopupMenuEntry<T>> items;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: PopupMenuButton<T>(
        key: menuKey,
        enabled: enabled,
        // Without this the button brings its own "Show menu" tooltip: it is
        // read by screen readers on top of the caller's name (appended to the
        // spoken label on iOS) and it wins the long-press gesture over any
        // tooltip the caller wraps around this widget. An empty message makes
        // the tooltip build its child bare, leaving both to the caller.
        tooltip: '',
        onSelected: onSelected,
        offset: offset,
        elevation: 4,
        padding: EdgeInsets.zero,
        splashRadius: 0,
        itemBuilder: (context) => items,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: child,
      ),
    );
  }
}

/// One entry of a call popup menu: an icon, a line of text, and a stable id.
///
/// It wraps [PopupMenuItem] instead of extending it because of where the id has
/// to sit. The item merges its own subtree into one node, and only the node
/// that OWNS the identifier hands it to the platform - an identifier absorbed
/// from a merged child shows up in a widget test and arrives nowhere on the
/// device. So the merge is started from the outside, with the identifier on top
/// of it, and the item's name and tap are absorbed into that node.
class CallPopupMenuItem<T> extends PopupMenuEntry<T> {
  const CallPopupMenuItem({
    super.key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.textStyle,
    this.identifier,
    required this.text,
    required this.icon,
  });

  final T? value;
  final VoidCallback? onTap;
  final bool enabled;
  final TextStyle? textStyle;

  /// Stable automation id of the entry; it is read out by its own text, so it
  /// needs no separate name.
  final String? identifier;

  final String text;
  final Widget icon;

  /// The entries size themselves; the menu is asked to reserve nothing.
  @override
  double get height => 0;

  @override
  bool represents(T? value) => value == this.value;

  @override
  State<CallPopupMenuItem<T>> createState() => _CallPopupMenuItemState<T>();
}

class _CallPopupMenuItemState<T> extends State<CallPopupMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        // A node of its own: an identifier absorbed from a merged child is
        // visible in a widget test and reaches the device as nothing at all.
        container: true,
        identifier: widget.identifier,
        child: PopupMenuItem<T>(
          value: widget.value,
          onTap: widget.onTap,
          enabled: widget.enabled,
          textStyle: widget.textStyle,
          height: 0,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: widget.icon),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(widget.text, overflow: TextOverflow.ellipsis, maxLines: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
