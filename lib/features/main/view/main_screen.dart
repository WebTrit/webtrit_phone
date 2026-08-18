import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/main/widgets/widgets.dart';
import 'package:webtrit_phone/models/models.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.tabs,
    required this.currentIndex,
    this.onTabSelected,
    this.decorateTabIcon,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;

  /// The screen owns its navigation bar: hosts hand over the configured tabs
  /// and the selection instead of a bar-shaped widget, so every host - the
  /// app and the previews - shows the real control.
  final List<BottomMenuTab> tabs;

  /// Position of the open tab in [tabs].
  final int currentIndex;

  /// Null renders the bar inert - a static preview shows it without wiring.
  final ValueChanged<int>? onTabSelected;

  /// Decorates a tab's icon in the bar (badges and the like); null draws
  /// icons bare. A host passes a decoration only when it also provides the
  /// state that decoration reads.
  final Widget Function(BottomMenuTab tab, Widget icon)? decorateTabIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: MainBottomNavigationBar(
            tabs: tabs,
            currentIndex: currentIndex,
            onTap: onTabSelected,
            decorateIcon: decorateTabIcon,
          ),
        ),
      ),
    );
  }
}
