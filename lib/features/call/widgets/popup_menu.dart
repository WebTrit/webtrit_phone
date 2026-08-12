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
  final List<PopupMenuItem<T>> items;

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

class CallPopupMenuItem<T> extends PopupMenuItem<T> {
  CallPopupMenuItem({
    super.key,
    super.value,
    super.onTap,
    super.enabled = true,
    super.textStyle,
    required String text,
    required Widget icon,
  }) : super(
         child: Row(
           children: [
             Padding(padding: const EdgeInsets.all(8), child: icon),
             Flexible(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 4),
                 child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 2),
               ),
             ),
           ],
         ),
         height: 0,
         padding: EdgeInsets.zero,
       );
}
