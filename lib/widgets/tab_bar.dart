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
  /// A tab that is just its caption.
  const ExtTab({super.key, required String this.text, required this.identifier}) : child = null;

  /// A tab that draws more than its caption - a badge beside it, say.
  ///
  /// Anything in [child] that is decoration rather than meaning belongs in an
  /// `ExcludeSemantics` - the tab merges into one node, so a stray glyph is
  /// read out inside the tab's name. What that decoration stood for is said by
  /// a `Semantics(label: ...)` on a widget drawn AFTER the caption: a merged
  /// name is assembled in the order the parts are drawn, so that is what puts
  /// the count behind the name it belongs to.
  const ExtTab.child({super.key, required Widget this.child, required this.identifier}) : text = null;

  /// Caption of a text-only tab; null when the tab draws its own [child].
  final String? text;

  /// Contents of a tab that draws more than a caption; null when the tab is
  /// just its [text]. Exactly one of the two is set - the constructors are
  /// what guarantees it, the way `Tab` itself does.
  final Widget? child;

  /// Stable, non-localized automation id (exposed as the platform resource id).
  final String identifier;

  Tab get _tab => Tab(text: text, child: child);

  @override
  Size get preferredSize => _tab.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Semantics(identifier: identifier, child: _tab);
  }
}
