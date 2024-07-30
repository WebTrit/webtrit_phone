class MainScreenRouteStateRepository {
  String _activeTabPage = '';
  dynamic _lastRouteArgs;

  String get activeTabPage => _activeTabPage;
  dynamic get lastRouteArgs => _lastRouteArgs;

  void setActiveTabPage(String activeTabPage) {
    _activeTabPage = activeTabPage;
  }

  void setLastRouteArgs(dynamic lastRouteArgs) {
    _lastRouteArgs = lastRouteArgs;
  }
}
