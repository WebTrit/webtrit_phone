import 'package:flutter/material.dart';

class PopupMenu extends PopupMenuButton {
  PopupMenu({
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
