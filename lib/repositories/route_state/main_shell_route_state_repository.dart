import 'package:webtrit_phone/app/router/app_router.dart';

abstract class MainShellRouteStateRepository {
  String get activeRouteName;
  dynamic get activeRouteArgs;

  void setActiveRouteName(String name);
  void setActiveRouteArgs(dynamic args);

  bool isMainScreenActive();
  bool isChatConversationScreenActive(int? chatId, String? participantId);
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
  bool isChatConversationScreenActive(int? chatId, String? participantId) {
    final args = _activeRouteArgs;
    final routeMatch = activeRouteName == ChatConversationScreenPageRoute.name;
    final argsMatch =
        args is ChatConversationScreenPageRouteArgs && (args.chatId == chatId || args.participantId == participantId);
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
