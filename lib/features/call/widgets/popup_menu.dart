import 'package:flutter/material.dart';

class CallPopupMenuButton extends PopupMenuButton {
  CallPopupMenuButton({
    super.key,
    super.onSelected,
    super.child,
    super.offset,
    required List<PopupMenuItem> items,
  }) : super(
          itemBuilder: (context) => items,
          elevation: 4,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
}

class CallPopupMenuItem extends PopupMenuItem {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(text),
              ),
            ],
          ),
          height: 0,
          padding: EdgeInsets.zero,
        );
}
