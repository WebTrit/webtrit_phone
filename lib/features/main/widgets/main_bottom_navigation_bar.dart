import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Decorates a tab's icon in the bottom navigation bar (badges and the
/// like). A host passes one only when it also provides the state the
/// decoration reads - the bar itself takes no part in that.
typedef TabIconDecorator = Widget Function(BottomMenuTab tab, Widget icon);

/// One decorator out of several, each wrapping what the ones before it built.
///
/// The bar takes a single decorator on purpose - it is not the place that knows
/// which sections carry a badge. A menu whose sections carry more than one
/// composes them here, so each badge stays owned by the feature it belongs to
/// instead of collecting in a decorator that knows about all of them.
TabIconDecorator composeTabIconDecorators(List<TabIconDecorator> decorators) {
  return (tab, icon) => decorators.fold(icon, (decorated, decorate) => decorate(tab, decorated));
}

/// Bottom navigation of the main screen: one entry per configured section.
class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTap,
    this.decorateIcon,
  });

  final List<BottomMenuTab> tabs;

  final int currentIndex;

  /// Null renders the bar inert - a static preview shows it without wiring.
  final ValueChanged<int>? onTap;

  /// Null draws icons bare; see [TabIconDecorator].
  final TabIconDecorator? decorateIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor?.withAlpha(200),
      useLegacyColorScheme: false,
      enableFeedback: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: theme.textTheme.bodySmall,
      unselectedLabelStyle: theme.textTheme.bodySmall,
      currentIndex: currentIndex,
      items: [for (final tab in tabs) _item(context, tab)],
      onTap: onTap,
    );
  }

  BottomNavigationBarItem _item(BuildContext context, BottomMenuTab tab) {
    Widget icon = Icon(tab.icon);
    icon = decorateIcon?.call(tab, icon) ?? icon;

    return BottomNavigationBarItem(
      key: tab.navBarKey,
      // The bar builds the node that carries the caption and the press, so the
      // id has to be handed to that node rather than declared on one of ours.
      icon: SemanticIdOfAncestor(identifier: tab.navBarId, child: icon),
      label: context.parseL10n(tab.titleL10n),
    );
  }
}
