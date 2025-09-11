import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

final Logger _logger = Logger('FeatureAccess');

/// This class encapsulates the logic for configuring and managing various app features,
/// including login, bottom menu, settings, calls, messaging, and terms.
/// It initializes these features based on the provided `AppConfig` and `AppPreferences`.
///
/// Configuration Overview:
///
/// 1. **LoginFeature**: Configures custom login options, including embedded login screens
///    and available login actions. The login configuration is based on the data in `AppConfig`.
///
/// 2. **BottomMenuFeature**: Configures the bottom navigation menu, enabling/disabling specific tabs,
///    setting the initial tab, and caching the active tab preference. The tab configuration is sourced
///    from `AppConfig.mainConfig.bottomMenu`.
///
/// 3. **SettingsFeature**: Configures the app’s settings screen by defining sections and items
///    based on the platform and the app configuration. It also handles embedded resources for settings items.
///    - **Embedded Resources**: Each setting item can either have an embedded resource linked via an `embeddedResourceId`
///      or by matching the resource’s type. Resources are first searched by ID, and if not found, the class searches
///      by type (e.g., `terms` for privacy policy).
///    - **Resource Assignment Priority**:
///      - **First**, the `embeddedResourceId` within the setting item is checked.
///      - **Second**, if no `embeddedResourceId` is found, the resource is searched based on its type (e.g., `terms`).
///    - **Terms Handling**: If a setting item is related to terms (e.g., privacy policy) and no `embeddedResourceId`
///      is provided, `TermsFeature` is used to assign the appropriate terms resource.
///
/// 4. **CallFeature**: Configures call-related settings, including video call support,
///    and configurations for call transfer and encoding. The call configuration is derived from `AppConfig.callConfig`.
///
/// 5. **MessagingFeature**: Configures messaging features, including SMS and internal chat support, based on the
///    system's capabilities and the app configuration. It determines whether the messaging tab is displayed in the app
///    and enables corresponding messaging features.
///
/// 6. **TermsFeature**: Configures access to privacy policy and terms resources. It retrieves the privacy policy URL
///    from embedded resources and assigns it to the appropriate settings item when needed.

// TODO(Serdun): Replace direct usage of AppConfig.embeddedResources with EmbeddedFeature.embeddedResources
class FeatureAccess {
  static late FeatureAccess _instance;

  FeatureAccess._(
    this.embeddedFeature,
    this.loginFeature,
    this.bottomMenuFeature,
    this.settingsFeature,
    this.callFeature,
    this.messagingFeature,
    this.termsFeature,
    this.systemNotificationsFeature,
    this.sipPresenceFeature,
  );

  final EmbeddedFeature embeddedFeature;
  final LoginFeature loginFeature;
  final BottomMenuFeature bottomMenuFeature;
  final SettingsFeature settingsFeature;
  final CallFeature callFeature;
  final MessagingFeature messagingFeature;
  final TermsFeature termsFeature;
  final SystemNotificationsFeature systemNotificationsFeature;
  final SipPresenceFeature sipPresenceFeature;

  static FeatureAccess init(AppConfig appConfig, AppPreferences preferences) {
    try {
      final embeddedFeature = _tryConfigureEmbeddedFeature(appConfig);
      final customLoginFeature = _tryEnableCustomLoginFeature(appConfig, embeddedFeature.embeddedResources);
      final bottomMenuManager = _tryConfigureBottomMenuFeature(appConfig, preferences, embeddedFeature);
      final settingsFeature = _tryConfigureSettingsFeature(appConfig, preferences);
      final callFeature = _tryConfigureCallFeature(appConfig, preferences);
      final messagingFeature = _tryConfigureMessagingFeature(appConfig, preferences);
      final termsFeature = _tryConfigureTermsFeature(appConfig);
      final systemNotificationsFeature = _tryConfigureSystemNotificationsFeature(preferences, appConfig);
      final sipPresenceFeature = _tryConfigureSipPresenceFeature(preferences, appConfig);

      _instance = FeatureAccess._(
        embeddedFeature,
        customLoginFeature,
        bottomMenuManager,
        settingsFeature,
        callFeature,
        messagingFeature,
        termsFeature,
        systemNotificationsFeature,
        sipPresenceFeature,
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
    EmbeddedFeature embeddedFeature,
  ) {
    final bottomMenu = appConfig.mainConfig.bottomMenu;

    if (bottomMenu.tabs.isEmpty) {
      throw Exception('Bottom menu configuration is missing or empty');
    }

    final bottomMenuTabs = bottomMenu.tabs
        .where((tab) => tab.enabled)
        .map((tab) => _createBottomMenuTab(tab, embeddedFeature.embeddedResources))
        .toList();

    if (bottomMenuTabs.isEmpty) {
      throw Exception('No enabled tabs found in bottom menu configuration');
    }

    return BottomMenuFeature(
      bottomMenuTabs,
      preferences,
      cacheSelectedTab: bottomMenu.cacheSelectedTab,
    );
  }

  static BottomMenuTab _createBottomMenuTab(BottomMenuTabScheme tab, List<EmbeddedData> embeddedResources) {
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
      embedded: (enabled, initial, type, titleL10n, icon, embeddedId) {
        final embeddedResource = embeddedResources.firstWhereOrNull((resource) => resource.id == embeddedId);
        return EmbeddedBottomMenuTab(
          id: embeddedId,
          enabled: tab.enabled,
          initial: tab.initial,
          flavor: flavor,
          titleL10n: tab.titleL10n,
          icon: tab.icon.toIconData(),
          data: embeddedResource,
        );
      },
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
        final flavor = SettingsFlavor.values.byName(item.type);

        if (!_isSupportedPlatform(flavor)) continue;
        if (!_isSupportedCore(flavor, preferences)) continue;

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon.toIconData(),
          data: _getEmbeddedDataResource(appConfig, item, flavor),
          flavor: SettingsFlavor.values.byName(item.type),
        );

        items.add(settingItem);
      }

      // Skip empty sections
      if (items.isNotEmpty) {
        settingSections.add(
          SettingsSection(
            titleL10n: section.titleL10n,
            items: items,
          ),
        );
      }
    }

    return SettingsFeature(settingSections, preferences);
  }

  // TODO (Serdun): Move platform-specific configuration to a separate config file.
  // Currently, the settings screen includes this configuration only for Android.
  // For other platforms, this item is hidden. Update the logic to handle configurations for all platforms.
  static bool _isSupportedPlatform(SettingsFlavor flavor) {
    return !(flavor == SettingsFlavor.network && !kIsWeb && !Platform.isAndroid);
  }

  static bool _isSupportedCore(SettingsFlavor flavor, AppPreferences preferences) {
    if (flavor != SettingsFlavor.voicemail) return true;
    return preferences.getSystemInfo()?.adapter?.supported?.contains(kVoicemailFeatureFlag) ?? false;
  }

  static EmbeddedData? _getEmbeddedDataResource(
    AppConfig appConfig,
    AppConfigSettingsItem item,
    SettingsFlavor flavor,
  ) {
    // Retrieve the embedded resource URL by matching the provided item ID.
    var embeddedDataResource =
        appConfig.embeddedResources.firstWhereOrNull((resource) => resource.id == item.embeddedResourceId);

    // If no direct match is found and the flavor is 'terms', attempt to fetch the privacy policy resource.
    if (embeddedDataResource?.uriOrNull == null && flavor == SettingsFlavor.terms) {
      return _tryConfigureTermsFeature(appConfig).configData;
    }

    // If strategy is not provided, default to hard reload.
    final reconnectStrategy = embeddedDataResource?.reconnectStrategy != null
        ? ReconnectStrategy.values.byName(embeddedDataResource!.reconnectStrategy!)
        : ReconnectStrategy.softReload;

    // Return a ConfigData instance if a valid resource URL is found, otherwise return null.
    return embeddedDataResource?.uriOrNull != null
        ? EmbeddedData(
            id: embeddedDataResource!.id,
            uri: embeddedDataResource.uriOrNull!,
            reconnectStrategy: reconnectStrategy,
            titleL10n: item.titleL10n,
            enableConsoleLogCapture: embeddedDataResource.enableConsoleLogCapture,
          )
        : null;
  }

  // TODO(Serdun): Refactor login configuration to separate concerns more cleanly.
  // Currently, modeSelectActions control both the launch screen and the buttons on the login_mode_select_screen,
  // which leads to unclear and tightly coupled logic.
  static LoginFeature _tryEnableCustomLoginFeature(AppConfig appConfig, List<EmbeddedData> embeddedData) {
    final rawButtons = appConfig.loginConfig.modeSelectActions.where((button) => button.enabled);
    final buttons = <LoginModeAction>[];

    for (var actions in rawButtons) {
      final loginFlavor = LoginFlavor.values.byName(actions.type);
      final loginEmbeddedData = embeddedData.firstWhereOrNull((dto) => dto.id == actions.embeddedId);

      if (loginEmbeddedData != null && loginFlavor == LoginFlavor.embedded) {
        buttons.add(LoginEmbeddedModeButton(
          titleL10n: actions.titleL10n,
          flavor: loginFlavor,
          customLoginFeature: loginEmbeddedData,
          isLaunchButtonVisible: actions.isLaunchButtonVisible,
          isLaunchScreen: actions.isLaunchScreen,
        ));
      } else if (loginFlavor == LoginFlavor.login) {
        buttons.add(LoginModeAction(
          titleL10n: actions.titleL10n,
          flavor: loginFlavor,
          isLaunchButtonVisible: actions.isLaunchButtonVisible,
        ));
      }
    }

    return LoginFeature(
      titleL10n: appConfig.loginConfig.greetingL10n,
      actions: buttons,
      launchLoginPage: embeddedData.firstWhereOrNull((embeddedScreen) => embeddedScreen.attributes['launch'] == true),
    );
  }

  static CallFeature _tryConfigureCallFeature(AppConfig appConfig, AppPreferences preferences) {
    final callConfig = appConfig.callConfig;

    final transferConfig = appConfig.callConfig.transfer;

    final encodingConfig = appConfig.callConfig.encoding;
    final defaultPresetOverride = encodingConfig.defaultPresetOverride;
    final encodingViewEnabled = appConfig.settingsConfig.sections.any((section) {
      return section.items.any((item) {
        return item.type == SettingsFlavor.mediaSettings.name && item.enabled;
      });
    });

    final peerConnectionConfig = appConfig.callConfig.peerConnection;

    return CallFeature(
      callConfig: CallConfig(
        isVideoCallEnabled: callConfig.videoEnabled,
        isBlindTransferEnabled: transferConfig.enableBlindTransfer,
        isAttendedTransferEnabled: transferConfig.enableAttendedTransfer,
      ),
      callTriggerConfig: const CallTriggerConfig(
        smsFallback: SmsFallbackTriggerConfig(
          enabled: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS,
          available: EnvironmentConfig.CALL_TRIGGER_MECHANISM_SMS,
        ),
      ),
      encoding: EncodingConfig(
          bypassConfig: encodingConfig.bypassConfig,
          configurationAllowed: encodingViewEnabled,
          defaultPresetOverride: DefaultPresetOverride(
            audioBitrate: defaultPresetOverride.audioBitrate,
            videoBitrate: defaultPresetOverride.videoBitrate,
            ptime: defaultPresetOverride.ptime,
            maxptime: defaultPresetOverride.maxptime,
            opusSamplingRate: defaultPresetOverride.opusSamplingRate,
            opusBitrate: defaultPresetOverride.opusBitrate,
            opusStereo: defaultPresetOverride.opusStereo,
            opusDtx: defaultPresetOverride.opusDtx,
          )),
      peerConnection: PeerConnectionSettings(
        negotiationSettings: NegotiationSettings(
          includeInactiveVideoInOfferAnswer: peerConnectionConfig.negotiation.includeInactiveVideoInOfferAnswer,
        ),
      ),
    );
  }

  static MessagingFeature _tryConfigureMessagingFeature(AppConfig appConfig, AppPreferences preferences) {
    final tabEnabled = appConfig.mainConfig.bottomMenu.tabs.any((tab) {
      return tab.type.name == MainFlavor.messaging.name && tab.enabled;
    });
    return MessagingFeature(preferences, tabEnabled: tabEnabled);
  }

  static TermsFeature _tryConfigureTermsFeature(AppConfig appConfig) {
    // Attempt to find the terms resource from the embedded resources list.
    final termsResource =
        appConfig.embeddedResources.firstWhereOrNull((resource) => resource.type == EmbeddedResourceType.terms);

    // TODO(Serdun): It would be better to add a separate privacy policy feature in AppConfig,
    // with a direct link to the embedded resource. Implement logic to check if the feature access
    // doesn't have a link, and if not, search the embedded resources by type in the list.
    if (termsResource == null) {
      throw EmbeddedResourceMissingException(
        message: 'Terms  resource is missing',
        embeddedResourceType: EmbeddedResourceType.terms,
      );
    }

    _logger.info('Privacy policy resource found: ${termsResource.uriOrNull}');

    return TermsFeature(EmbeddedData(
      id: termsResource.id,
      uri: termsResource.uriOrNull!,
      reconnectStrategy: ReconnectStrategy.softReload,
      titleL10n: termsResource.toolbar.titleL10n,
    ));
  }

  static EmbeddedFeature _tryConfigureEmbeddedFeature(AppConfig appConfig) {
    final embeddedResources = appConfig.embeddedResources.map((resource) {
      // If strategy is not provided, default to hard reload.
      final reconnectStrategy = resource.reconnectStrategy != null
          ? ReconnectStrategy.values.byName(resource.reconnectStrategy!)
          : ReconnectStrategy.softReload;

      return EmbeddedData(
        id: resource.id,
        uri: Uri.parse(resource.uri),
        reconnectStrategy: reconnectStrategy,
        payload: resource.payload.map((it) => EmbeddedPayloadData.values.byName(it)).toList(),
      );
    }).toList();

    return EmbeddedFeature(embeddedResources);
  }

  static SystemNotificationsFeature _tryConfigureSystemNotificationsFeature(
    AppPreferences preferences,
    AppConfig appConfig,
  ) {
    final enabled = appConfig.mainConfig.systemNotificationsEnabled;
    return SystemNotificationsFeature(preferences, enabled);
  }

  static SipPresenceFeature _tryConfigureSipPresenceFeature(
    AppPreferences preferences,
    AppConfig appConfig,
  ) {
    final enabled = appConfig.mainConfig.sipPresenceEnabled;
    return SipPresenceFeature(preferences, enabled);
  }
}

class LoginFeature {
  final String? titleL10n;
  final List<LoginModeAction> actions;
  final EmbeddedData? launchLoginPage;

  LoginFeature({
    required this.titleL10n,
    required this.actions,
    required this.launchLoginPage,
  });

  List<LoginEmbeddedModeButton> get embeddedConfigurations => actions.whereType<LoginEmbeddedModeButton>().toList();

  LoginEmbeddedModeButton? get embeddedLaunchConfiguration =>
      embeddedConfigurations.firstWhereOrNull((action) => action.isLaunchScreen);

  bool get hasEmbeddedPage => embeddedConfigurations.isNotEmpty;

  List<LoginModeAction> get launchButtons => actions.where((action) => action.isLaunchButtonVisible).toList();
}

class BottomMenuFeature {
  BottomMenuFeature(
    List<BottomMenuTab> tabs,
    this._appPreferences, {
    bool cacheSelectedTab = true,
  }) : _tabs = List.unmodifiable(tabs) {
    final savedFlavor = cacheSelectedTab ? _appPreferences.getActiveMainFlavor() : null;
    _activeTab = _findInitialTab(savedFlavor);
  }

  final List<BottomMenuTab> _tabs;
  final AppPreferences _appPreferences;
  late BottomMenuTab _activeTab;

  List<BottomMenuTab> get tabs => _tabs;

  List<EmbeddedBottomMenuTab> get embeddedTabs => _tabs.whereType<EmbeddedBottomMenuTab>().toList(growable: false);

  BottomMenuTab get activeTab => _activeTab;

  int get activeIndex => _tabs.indexOf(_activeTab);

  bool isTabEnabled(MainFlavor flavor) => _tabs.any((tab) => tab.flavor == flavor && tab.enabled);

  BottomMenuTab? getTabEnabled(MainFlavor flavor) => _tabs.firstWhereOrNull((tab) => tab.flavor == flavor);

  EmbeddedBottomMenuTab getEmbeddedTabById(int id) => embeddedTabs.firstWhere((tab) => tab.id == id);

  set activeFlavor(BottomMenuTab newTab) {
    _activeTab = newTab;
    _appPreferences.setActiveMainFlavor(newTab.flavor);
  }

  BottomMenuTab _findInitialTab(MainFlavor? savedFlavor) {
    return _tabs.firstWhereOrNull((tab) => tab.flavor == savedFlavor) ??
        _tabs.firstWhereOrNull((tab) => tab.initial) ??
        _tabs.first;
  }
}

class SettingsFeature {
  SettingsFeature(this._sections, this._appPreferences);

  final List<SettingsSection> _sections;
  final AppPreferences _appPreferences;

  List<SettingsSection> get sections => List.unmodifiable(_sections);

  // TODO(Serdun): Remove duplicate code
  List<String> get _coreSupportedFeatures {
    final systemInfo = _appPreferences.getSystemInfo();
    return systemInfo?.adapter?.supported ?? [];
  }

  bool get coreVoicemailSupport => _coreSupportedFeatures.contains(kVoicemailFeatureFlag);

  bool get isVoicemailsEnabled => _sections.any((section) {
        return section.items.any((item) {
          return item.flavor == SettingsFlavor.voicemail && coreVoicemailSupport;
        });
      });
}

class CallFeature {
  CallFeature({
    required this.callConfig,
    required this.encoding,
    required this.peerConnection,
    required this.callTriggerConfig,
  });

  final CallConfig callConfig;
  final EncodingConfig encoding;
  final PeerConnectionSettings peerConnection;

  /// Configuration for how incoming calls are triggered.
  ///
  /// This controls which triggering mechanisms are available and which one is currently active.
  /// It also defines fallback behavior via SMS if supported.
  ///
  /// Note: This setting affects **UI-level visibility and selection** of triggering methods,
  /// not the underlying signaling implementation.
  final CallTriggerConfig callTriggerConfig;
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

/// Represents the configuration of the terms and privacy policy feature in the app.
/// The `TermsFeature` class is responsible for assigning the correct terms resource, either from
/// a provided embedded resource ID or by searching for a resource of type `terms`.
///
/// Configuration Scheme:
/// 1. **Embedded Resource**: The `TermsFeature` looks for an embedded resource of type `terms`
///    to assign the privacy policy. If the embedded resource is not explicitly provided in `AppConfig`,
///    it will be searched in the embedded resources by type.
class TermsFeature {
  final EmbeddedData configData;

  TermsFeature(this.configData);
}

class EmbeddedFeature {
  final List<EmbeddedData> embeddedResources;

  EmbeddedFeature(this.embeddedResources);
}

class SystemNotificationsFeature {
  SystemNotificationsFeature(this._appPreferences, this.enabled);

  final bool enabled;
  final AppPreferences _appPreferences;

  List<String> get _coreSupportedFeatures {
    final systemInfo = _appPreferences.getSystemInfo();
    return systemInfo?.adapter?.supported ?? [];
  }

  // Check if the core system supports system notifications and push sending.
  bool get coreSystemSupport => _coreSupportedFeatures.contains(kSystemNotificationsFeatureFlag);

  bool get coreSystemPushSupport => _coreSupportedFeatures.contains(kSystemNotificationsPushFeatureFlag);

  /// Check if the system notifications feature is enabled and supported by the remote system.
  bool get systemNotificationsSupport => enabled && coreSystemSupport;

  /// Check if the system notifications push feature is enabled and supported by the remote system.
  bool get systemNotificationsPushSupport => enabled && coreSystemPushSupport;
}

class SipPresenceFeature {
  SipPresenceFeature(this._appPreferences, this.enabled);

  final AppPreferences _appPreferences;
  final bool enabled;

  List<String> get _coreSupportedFeatures {
    final systemInfo = _appPreferences.getSystemInfo();
    return systemInfo?.adapter?.supported ?? [];
  }

  // Check if the core system supports SIP presence.
  bool get coreSipPresenceSupport => _coreSupportedFeatures.contains(kSipPresenceFeatureFlag);

  /// Check if the SIP presence feature is enabled and supported by the remote system.
  bool get sipPresenceSupport => enabled && coreSipPresenceSupport;
}

/// Provides a centralized way to check whether specific [FeatureFlag]s are enabled.
///
/// The [FeatureChecker] itself does not contain the logic for determining
/// if a feature is enabled or disabled. Instead, it relies on the injected
/// [FeatureResolver] function to evaluate the state of a given [FeatureFlag].
///
/// This allows feature availability logic to be configured and maintained
/// in one place (e.g., [FeatureAccess]), while consumers of [FeatureChecker]
/// only need to call [isEnabled] to check if a feature should be accessible.
class FeatureChecker {
  /// Creates a new [FeatureChecker] with the given [_resolver].
  ///
  /// The [_resolver] is a function that maps a [FeatureFlag] to `true`
  /// (enabled) or `false` (disabled).
  FeatureChecker(this._resolver);

  /// A resolver function that determines whether a [FeatureFlag] is enabled.
  final FeatureResolver _resolver;

  /// Returns `true` if the given [feature] is enabled, otherwise `false`.
  bool isEnabled(FeatureFlag feature) => _resolver(feature);
}
