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

    final appConfig = theme.appConfig;

    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(appConfig);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(appConfig, preferences);
      final settingsFeature = _tryConfigureSettingsFeature(appConfig, preferences);

      _instance = FeatureAccess._(customLoginFeature, bottomMenuManager, settingsFeature);
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
    final bottomMenu = appConfig.main?.bottomMenu;

    if (bottomMenu == null || bottomMenu.tabs.isEmpty) {
      throw Exception('Bottom menu configuration is missing or empty');
    }

    final bottomMenuTabs = <BottomMenuTab>[];

    for (var tab in bottomMenu.tabs.where((tab) => tab.enabled)) {
      final configData = tab.data == null
          ? null
          : ConfigData(
              url: Uri.parse(tab.data!.url),
            );

      final bottomMenuTab = BottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: MainFlavor.values.byName(tab.type),
        titleL10n: tab.titleL10n,
        icon: tab.icon,
        data: configData,
      );

      bottomMenuTabs.add(bottomMenuTab);
    }

    if (bottomMenuTabs.isEmpty) {
      throw Exception('No enabled tabs found in bottom menu configuration');
    }

    return BottomMenuFeature(
      bottomMenuTabs,
      preferences,
      cacheSelectedTab: bottomMenu.cacheSelectedTab,
    );
  }

  static SettingsFeature _tryConfigureSettingsFeature(
    AppConfig appConfig,
    AppPreferences preferences,
  ) {
    final settingSections = <SettingsSection>[];

    late final Uri termsAndConditions;

    for (var section in appConfig.settings!.sections.where((section) => section.enabled)) {
      final items = <SettingItem>[];

      for (var item in section.items.where((item) => item.enabled)) {
        final configData = item.data == null
            ? null
            : ConfigData(
                url: Uri.parse(item.data!.url),
                titleL10n: item.titleL10n,
              );

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon,
          data: configData,
          flavor: SettingsFlavor.values.byName(item.type!),
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

  static CustomLoginFeature? _tryEnableCustomLoginFeature(AppConfig appConfig) {
    final customLogin = appConfig.login?.customSignIn;

    if (appConfig.isCustomSignInEnabled) {
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

  final Uri termsAndConditions;

  SettingsFeature(this._sections, this.termsAndConditions);

  List<SettingsSection> get sections => List.unmodifiable(_sections);
}
