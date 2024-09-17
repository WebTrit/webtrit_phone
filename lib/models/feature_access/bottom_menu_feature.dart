import 'package:flutter/widgets.dart';

import '../main_flavor.dart';

@immutable
class BottomMenuTab {
  final bool enabled;
  final bool initial;
  final MainFlavor flavor;
  final String titleL10n;
  final IconData icon;
  final BottomMenuTabData? data;

  const BottomMenuTab({
    required this.enabled,
    required this.initial,
    required this.flavor,
    required this.titleL10n,
    required this.icon,
    required this.data,
  });
}

@immutable
class BottomMenuTabData {
  const BottomMenuTabData({
    required this.url,
  });

  final String url;
}
