import 'dart:async';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

abstract class MainScreenRouteStateRepository {
  String get activeTabPage;

  void setActiveTabPage(String activeTabPage);

  /// Returns the active flavor tab based on the current active tab page.
  MainFlavor? get activeFlavorTab;

  /// Returns a stream of the active flavor tab.
  /// First value is the current active flavor tab.
  Stream<MainFlavor?> get activeFlavorTabStream;
}

class MainScreenRouteStateRepositoryAutoRouteImpl implements MainScreenRouteStateRepository {
  String _activeTabPage = '';
  final _activeTabPageController = StreamController<String>.broadcast();

  @override
  String get activeTabPage => _activeTabPage;

  @override
  void setActiveTabPage(String activeTabPage) {
    _activeTabPage = activeTabPage;
    _activeTabPageController.add(activeTabPage);
  }

  @override
  MainFlavor? get activeFlavorTab => _mapActiveTabPageToFlavor(_activeTabPage);

  @override
  Stream<MainFlavor?> get activeFlavorTabStream async* {
    yield _mapActiveTabPageToFlavor(_activeTabPage);
    yield* _activeTabPageController.stream.map(_mapActiveTabPageToFlavor);
  }

  MainFlavor? _mapActiveTabPageToFlavor(String activeTabPage) {
    switch (activeTabPage) {
      case FavoritesRouterPageRoute.name:
        return MainFlavor.favorites;
      case RecentsRouterPageRoute.name:
        return MainFlavor.recents;
      case ContactsRouterPageRoute.name:
        return MainFlavor.contacts;
      case KeypadScreenPageRoute.name:
        return MainFlavor.keypad;
      case ConversationsScreenPageRoute.name:
        return MainFlavor.messaging;
      case EmbeddedTabPageRoute.name:
        return MainFlavor.embedded;
      default:
        return null;
    }
  }
}
