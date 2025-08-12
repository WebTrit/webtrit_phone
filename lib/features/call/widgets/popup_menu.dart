import 'package:flutter/material.dart';

class CallPopupMenuButton<T> extends PopupMenuButton<T> {
  CallPopupMenuButton({
    super.key,
    super.onSelected,
    super.child,
    super.offset,
    required List<PopupMenuItem<T>> items,
  }) : super(
          itemBuilder: (context) => items,
          elevation: 4,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: icon,
              ),
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
