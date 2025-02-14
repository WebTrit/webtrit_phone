import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

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
    this.messagingFeature,
  );

  final LoginFeature loginFeature;
  final BottomMenuFeature bottomMenuFeature;
  final SettingsFeature settingsFeature;
  final CallFeature callFeature;
  final MessagingFeature messagingFeature;

  static FeatureAccess init(AppConfig appConfig, AppPreferences preferences) {
    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(appConfig.loginConfig);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(appConfig, preferences);
      final settingsFeature = _tryConfigureSettingsFeature(appConfig, preferences);
      final callFeature = _tryConfigureCallFeature(appConfig);
      final messagingFeature = _tryConfigureMessagingFeature(appConfig, preferences);

      _instance = FeatureAccess._(
        customLoginFeature,
        bottomMenuManager,
        settingsFeature,
        callFeature,
        messagingFeature,
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
    return _instance;
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

  static BottomMenuTab _createBottomMenuTab(BottomMenuTabScheme tab) {
    final flavor = MainFlavor.values.byName(tab.type.name);

    return tab.when(
      base: (enabled, initial, type, titleL10n, icon) => BottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: flavor,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      contacts: (enabled, initial, type, titleL10n, icon, contactSourceTypes) => ContactsBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: flavor,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
        contactSourceTypes: contactSourceTypes.map((type) => ContactSourceType.values.byName(type)).toList(),
      ),
      embedded: (enabled, initial, type, titleL10n, icon, data) => BottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        flavor: flavor,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
    );
  }

  static SettingsFeature _tryConfigureSettingsFeature(
    AppConfig appConfig,
    AppPreferences preferences,
  ) {
    final settingSections = <SettingsSection>[];

    for (var section in appConfig.settingsConfig.sections.where((section) => section.enabled)) {
      final items = <SettingItem>[];

      for (var item in section.items.where((item) => item.enabled)) {
        final embeddedDataResourceUrl = item.embeddedData?.uriOrNull;
        final data = embeddedDataResourceUrl == null ? null : ConfigData(resource: embeddedDataResourceUrl);
        final flavor = SettingsFlavor.values.byName(item.type);

        // TODO (Serdun): Move platform-specific configuration to a separate config file.
        // Currently, the settings screen includes this configuration only for Android.
        // For other platforms, this item is hidden. Update the logic to handle configurations for all platforms.
        if (flavor == SettingsFlavor.network && !kIsWeb && !Platform.isAndroid) continue;

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon.toIconData(),
          data: data,
          flavor: SettingsFlavor.values.byName(item.type),
        );

        items.add(settingItem);
      }

      settingSections.add(
        SettingsSection(
          titleL10n: section.titleL10n,
          items: items,
        ),
      );
    }

    return SettingsFeature(settingSections);
  }

  static LoginFeature _tryEnableCustomLoginFeature(AppConfigLogin loginConfig) {
    final buttons = <LoginModeAction>[];

    final launchEmbeddedScreen = _toLoginEmbeddedModel(
      loginConfig.embedded.firstWhereOrNull((embeddedScreen) => embeddedScreen.attributes['launch'] == true),
    );

    for (var actions in loginConfig.modeSelectActions.where((button) => button.enabled)) {
      final flavor = LoginFlavor.values.byName(actions.type);
      final loginEmbeddedScreen = loginConfig.embedded.firstWhereOrNull((dto) => dto.id == actions.embeddedId);

      if (flavor == LoginFlavor.embedded && loginEmbeddedScreen != null) {
        buttons.add(LoginEmbeddedModeButton(
          titleL10n: actions.titleL10n,
          flavor: flavor,
          customLoginFeature: _toLoginEmbeddedModel(loginEmbeddedScreen)!,
        ));
      } else if (flavor == LoginFlavor.login) {
        buttons.add(LoginModeAction(
          titleL10n: actions.titleL10n,
          flavor: flavor,
        ));
      }
    }

    return LoginFeature(
      titleL10n: loginConfig.greetingL10n,
      actions: buttons,
      launchLoginPage: launchEmbeddedScreen,
    );
  }

  static LoginEmbedded? _toLoginEmbeddedModel(EmbeddedResource? resource) {
    return resource?.uri != null
        ? LoginEmbedded(
            titleL10n: resource!.toolbar.titleL10n,
            showToolbar: resource.toolbar.showToolbar,
            resource: resource.uriOrNull!,
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

  static MessagingFeature _tryConfigureMessagingFeature(AppConfig appConfig, AppPreferences preferences) {
    final tabEnabled = appConfig.mainConfig.bottomMenu.tabs.any((tab) {
      return tab.type.name == MainFlavor.messaging.name && tab.enabled;
    });
    return MessagingFeature(preferences, tabEnabled: tabEnabled);
  }
}

class LoginFeature {
  final String? titleL10n;
  final List<LoginModeAction> actions;
  final LoginEmbedded? launchLoginPage;

  LoginFeature({
    required this.titleL10n,
    required this.actions,
    required this.launchLoginPage,
  });

  bool get hasEmbeddedPage => actions.any((flavor) => flavor.flavor == LoginFlavor.embedded);
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

  BottomMenuTab? getTabEnabled(MainFlavor flavor) {
    return tabs.firstWhereOrNull((tab) => tab.flavor == flavor);
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

  SettingItem? get termsAndConditions => _sections.expand((section) => section.items).firstWhereOrNull(
        (item) => item.flavor == SettingsFlavor.terms,
      );

  bool get isSelfConfigEnabled => _sections.any((section) {
        return section.items.any((item) {
          return item.flavor == SettingsFlavor.selfConfig;
        });
      });
}

class CallFeature {
  final bool videoEnable;
  final TransferConfig transfer;

  CallFeature({
    required this.videoEnable,
    required this.transfer,
  });
}

class MessagingFeature {
  MessagingFeature(this._appPreferences, {bool tabEnabled = false}) : _tabEnabled = tabEnabled;

  final AppPreferences _appPreferences;
  final bool _tabEnabled;

  List<String> get _coreSupportedFeatures {
    final systemInfo = _appPreferences.getSystemInfo();
    return systemInfo?.adapter?.supported ?? [];
  }

  /// Check if the SMS messaging feature is supported by remote system.
  bool get coreSmsSupport => _coreSupportedFeatures.contains(kSmsMessagingFeatureFlag);

  /// Check if the internal messaging feature is supported by remote system.
  bool get coreChatsSupport => _coreSupportedFeatures.contains(kChatMessagingFeatureFlag);

  /// Check if the messaging tab is enabled within the app configuration.
  bool get tabEnabled => _tabEnabled;

  /// Check if any messaging feature is enabled.
  /// This is used to determine if messaging services should be initialized or can be skipped.
  bool get anyMessagingEnabled => (coreSmsSupport || coreChatsSupport) && tabEnabled;

  /// Check if the SMS messaging feature is enabled and supported by remote system.
  /// This is used to determine if SMS messaging UI components should be displayed or hidden.
  bool get smsPresent => coreSmsSupport && tabEnabled;

  /// Check if the internal messaging feature is enabled and supported by remote system.
  /// This is used to determine if internal messaging UI components should be displayed or hidden.
  bool get chatsPresent => coreChatsSupport && tabEnabled;
}
