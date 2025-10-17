import 'package:flutter/material.dart';

import './styles/styles.dart';
import '../models/models.dart';

import 'theme_data/theme_data.dart';

// TODO(Serdun): Decompose correctly common widget styles configurations from t;he page styles configurations
class ThemeStyleFactoryProvider {
  ThemeStyleFactoryProvider({
    required this.colorScheme,
    required this.widgetConfig,
    required this.pageConfig,
    required this.seedThemeData,
  });

  final ColorScheme colorScheme;
  final ThemeWidgetConfig widgetConfig;
  final ThemePageConfig pageConfig;
  final ThemeData seedThemeData;

  List<ThemeExtension> createThemeExtensions() {
    // Page schema
    final loginPageScheme = pageConfig.login;
    final callPageScheme = pageConfig.dialing;

    // Widget images config
    final imageAssetsConfig = widgetConfig.imageAssets;

    // Other widgets config
    final appIconConfig = imageAssetsConfig.appIcon;
    final primaryGradientColorsConfig = widgetConfig.decorationConfig.primaryGradientColorsConfig;
    final confirmDialog = widgetConfig.dialog.confirmDialog;
    final snackBar = widgetConfig.dialog.snackBar;
    final actionPad = widgetConfig.actionPad;
    final callStatuses = widgetConfig.statuses.callStatuses;
    final registrationStatuses = widgetConfig.statuses.registrationStatuses;
    final elevatedButton = widgetConfig.button.primaryElevatedButton;
    final callActions = widgetConfig.group?.callActions;
    final groupTitleListTile = widgetConfig.group?.groupTitleListTile;
    final linkify = widgetConfig.text.linkify;

    // Common widget styles
    final textButtonStyle = TextButtonStyleFactory(colorScheme).create();

    // Specific widget styles
    final actionPadStyleFactory = ActionPadStyleFactory(colorScheme, actionPad);
    final appIconStylesProvider = AppIconStyleFactory(colorScheme, appIconConfig);
    final confirmDialogStylesProvider = ConfirmDialogStyleFactory(colorScheme, textButtonStyle, confirmDialog);
    final inputDecorationStyleFactory = InputDecorationStyleFactory(colorScheme);
    final callStatusStyleFactory = CallStatusStyleFactory(colorScheme, callStatuses);
    final elevatedButtonStyleFactory = ElevatedButtonStyleFactory(colorScheme, elevatedButton);
    final textButtonStyleFactory = TextButtonStyleFactory(colorScheme);
    // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use_from_same_package
    final callActionsStyleFactory = CallActionsStyleFactory(colorScheme, callActions);
    final linkifyStyleFactory = LinkifyStyleFactory(colorScheme, linkify);
    final outlinedButtonStyleFactory = OutlinedButtonStyleFactory(colorScheme);
    final registrationStatusStyleFactory = RegisteredStatusStyleFactory(colorScheme, registrationStatuses);
    final snackBarStyleFactory = SnackBarStyleFactory(colorScheme, snackBar);
    final groupTitleListStyleFactory = GroupTitleListStyleFactory(groupTitleListTile);
    final gradientsStyleFactory = GradientsStyleFactory(primaryGradientColorsConfig);

    final loginModeSelectStyleFactory = LoginModeSelectScreenStyleFactory(loginPageScheme.modeSelect, colorScheme);
    final leadingAvatarStyleFactory =
        LeadingAvatarStyleFactory(colorScheme, widgetConfig.imageAssets.leadingAvatarStyle);
    final keypadStyleFactory = KeypadStyleFactory(colorScheme, config: null, textTheme: createTextTheme());

    // Screen-specific styles
    final aboutScreenStyleFactory = AboutScreenStyleFactory(pageConfig.about);
    final callScreenStyleFactory = CallScreenStyleFactory(colorScheme, callPageScheme, callActions);
    final keypadScreenStyleFactory =
        KeypadScreenStyleFactory(colorScheme, config: pageConfig.keypad, textTheme: createTextTheme());
    final loginOtpSigninVerifyScreenStyleFactory =
        LoginOtpSigninVerifyScreenStyleFactory(colorScheme, loginPageScheme.otpSigninVerify);
    final loginSignupVerifyScreenStyleFactory =
        LoginSignupVerifyScreenStyleFactory(colorScheme, loginPageScheme.signupVerify);
    final loginSwitchScreenStyleFactory = LoginSwitchScreenStyleFactory(loginPageScheme.switchPage, colorScheme);

    return <ThemeExtension?>[
      textButtonStyle,
      appIconStylesProvider.create(),
      confirmDialogStylesProvider.create(),
      actionPadStyleFactory.create(),
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
      gradientsStyleFactory.create(),

      loginModeSelectStyleFactory.create(),
      leadingAvatarStyleFactory.create(),
      keypadStyleFactory.create(),

      /// Screen-specific styles
      keypadScreenStyleFactory.create(),
      aboutScreenStyleFactory.create(),
      callScreenStyleFactory.create(),
      loginOtpSigninVerifyScreenStyleFactory.create(),
      loginSignupVerifyScreenStyleFactory.create(),
      loginSwitchScreenStyleFactory.create()
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
    return TabBarThemeDataFactory(colorScheme, widgetConfig.bar.extTabBar).create();
  }

  AppBarTheme createAppBarTheme() {
    return AppBarThemeDataFactory(colorScheme, widgetConfig.bar.extTabBar).create();
  }

  InputDecorationTheme createInputDecorationTheme() {
    return InputDecorationThemeDataFactory(colorScheme, widgetConfig.input.primary).create();
  }

  TextSelectionThemeData createTextSelectionThemeData() {
    return TextSelectionThemeDataFactory(colorScheme, widgetConfig.text.selection).create();
  }

  TextTheme createTextTheme() {
    return TextThemeDataFactory(colorScheme, widgetConfig.fonts, seedThemeData).create();
  }
}
