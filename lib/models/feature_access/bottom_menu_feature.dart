import 'package:flutter/widgets.dart';

import '../main_flavor.dart';

class BottomMenuTab {
  final bool enabled;
  final bool initial;
  final MainFlavor flavor;
  final String titleL10n;
  final IconData icon;

  BottomMenuTab({
    required this.enabled,
    required this.initial,
    required this.flavor,
    required this.titleL10n,
    required this.icon,
  });
}
