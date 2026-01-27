import 'package:webtrit_phone/extensions/extensions.dart';

import '../main_flavor.dart';

import 'bottom_menu_feature.dart';

/// Static configuration for the bottom navigation menu.
class BottomMenuConfig {
  const BottomMenuConfig({required List<BottomMenuTab> tabs}) : _tabs = tabs;

  final List<BottomMenuTab> _tabs;

  /// Returns all configured tabs.
  List<BottomMenuTab> get tabs => _tabs;

  /// Returns only tabs of type [EmbeddedBottomMenuTab].
  List<EmbeddedBottomMenuTab> get embeddedTabs => _tabs.whereType<EmbeddedBottomMenuTab>().toList(growable: false);

  /// Returns the first enabled tab of the specified type [T], or `null` if no such tab exists.
  T? getTabEnabled<T extends BottomMenuTab>() {
    final tab = _tabs.firstWhereOrNull((tab) => tab is T && tab.enabled);
    return tab is T ? tab : null;
  }

  /// Returns the embedded tab with the specified [id].
  EmbeddedBottomMenuTab getEmbeddedTabById(String id) {
    return embeddedTabs.firstWhere((tab) => tab.id == id);
  }

  /// Finds the initial tab to be selected based on the saved flavor or the initial flag.
  BottomMenuTab findInitialTab(MainFlavor? savedFlavor) {
    return _tabs.firstWhereOrNull((tab) => tab.flavor == savedFlavor) ??
        _tabs.firstWhereOrNull((tab) => tab.initial) ??
        _tabs.first;
  }
}
