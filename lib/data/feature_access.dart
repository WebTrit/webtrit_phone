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

  FeatureAccess._(this.customLoginFeature, this.bottomMenuFeature);

  final CustomLoginFeature? customLoginFeature;
  final BottomMenuFeature bottomMenuFeature;

  static Future<void> init() async {
    final theme = AppThemes();
    final preferences = AppPreferences();

    final uiComposeSettings = theme.uiComposeSettings;

    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(uiComposeSettings);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(uiComposeSettings, preferences);

      _instance = FeatureAccess._(customLoginFeature, bottomMenuManager);
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
      );
    }).toList();

    if (bottomMenuTabs.isEmpty) {
      throw Exception('Bottom menu configuration is empty');
    }

    return BottomMenuFeature(bottomMenuTabs, preferences, cacheSelectedTab: bottomMenu.cacheSelectedTab);
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
    _activeTab = (preferencesPath != null
        ? tabs.firstWhereOrNull((tab) => tab.flavor == preferencesPath)
        : tabs.firstWhereOrNull((tab) => tab.initial) ?? _tabs.first)!;
  }

  bool isTabEnabled(MainFlavor flavor) {
    return tabs.any((tab) => tab.flavor == flavor && tab.enabled);
  }

  set activeFlavor(BottomMenuTab flavor) {
    _appPreferences.setActiveMainFlavor(flavor.flavor);
    _activeTab = flavor;
  }
}
