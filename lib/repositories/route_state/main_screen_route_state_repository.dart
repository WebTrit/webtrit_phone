import 'dart:async';

import 'package:webtrit_phone/models/main_flavor.dart';

abstract class MainScreenRouteStateRepository {
  /// Sets the active flavor tab based on the current active tab page.
  void setActiveTab(MainFlavor? activeTabFlavor);

  /// Returns the active flavor tab based on the current active tab page.
  MainFlavor? get activeTab;

  /// Returns a stream of the active flavor tab.
  /// First value is the current active flavor tab.
  Stream<MainFlavor?> get activeFlavorTabStream;
}

class MainScreenRouteStateRepositoryDefaultImpl implements MainScreenRouteStateRepository {
  MainFlavor? _activeTab;
  final _activeTabController = StreamController<MainFlavor?>.broadcast();

  @override
  MainFlavor? get activeTab => _activeTab;

  @override
  void setActiveTab(MainFlavor? activeTabFlavor) {
    _activeTab = activeTabFlavor;
    _activeTabController.add(activeTabFlavor);
  }

  @override
  Stream<MainFlavor?> get activeFlavorTabStream async* {
    yield _activeTab;
    yield* _activeTabController.stream;
  }
}
