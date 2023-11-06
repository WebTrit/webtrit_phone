import 'package:flutter/widgets.dart';

class AppRoute {
  AppRoute._();

  static const queryKeys = AppQueries();

  static const login = 'login';
  static const loginStep = 'login/step';

  static const webRegistration = 'web-registration';

  static const main = 'main';

  static const permissions = 'permissions';
}

class MainRoute {
  MainRoute._();

  static final observer = RouteObserver<ModalRoute<dynamic>>();

  static const queryKeys = MainQueries();

  static const call = 'call';

  static const favorites = 'favorites';
  static const favoritesDetails = 'favorite';

  static const contacts = 'contacts';
  static const contactsDetails = 'contact';

  static const recents = 'recents';
  static const recentsDetails = 'recent';

  static const keypad = 'keypad';

  static const settings = 'settings';
  static const settingsAbout = 'about';
  static const settingsHelp = 'help';
  static const settingsLanguage = 'language';
  static const settingsNetwork = 'network';
  static const settingsTermsConditions = 'terms-conditions';
  static const settingsThemeMode = 'theme-mode';
  static const logRecordsConsole = 'log-records-console';
}

class CommonQueries {
  const CommonQueries();

  final String initialUrl = 'initialUrl';
}

class AppQueries extends CommonQueries {
  const AppQueries();
}

class MainQueries extends CommonQueries {
  const MainQueries();
}
