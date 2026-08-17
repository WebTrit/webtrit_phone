import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

/// Bottom navigation of the main screen: one entry per configured section.
class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({super.key, required this.tabs, required this.currentIndex, required this.onTap});

  final List<BottomMenuTab> tabs;

  final int currentIndex;

  final ValueChanged<int> onTap;

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

  /// Key of the entry. Every embedded section used to take the one key of its
  /// kind, and two of them in the same bar brought the build down with a
  /// duplicate key, so an embedded entry is keyed by the id it is configured
  /// with.
  Key _key(BottomMenuTab tab) => switch (tab) {
    EmbeddedBottomMenuTab(:final id) => Key('embeddedNavBarKey_$id'),
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
      icon: icon,
      label: context.parseL10n(tab.titleL10n),
    );
  }
}
