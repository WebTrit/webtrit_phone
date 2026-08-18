import 'package:flutter/material.dart';

class ExtTabBar extends StatelessWidget {
  const ExtTabBar({super.key, this.width, this.height, required this.tabs, this.controller});

  final double? width;
  final double? height;
  final List<Widget> tabs;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    final height = this.height;
    final borderRadius = height == null ? null : BorderRadius.circular(height / 2);
    return SizedBox(
      width: width,
      height: height,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        splashBorderRadius: borderRadius,
      ),
    );
  }
}

/// A tab of [ExtTabBar] that automation can address by [identifier].
///
/// The id is declared inside the tab rather than around it on purpose. The tab
/// bar merges every tab with the ink well that answers the press into a single
/// node, and that node is the only one the platform is told about; an id given
/// a node of its own would end up beside the press instead of on it. Declared
/// here it is absorbed into the merged node, next to the caption and the tap.
class ExtTab extends StatelessWidget implements PreferredSizeWidget {
  const ExtTab({super.key, required this.text, required this.identifier});

  final String text;

  /// Stable, non-localized automation id (exposed as the platform resource id).
  final String identifier;

  @override
  Size get preferredSize => Tab(text: text).preferredSize;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: identifier,
      child: Tab(text: text),
    );
  }
}
