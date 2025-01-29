import 'package:flutter/material.dart';

import './styles/styles.dart';
import '../models/models.dart';

import 'theme_data/theme_data.dart';

// TODO(Serdun): Decompose correctly common widget styles configurations from t;he page styles configurations
class ThemeStyleFactoryProvider {
  final ColorScheme colorScheme;
  final ThemeWidgetConfig widgetConfig;
  final ThemePageConfig pageConfig;

  ThemeStyleFactoryProvider({
    required this.colorScheme,
    required this.widgetConfig,
    required this.pageConfig,
  });

  List<ThemeExtension> createFactory() {
    // Page schema
    final loginPageScheme = pageConfig.login;

    // Widget schema
    final pictureConfig = widgetConfig.picture;
    final appIconConfig = pictureConfig.appIcon;
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
    final callActionsStyleFactory = CallActionsStyleFactory(colorScheme, callActions);
    final linkifyStyleFactory = LinkifyStyleFactory(colorScheme, linkify);
    final logoAssetStyleFactory = LogoAssetsFactory(pictureConfig);
    final outlinedButtonStyleFactory = OutlinedButtonStyleFactory(colorScheme);
    final registrationStatusStyleFactory = RegisteredStatusStyleFactory(colorScheme, registrationStatuses);
    final snackBarStyleFactory = SnackBarStyleFactory(colorScheme, snackBar);
    final groupTitleListStyleFactory = GroupTitleListStyleFactory(groupTitleListTile);
    final onPictureLogoStyleFactory = OnboardingPictureLogoStyleFactory(colorScheme, pictureConfig, loginPageScheme);
    final onLogoStyleFactory = OnboardingLogoStyleFactory(colorScheme, pictureConfig, loginPageScheme);
    final gradientsStyleFactory = GradientsStyleFactory(primaryGradientColorsConfig);
    final aboutScreenStyleFactory = AboutScreenStyleFactory(loginPageScheme);
    final loginModeSelectStyleFactory = LoginModeSelectScreenStyleFactory(loginPageScheme.modeSelect);

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
      logoAssetStyleFactory.create(),
      outlinedButtonStyleFactory.create(),
      registrationStatusStyleFactory.create(),
      snackBarStyleFactory.create(),
      groupTitleListStyleFactory.create(),
      onPictureLogoStyleFactory.create(),
      onLogoStyleFactory.create(),
      gradientsStyleFactory.create(),
      aboutScreenStyleFactory.create(),
      loginModeSelectStyleFactory.create()
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

  TabBarTheme createTabBarTheme() {
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
}
