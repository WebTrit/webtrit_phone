import 'package:flutter/material.dart';

extension MsgViewExt on ThemeData {
  TextStyle get userNameStyle => TextStyle(color: colorScheme.onSurface, fontSize: 12, fontWeight: FontWeight.w600);

  TextStyle get contentStyle => TextStyle(color: colorScheme.onSurface, fontSize: 12);

  TextStyle get subContentStyle => TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 10);

  Color get contentColor => colorScheme.onPrimaryFixed;

  BoxDecoration messageDecoration(bool isMine, bool isViewedByUser) {
    return BoxDecoration(
      color: isMine
          ? colorScheme.primaryFixed.withValues(alpha: 0.3)
          : colorScheme.tertiaryFixed.withValues(alpha: isViewedByUser ? 0.3 : 0.15),
      borderRadius: isMine
          ? const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )
          : const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
    );
  }

  BoxDecoration quoteDecoration(bool isMine) {
    return BoxDecoration(
      color: isMine ? colorScheme.primaryFixed.withValues(alpha: 0.5) : colorScheme.tertiaryFixed.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: colorScheme.primaryFixed, width: 2)),
    );
  }
}
