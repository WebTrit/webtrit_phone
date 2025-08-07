import 'package:flutter/widgets.dart';

class InertSafeArea extends SafeArea {
  const InertSafeArea({
    super.key,
    required super.child,
    super.minimum = EdgeInsets.zero,
    super.maintainBottomViewPadding = false,
    super.left = false,
    super.top = false,
    super.right = false,
    super.bottom = false,
  });
}
