import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Bottom navigation of the main screen: one entry per configured section.
class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({super.key, required this.tabs, required this.currentIndex, required this.onTap});

  final List<BottomMenuTab> tabs;

  final int currentIndex;

  /// Null renders the bar inert - a static preview shows it without wiring.
  final ValueChanged<int>? onTap;

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

  /// Id of the entry: the fixed sections have one each, while an embedded
  /// section is told apart by the id it is configured with - an install can
  /// carry more than one of them.
  String _identifier(BottomMenuTab tab) => switch (tab) {
    EmbeddedBottomMenuTab(:final id) => embeddedNavBarId(id),
    _ => tab.flavor.toNavBarId(),
  };

  /// The widget key follows the same rule, and for the same reason: two
  /// embedded sections in one bar used to collide on a single key.
  Key _key(BottomMenuTab tab) => switch (tab) {
    EmbeddedBottomMenuTab(:final id) => embeddedNavBarKey(id),
    _ => tab.flavor.toNavBarKey(),
  };

  BottomNavigationBarItem _item(BuildContext context, BottomMenuTab tab) {
    final flavor = tab.flavor;

    Widget icon = Icon(tab.icon);
    if (flavor == MainFlavor.messaging) icon = MessagingFlavorOverlay(child: icon);

    return BottomNavigationBarItem(
      key: _key(tab),
      // The bar builds the node that carries the caption and the press, so the
      // id has to be handed to that node rather than declared on one of ours.
      icon: SemanticIdOfAncestor(identifier: _identifier(tab), child: icon),
      label: context.parseL10n(tab.titleL10n),
    );
  }
}
