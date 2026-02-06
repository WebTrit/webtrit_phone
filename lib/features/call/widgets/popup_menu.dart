import 'package:flutter/material.dart';

class CallPopupMenuButton<T> extends StatelessWidget {
  const CallPopupMenuButton({super.key, this.onSelected, this.child, this.offset = Offset.zero, required this.items});

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
