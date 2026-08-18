import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import 'bottom_menu_feature.dart';

/// Static configuration for the bottom navigation menu.
class BottomMenuConfig extends Equatable {
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

  /// Finds the tab to open first: the saved one if it is still configured,
  /// or a tab of the same kind, or the one the configuration marks initial.
  ///
  /// [savedPath] is a tab's [BottomMenuTab.routePath]. Matching by path is
  /// what keeps several embedded sections apart across a restart; the
  /// kind-only fallback covers a value saved by an older build and an
  /// embedded section that is no longer configured.
  BottomMenuTab findInitialTab(String? savedPath) {
    final savedFlavor = savedPath?.split('/').first;
    return _tabs.firstWhereOrNull((tab) => tab.routePath == savedPath) ??
        _tabs.firstWhereOrNull((tab) => tab.flavor.name == savedFlavor) ??
        _tabs.firstWhereOrNull((tab) => tab.initial) ??
        _tabs.first;
  }

  @override
  List<Object?> get props => [_tabs];
}
