import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/models/models.dart';

import 'app_themes.dart';

final Logger _logger = Logger('FeatureAccess');

// This class handles more than just data, as it encapsulates logic for configuring features.
// Consider moving it into dedicated service components to improve separation of concerns
// and maintainability.
class FeatureAccess {
  static late FeatureAccess _instance;

  FeatureAccess._(
    this.loginFeature,
    this.bottomMenuFeature,
    this.settingsFeature,
    this.callFeature,
  );

  final LoginFeature loginFeature;
  final BottomMenuFeature bottomMenuFeature;
  final SettingsFeature settingsFeature;
  final CallFeature callFeature;

  static Future<void> init() async {
    final theme = AppThemes();
    final preferences = AppPreferences();

    final appConfig = theme.appConfig;

    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(appConfig.loginConfig);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(appConfig, preferences);
      final settingsFeature = _tryConfigureSettingsFeature(appConfig, preferences);
      final callFeature = _tryConfigureCallFeature(appConfig);

      _instance = FeatureAccess._(customLoginFeature, bottomMenuManager, settingsFeature, callFeature);
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
  }

  factory FeatureAccess() => _instance;

  static BottomMenuFeature _tryConfigureBottomMenuFeature(
    AppConfig appConfig,
    AppPreferences preferences,
  ) {
    final bottomMenu = appConfig.mainConfig.bottomMenu;

    if (bottomMenu.tabs.isEmpty) {
      throw Exception('Bottom menu configuration is missing or empty');
    }

    final bottomMenuTabs = bottomMenu.tabs.where((tab) => tab.enabled).map((tab) => _createBottomMenuTab(tab)).toList();

    if (bottomMenuTabs.isEmpty) {
      throw Exception('No enabled tabs found in bottom menu configuration');
    }

    return BottomMenuFeature(
      bottomMenuTabs,
      preferences,
      cacheSelectedTab: bottomMenu.cacheSelectedTab,
    );
  }

  static BottomMenuTab _createBottomMenuTab(AppConfigBottomMenuTab tab) {
    final flavor = MainFlavor.values.byName(tab.type);
    final urlString = tab.data[AppConfigBottomMenuTab.dataUrl] as String?;
    final data = urlString == null ? null : ConfigData(url: Uri.parse(urlString));

    if (flavor == MainFlavor.contacts) {
      final sourceTypesList = (tab.data[AppConfigBottomMenuTab.dataContactSourceTypes] as List<dynamic>).cast<String>();
      final sourceTypes = sourceTypesList.map((type) => ContactSourceType.values.byName(type)).toList();

      return ContactsBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: flavor,
        titleL10n: tab.titleL10n,
        icon: tab.icon,
        data: data,
        contactSourceTypes: sourceTypes,
      );
    } else {
      return BottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: flavor,
        titleL10n: tab.titleL10n,
        icon: tab.icon,
        data: data,
      );
    }
  }

  static SettingsFeature _tryConfigureSettingsFeature(
    AppConfig appConfig,
    AppPreferences preferences,
  ) {
    final settingSections = <SettingsSection>[];

    late final Uri termsAndConditions;

    for (var section in appConfig.settingsConfig.sections.where((section) => section.enabled)) {
      final items = <SettingItem>[];

      for (var item in section.items.where((item) => item.enabled)) {
        final urlString = item.data[AppConfigBottomMenuTab.dataUrl] as String?;
        final data = urlString == null ? null : ConfigData(url: Uri.parse(urlString));

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon,
          data: data,
          flavor: SettingsFlavor.values.byName(item.type),
        );

        if (settingItem.flavor == SettingsFlavor.terms) {
          if (settingItem.data?.url != null) {
            termsAndConditions = settingItem.data!.url;
          } else {
            throw Exception('Terms and conditions not found');
          }
        }
        items.add(settingItem);
      }

      settingSections.add(
        SettingsSection(
          titleL10n: section.titleL10n,
          items: items,
        ),
      );
    }

    return SettingsFeature(settingSections, termsAndConditions);
  }

  static LoginFeature _tryEnableCustomLoginFeature(AppConfigLogin loginConfig) {
    final buttons = <LoginModeAction>[];

    final launchEmbeddedScreen = _toEmbeddedLoginModel(
      loginConfig.embedded.firstWhereOrNull((embeddedScreen) => embeddedScreen.launch),
    );

    for (var actions in loginConfig.modeSelectActions.where((button) => button.enabled)) {
      final flavor = LoginFlavor.values.byName(actions.type);
      final loginEmbeddedScreen = loginConfig.embedded.firstWhereOrNull((dto) => dto.id == actions.embeddedId);

      if (flavor == LoginFlavor.embedded && loginEmbeddedScreen != null) {
        buttons.add(EmbeddedLoginModeButton(
          titleL10n: actions.titleL10n,
          flavor: flavor,
          customLoginFeature: _toEmbeddedLoginModel(loginEmbeddedScreen)!,
        ));
      } else if (flavor == LoginFlavor.login) {
        buttons.add(LoginModeAction(
          titleL10n: actions.titleL10n,
          flavor: flavor,
        ));
      }
    }

    return LoginFeature(
      actions: buttons,
      launchLoginPage: launchEmbeddedScreen,
    );
  }

  static EmbeddedLogin? _toEmbeddedLoginModel(AppConfigLoginEmbedded? embeddedDTO) {
    return embeddedDTO != null
        ? EmbeddedLogin(
            titleL10n: embeddedDTO.titleL10n,
            url: Uri.parse(embeddedDTO.url),
            showToolbar: embeddedDTO.showToolbar,
          )
        : null;
  }

  static CallFeature _tryConfigureCallFeature(AppConfig appConfig) {
    final callConfig = appConfig.callConfig;

    return CallFeature(
      videoEnable: callConfig.videoEnabled,
      transfer: TransferConfig(
        enableBlindTransfer: callConfig.transfer.enableBlindTransfer,
        enableAttendedTransfer: callConfig.transfer.enableAttendedTransfer,
      ),
    );
  }
}

class LoginFeature {
  final List<LoginModeAction> actions;
  final EmbeddedLogin? launchLoginPage;

  LoginFeature({
    required this.actions,
    required this.launchLoginPage,
  });
}

class BottomMenuFeature {
  final List<BottomMenuTab> _tabs;
  late BottomMenuTab _activeTab;

  final AppPreferences _appPreferences;

  List<BottomMenuTab> get tabs => List.unmodifiable(_tabs);

  BottomMenuTab get activeTab => _activeTab;

  int get activeIndex => tabs.indexOf(_activeTab);

  BottomMenuFeature(
    this._tabs,
    this._appPreferences, {
    bool cacheSelectedTab = true,
  }) {
    final preferencesPath = cacheSelectedTab ? _appPreferences.getActiveMainFlavor() : null;
    _activeTab = (preferencesPath != null && tabs.any((tab) => tab.flavor == preferencesPath)
        ? tabs.firstWhereOrNull((tab) => tab.flavor == preferencesPath)
        : tabs.firstWhereOrNull((tab) => tab.initial) ?? _tabs.first)!;

    _logger.info('Active tab: ${_activeTab.flavor}');
  }

  bool isTabEnabled(MainFlavor flavor) {
    return tabs.any((tab) => tab.flavor == flavor && tab.enabled);
  }

  set activeFlavor(BottomMenuTab flavor) {
    _appPreferences.setActiveMainFlavor(flavor.flavor);
    _activeTab = flavor;
  }
}

class SettingsFeature {
  final List<SettingsSection> _sections;

  final Uri termsAndConditions;

  SettingsFeature(this._sections, this.termsAndConditions);

  List<SettingsSection> get sections => List.unmodifiable(_sections);
}

class CallFeature {
  final bool videoEnable;
  final TransferConfig transfer;

  CallFeature({
    required this.videoEnable,
    required this.transfer,
  });
}
