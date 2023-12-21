import 'package:flutter/widgets.dart';

class AppRoute {
  AppRoute._();

  static const loginModeSelect = 'login/mode-select';
  static const loginCoreUrl = 'login/core-url-assign';
  static const loginTypes = 'login/types';
  static const loginTypesOtp = 'login/types/otp';
  static const loginTypesOtpVerify = 'login/types/otp/verify';
  static const loginTypesPassword = 'login/types/password';

  static const webRegistration = 'web-registration';

  static const main = 'main';

  static const permissions = 'permissions';
}

class MainRoute {
  MainRoute._();

  static final observer = RouteObserver<ModalRoute<dynamic>>();

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
