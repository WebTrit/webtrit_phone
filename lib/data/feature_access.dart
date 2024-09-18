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
    this.customLoginFeature,
    this.bottomMenuFeature,
    this.settingsFeature,
  );

  final CustomLoginFeature? customLoginFeature;
  final BottomMenuFeature bottomMenuFeature;
  final SettingsFeature settingsFeature;

  static Future<void> init() async {
    final theme = AppThemes();
    final preferences = AppPreferences();

    final uiComposeSettings = theme.uiComposeSettings;

    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(uiComposeSettings);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(uiComposeSettings, preferences);
      final settingsFeature = _tryConfigureSettingsFeature(uiComposeSettings, preferences);

      _instance = FeatureAccess._(customLoginFeature, bottomMenuManager, settingsFeature);
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
  }

  factory FeatureAccess() => _instance;

  static BottomMenuFeature _tryConfigureBottomMenuFeature(
    UiComposeSettings uiComposeSettings,
    AppPreferences preferences,
  ) {
    final bottomMenu = uiComposeSettings.main?.bottomMenu;
    if (bottomMenu == null || bottomMenu.tabs.isEmpty) {
      throw Exception('Bottom menu configuration is missing or empty');
    }

    final bottomMenuTabs = bottomMenu.tabs.where((tab) => tab.enabled).map((tab) {
      return BottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: MainFlavor.values.byName(tab.type),
        titleL10n: tab.titleL10n,
        icon: tab.icon,
        data: tab.data != null ? ConfigData.url(tab.data!.url) : null,
      );
    }).toList();

    if (bottomMenuTabs.isEmpty) {
      throw Exception('Bottom menu configuration is empty');
    }

    return BottomMenuFeature(bottomMenuTabs, preferences, cacheSelectedTab: bottomMenu.cacheSelectedTab);
  }

  static SettingsFeature _tryConfigureSettingsFeature(
    UiComposeSettings uiComposeSettings,
    AppPreferences preferences,
  ) {
    final settingSections = uiComposeSettings.settings?.sections.where((section) => section.enabled).map((section) {
      return SettingsSection(
        titleL10n: section.titleL10n,
        items: section.items.where((item) => item.enabled).map((item) {
          return SettingItem(
            titleL10n: item.titleL10n,
            icon: item.icon,
            data: item.data != null ? ConfigData.url(item.data!.url) : null,
            flavor: SettingsFlavor.values.byName(item.type!),
          );
        }).toList(),
      );
    }).toList();

    return SettingsFeature(settingSections!);
  }

  static CustomLoginFeature? _tryEnableCustomLoginFeature(UiComposeSettings uiComposeSettings) {
    final customLogin = uiComposeSettings.login?.customSignIn;

    if (uiComposeSettings.isCustomSignInEnabled) {
      _logger.info('Custom sign-in is enabled');

      return CustomLoginFeature(
        titleL10n: customLogin!.titleL10n!,
        uri: Uri.parse(customLogin.url!),
      );
    } else {
      _logger.info('Custom sign-in is disabled');
      return null;
    }
  }
}

class BottomMenuFeature {
  final List<BottomMenuTab> _tabs;
  final AppPreferences _appPreferences;
  late BottomMenuTab _activeTab;

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

  SettingsFeature(this._sections);

  List<SettingsSection> get sections => List.unmodifiable(_sections);
}
