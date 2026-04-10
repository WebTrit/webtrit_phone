import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/theme/factory/styles/conversations_screen_style_factory.dart';
import 'package:webtrit_phone/theme/factory/styles/embedded_screen_style_factory.dart';
import 'package:webtrit_phone/theme/factory/styles/favorites_screen_style_factory.dart';
import 'package:webtrit_phone/theme/factory/styles/recents_screen_style_factory.dart';

import './styles/styles.dart';
import '../models/models.dart';

import 'theme_data/theme_data.dart';

final _logger = Logger('ThemeStyleFactoryProvider');

// TODO(Serdun): Decompose correctly common widget styles configurations from the page styles configurations
class ThemeStyleFactoryProvider {
  ThemeStyleFactoryProvider({
    required this.colorScheme,
    required this.widgetConfig,
    required this.pageConfig,
    required this.seedThemeData,
  }) {
    defaultTextTheme = TextThemeDataFactory(colorScheme, widgetConfig.fonts, seedThemeData).create();
  }

  /// The color scheme used as a basis for all themed components.
  final ColorScheme colorScheme;

  /// Configuration for common widget styles across the application.
  final ThemeWidgetConfig widgetConfig;

  /// Configuration for page-specific styles.
  final ThemePageConfig pageConfig;

  /// The seed theme data used to inherit base styles.
  final ThemeData seedThemeData;

  /// The default text theme derived from the color scheme and widget configuration.
  late final TextTheme defaultTextTheme;

  List<ThemeExtension> createThemeExtensions() {
    final defaultFontFamily = defaultTextTheme.bodyMedium?.fontFamily;

    _logger.finer('Default font family: $defaultFontFamily');

    // Page schema
    final loginPageScheme = pageConfig.login;
    final callPageScheme = pageConfig.dialing;

    // Widget images config
    final imageAssetsConfig = widgetConfig.imageAssets;

    // Other widgets config
    final appIconConfig = imageAssetsConfig.appIcon;
    final confirmDialog = widgetConfig.dialog.confirmDialog;
    final snackBar = widgetConfig.dialog.snackBar;
    final callStatuses = widgetConfig.statuses.callStatuses;
    final registrationStatuses = widgetConfig.statuses.registrationStatuses;
    final elevatedButton = widgetConfig.button.primaryElevatedButton;
    // TODO: Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use
    final callActions = widgetConfig.group?.callActions;
    final groupTitleListTile = widgetConfig.group?.groupTitleListTile;
    final linkify = widgetConfig.text.linkify;

    // Common widget styles
    final textButtonStyle = TextButtonStyleFactory(colorScheme).create();

    // Specific widget styles
    final appIconStylesProvider = AppIconStyleFactory(colorScheme, appIconConfig);
    final confirmDialogStylesProvider = ConfirmDialogStyleFactory(colorScheme, textButtonStyle, confirmDialog);
    final inputDecorationStyleFactory = InputDecorationStyleFactory(colorScheme);
    final callStatusStyleFactory = CallStatusStyleFactory(colorScheme, callStatuses);
    final elevatedButtonStyleFactory = ElevatedButtonStyleFactory(colorScheme, elevatedButton, defaultFontFamily);
    final textButtonStyleFactory = TextButtonStyleFactory(colorScheme);
    // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use_from_same_package
    final callActionsStyleFactory = CallActionsStyleFactory(colorScheme, callActions);
    final linkifyStyleFactory = LinkifyStyleFactory(colorScheme, linkify);
    final outlinedButtonStyleFactory = OutlinedButtonStyleFactory(colorScheme);
    final registrationStatusStyleFactory = RegisteredStatusStyleFactory(colorScheme, registrationStatuses);
    final snackBarStyleFactory = SnackBarStyleFactory(colorScheme, snackBar);
    final groupTitleListStyleFactory = GroupTitleListStyleFactory(colorScheme, groupTitleListTile, defaultFontFamily);
    final loginModeSelectStyleFactory = LoginModeSelectScreenStyleFactory(
      loginPageScheme.modeSelect,
      colorScheme,
      defaultFontFamily,
    );
    final leadingAvatarStyleFactory = LeadingAvatarStyleFactory(
      colorScheme,
      widgetConfig.imageAssets.leadingAvatarStyle,
      defaultFontFamily,
    );
    final keypadStyleFactory = KeypadStyleFactory(
      colorScheme,
      defaultFontFamily,
      config: null,
      textTheme: defaultTextTheme,
    );
    final embeddedRequestErrorDialogFactory = EmbeddedRequestErrorDialogFactory(imageAssetsConfig);

    // Screen-specific styles
    final aboutScreenStyleFactory = AboutScreenStyleFactory(pageConfig.about);
    final callScreenStyleFactory = CallScreenStyleFactory(colorScheme, callPageScheme, callActions, defaultFontFamily);
    final keypadScreenStyleFactory = KeypadScreenStyleFactory(
      colorScheme,
      defaultFontFamily,
      config: pageConfig.keypad,
      textTheme: defaultTextTheme,
    );
    final loginOtpSigninVerifyScreenStyleFactory = LoginOtpSigninVerifyScreenStyleFactory(
      colorScheme,
      loginPageScheme.otpSigninVerify,
    );
    final loginSignupVerifyScreenStyleFactory = LoginSignupVerifyScreenStyleFactory(
      colorScheme,
      loginPageScheme.signupVerify,
    );
    final loginSwitchScreenStyleFactory = LoginSwitchScreenStyleFactory(
      loginPageScheme.switchPage,
      colorScheme,
      defaultFontFamily,
    );
    final loginOtpSigninPageStyleFactory = LoginOtpSigninPageStyleFactory(
      colorScheme,
      defaultFontFamily,
      config: loginPageScheme.otpSignin,
      textTheme: defaultTextTheme,
    );
    final loginPasswordSigninPageStyleFactory = LoginPasswordSigninPageStyleFactory(
      colorScheme,
      defaultFontFamily,
      config: loginPageScheme.passwordSignin,
      textTheme: defaultTextTheme,
    );
    final settingsScreenStyleFactory = SettingsScreenStyleFactory(colorScheme, pageConfig.settings, defaultFontFamily);
    final contactsScreenStyleFactory = ContactsScreenStyleFactory(colorScheme, pageConfig.contacts);
    final recentsScreenStyleFactory = RecentsScreenStyleFactory(colorScheme, pageConfig.recents);
    final favoritesScreenStyleFactory = FavoritesScreenStyleFactory(colorScheme, pageConfig.favorites);
    final conversationsScreenStyleFactory = ConversationsScreenStyleFactory(colorScheme, pageConfig.conversations);
    final embeddedScreenStyleFactory = EmbeddedScreenStyleFactory(colorScheme, pageConfig.embedded);

    return <ThemeExtension?>[
      textButtonStyle,
      appIconStylesProvider.create(),
      confirmDialogStylesProvider.create(),
      inputDecorationStyleFactory.create(),
      callStatusStyleFactory.create(),
      elevatedButtonStyleFactory.create(),
      textButtonStyleFactory.create(),
      callActionsStyleFactory.create(),
      linkifyStyleFactory.create(),
      outlinedButtonStyleFactory.create(),
      registrationStatusStyleFactory.create(),
      snackBarStyleFactory.create(),
      groupTitleListStyleFactory.create(),
      loginModeSelectStyleFactory.create(),
      leadingAvatarStyleFactory.create(),
      keypadStyleFactory.create(),
      embeddedRequestErrorDialogFactory.create(),

      /// Screen-specific styles
      keypadScreenStyleFactory.create(),
      aboutScreenStyleFactory.create(),
      callScreenStyleFactory.create(),
      loginOtpSigninVerifyScreenStyleFactory.create(),
      loginSignupVerifyScreenStyleFactory.create(),
      loginSwitchScreenStyleFactory.create(),
      loginOtpSigninPageStyleFactory.create(),
      loginPasswordSigninPageStyleFactory.create(),
      settingsScreenStyleFactory.create(),
      contactsScreenStyleFactory.create(),
      recentsScreenStyleFactory.create(),
      favoritesScreenStyleFactory.create(),
      conversationsScreenStyleFactory.create(),
      embeddedScreenStyleFactory.create(),
    ].nonNulls.toList();
  }

  ElevatedButtonThemeData createElevatedButtonThemeData() {
    return ElevatedButtonThemeDataFactory(colorScheme).create();
  }

  OutlinedButtonThemeData createOutlinedButtonThemeData() {
    return OutlinedButtonThemeFataFactory(colorScheme).create();
  }

  TextButtonThemeData createTextButtonThemeData() {
    return TextButtonThemeDataFactory(colorScheme).create();
  }

  SnackBarThemeData createSnackBarThemeData() {
    return SnackBarThemeDataFactory(colorScheme).create();
  }

  ListTileThemeData createListTileThemeData() {
    return ListTileThemeDataFactory(colorScheme).create();
  }

  BottomNavigationBarThemeData createBottomNavigationBarThemeData() {
    return BottomNavigationBarThemeDataFactory(colorScheme, widgetConfig.bar.bottomNavigationBar).create();
  }

  TabBarThemeData createTabBarTheme() {
    return TabBarThemeDataFactory(
      colorScheme,
      widgetConfig.bar.tabBarConfig,
      defaultTextTheme.bodyMedium?.fontFamily,
    ).create();
  }

  AppBarTheme createAppBarTheme() {
    return AppBarThemeDataFactory(widgetConfig.bar.appBarConfig, defaultTextTheme.bodyMedium?.fontFamily).create();
  }

  InputDecorationTheme createInputDecorationTheme() {
    return InputDecorationThemeDataFactory(colorScheme, widgetConfig.input.primary).create();
  }

  TextSelectionThemeData createTextSelectionThemeData() {
    return TextSelectionThemeDataFactory(colorScheme, widgetConfig.text.selection).create();
  }

  ProgressIndicatorThemeData createProgressIndicatorThemeData() {
    return ProgressIndicatorThemeDataFactory(colorScheme).create();
  }
}
