import 'package:flutter/material.dart';

extension MsgViewExt on ThemeData {
  TextStyle get userNameStyle => TextStyle(color: colorScheme.onSurface, fontSize: 12, fontWeight: FontWeight.w600);
  TextStyle get contentStyle => TextStyle(color: colorScheme.onSurface, fontSize: 12);
  TextStyle get subContentStyle => TextStyle(color: colorScheme.onSurface.withOpacity(0.5), fontSize: 10);
  Color get contentColor => colorScheme.onSecondaryFixed;
  BoxDecoration get quoteDecoration => BoxDecoration(
        color: colorScheme.secondaryFixed.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: colorScheme.secondaryFixed, width: 2)),
      );
}
