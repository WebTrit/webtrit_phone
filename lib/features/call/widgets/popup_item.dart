import 'package:flutter/material.dart';

const double menuItemHeight = 8;

class PopupItem extends PopupMenuItem {
  PopupItem({
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
