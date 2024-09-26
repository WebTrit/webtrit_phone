import 'package:webtrit_phone/app/router/app_router.dart';

abstract class MainShellRouteStateRepository {
  String get activeRouteName;
  dynamic get activeRouteArgs;

  void setActiveRouteName(String name);
  void setActiveRouteArgs(dynamic args);

  bool isMainScreenActive();
  bool isGroupScreenActive(int chatId);
  bool isConversationScreenActive(String participantId);
  bool isSmsConversationScreenActive(String firstNumber, String secondNumber);
}

class MainShellRouteStateRepositoryAutoRouteImpl implements MainShellRouteStateRepository {
  String _activeRouteName = '';
  dynamic _activeRouteArgs;

  @override
  dynamic get activeRouteArgs => _activeRouteArgs;

  @override
  String get activeRouteName => _activeRouteName;

  @override
  void setActiveRouteName(String name) => _activeRouteName = name;

  @override
  void setActiveRouteArgs(dynamic args) => _activeRouteArgs = args;

  @override
  bool isMainScreenActive() {
    return activeRouteName == MainScreenPageRoute.name;
  }

  @override
  bool isGroupScreenActive(int chatId) {
    final args = _activeRouteArgs;
    final routeMatch = activeRouteName == GroupScreenPageRoute.name;
    final argsMatch = args is GroupScreenPageRouteArgs && args.chatId == chatId;
    return routeMatch && argsMatch;
  }

  @override
  bool isConversationScreenActive(String participantId) {
    final args = _activeRouteArgs;
    final routeMatch = activeRouteName == ConversationScreenPageRoute.name;
    final argsMatch = args is ConversationScreenPageRouteArgs && args.participantId == participantId;
    return routeMatch && argsMatch;
  }

  @override
  bool isSmsConversationScreenActive(String firstNumber, String secondNumber) {
    final args = _activeRouteArgs;
    final routeMatch = activeRouteName == SmsConversationScreenPageRoute.name;
    final argsMatch = args is SmsConversationScreenPageRouteArgs &&
        args.firstNumber == firstNumber &&
        args.secondNumber == secondNumber;
    return routeMatch && argsMatch;
  }
}
