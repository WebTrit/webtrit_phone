import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
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
    final groupTitleListTile = widgetConfig.group?.groupTitleListTile;
    final linkify = widgetConfig.text.linkify;

    // Specific widget styles
    final appIconStylesProvider = AppIconStyleFactory(colorScheme, appIconConfig);
    final confirmDialogStylesProvider = ConfirmDialogStyleFactory(colorScheme, confirmDialog, defaultFontFamily);
    final inputDecorationStyleFactory = InputDecorationStyleFactory(colorScheme);
    final callStatusStyleFactory = CallStatusStyleFactory(colorScheme, callStatuses);
    final elevatedButtonStyleFactory = ElevatedButtonStyleFactory(colorScheme, elevatedButton, defaultFontFamily);
    final linkifyStyleFactory = LinkifyStyleFactory(colorScheme, linkify);
    final outlinedButtonStyleFactory = OutlinedButtonStyleFactory(colorScheme);
    final registrationStatusStyleFactory = RegisteredStatusStyleFactory(colorScheme, registrationStatuses);
    final snackBarStyleFactory = SnackBarStyleFactory(colorScheme, snackBar);
    final groupTitleListStyleFactory = GroupTitleListStyleFactory(colorScheme, groupTitleListTile, defaultFontFamily);
    final loginModeSelectStyleFactory = LoginModeSelectScreenStyleFactory(
      loginPageScheme.modeSelect,
      colorScheme,
      defaultFontFamily,
      appBarTheme: _pageAppBarThemeWithDefault(
        loginPageScheme.modeSelect.appBarStyle,
        const AppBarConfig(backgroundColor: '#00000000'),
      ),
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
    final aboutScreenStyleFactory = AboutScreenStyleFactory(
      pageConfig.about,
      appBarTheme: _pageAppBarTheme(pageConfig.about.appBarStyle),
    );
    final callScreenStyleFactory = CallScreenStyleFactory(colorScheme, callPageScheme, defaultFontFamily);
    final keypadScreenStyleFactory = KeypadScreenStyleFactory(
      colorScheme,
      defaultFontFamily,
      config: pageConfig.keypad,
      textTheme: defaultTextTheme,
      appBarTheme: _pageAppBarTheme(pageConfig.keypad.appBarStyle),
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
      appBarTheme: _pageAppBarThemeWithDefault(
        loginPageScheme.switchPage.appBarStyle,
        const AppBarConfig(backgroundColor: '#00000000'),
      ),
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
    final settingsScreenStyleFactory = SettingsScreenStyleFactory(
      colorScheme,
      pageConfig.settings,
      defaultFontFamily,
      appBarTheme: _pageAppBarTheme(pageConfig.settings.appBarStyle),
    );
    final contactsScreenStyleFactory = ContactsScreenStyleFactory(
      colorScheme,
      pageConfig.contacts,
      appBarTheme: _pageAppBarTheme(pageConfig.contacts.appBarStyle),
    );
    final recentsScreenStyleFactory = RecentsScreenStyleFactory(
      colorScheme,
      pageConfig.recents,
      appBarTheme: _pageAppBarTheme(pageConfig.recents.appBarStyle),
    );
    final favoritesScreenStyleFactory = FavoritesScreenStyleFactory(
      colorScheme,
      pageConfig.favorites,
      appBarTheme: _pageAppBarTheme(pageConfig.favorites.appBarStyle),
    );
    final conversationsScreenStyleFactory = ConversationsScreenStyleFactory(
      colorScheme,
      pageConfig.conversations,
      appBarTheme: _pageAppBarTheme(pageConfig.conversations.appBarStyle),
    );
    final embeddedScreenStyleFactory = EmbeddedScreenStyleFactory(
      colorScheme,
      pageConfig.embedded,
      appBarTheme: _pageAppBarTheme(pageConfig.embedded.appBarStyle),
    );
    final numberCdrsScreenStyleFactory = NumberCdrsScreenStyleFactory(
      colorScheme,
      pageConfig.numberCdrs,
      // A deliberately chrome-less screen: when the theme does not configure
      // this page's bar, default to a transparent one.
      appBarTheme: _pageAppBarThemeWithDefault(
        pageConfig.numberCdrs.appBarStyle,
        const AppBarConfig(backgroundColor: '#00000000'),
      ),
    );
    final loginCoreUrlAssignScreenStyleFactory = LoginCoreUrlAssignScreenStyleFactory(
      loginPageScheme.coreUrlAssign,
      colorScheme,
      appBarTheme: _pageAppBarThemeWithDefault(
        loginPageScheme.coreUrlAssign.appBarStyle,
        const AppBarConfig(backgroundColor: '#00000000'),
      ),
    );

    return <ThemeExtension?>[
      appIconStylesProvider.create(),
      confirmDialogStylesProvider.create(),
      inputDecorationStyleFactory.create(),
      callStatusStyleFactory.create(),
      elevatedButtonStyleFactory.create(),
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
      numberCdrsScreenStyleFactory.create(),
      loginCoreUrlAssignScreenStyleFactory.create(),
    ].nonNulls.toList();
  }

  AppBarTheme? _pageAppBarTheme(AppBarConfig? pageStyle) {
    if (pageStyle == null) return null;
    return AppBarThemeDataFactory(
      colorScheme,
      pageStyle.mergeOver(widgetConfig.bar.appBarConfig),
      defaultTextTheme.bodyMedium?.fontFamily,
    ).create();
  }

  /// Like [_pageAppBarTheme], but a screen's design default sits UNDER the
  /// page style, so a partial page override keeps the default's other fields.
  AppBarTheme? _pageAppBarThemeWithDefault(AppBarConfig? pageStyle, AppBarConfig designDefault) {
    return _pageAppBarTheme(pageStyle == null ? designDefault : pageStyle.mergeOver(designDefault));
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

  DialogThemeData createDialogThemeData() {
    return DialogThemeDataFactory(
      colorScheme,
      widgetConfig.dialog.theme,
      defaultTextTheme.bodyMedium?.fontFamily,
    ).create();
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
    return AppBarThemeDataFactory(
      colorScheme,
      widgetConfig.bar.appBarConfig,
      defaultTextTheme.bodyMedium?.fontFamily,
    ).create();
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
