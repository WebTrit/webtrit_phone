import 'package:webtrit_phone/app/router/app_router.dart';

abstract class MainScreenRouteStateRepository {
  String get activeTabPage;
  dynamic get lastRouteArgs;

  void setActiveTabPage(String activeTabPage);
  void setLastRouteArgs(dynamic lastRouteArgs);

  bool isChatsTabActive();
  bool isChatScreenActive(int chatId);
  bool isConversationScreenActive(String participantId);
}

class MainScreenRouteStateRepositoryAutoRouteImpl implements MainScreenRouteStateRepository {
  String _activeTabPage = '';
  dynamic _lastRouteArgs;

  @override
  String get activeTabPage => _activeTabPage;
  @override
  dynamic get lastRouteArgs => _lastRouteArgs;

  @override
  void setActiveTabPage(String activeTabPage) => _activeTabPage = activeTabPage;
  @override
  void setLastRouteArgs(dynamic lastRouteArgs) => _lastRouteArgs = lastRouteArgs;

  @override
  bool isChatsTabActive() => _activeTabPage == ChatsRouterPageRoute.name;

  @override
  bool isChatScreenActive(int chatId) {
    final routeArgs = lastRouteArgs;
    return routeArgs is GroupScreenPageRouteArgs && routeArgs.chatId == chatId;
  }

  @override
  bool isConversationScreenActive(String participantId) {
    final routeArgs = lastRouteArgs;
    return routeArgs is ConversationScreenPageRouteArgs && routeArgs.participantId == participantId;
  }
}
