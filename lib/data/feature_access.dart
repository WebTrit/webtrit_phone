import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

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
/// 3. **SettingsFeature**: Configures the app's settings screen by defining sections and items
///    based on the platform and the app configuration. It also handles embedded resources for settings items.
///    - **Embedded Resources**: Each setting item can either have an embedded resource linked via an `embeddedResourceId`
///      or by matching the resource's type. Resources are first searched by ID, and if not found, the class searches
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
  FeatureAccess._(
    this.embeddedFeature,
    this.loginFeature,
    this.bottomMenuFeature,
    this.settingsFeature,
    this.callFeature,
    this.messagingFeature,
    this.contactsFeature,
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
  final ContactsFeature contactsFeature;
  final TermsFeature termsFeature;
  final SystemNotificationsFeature systemNotificationsFeature;
  final SipPresenceFeature sipPresenceFeature;

  static FeatureAccess init(
    AppConfig appConfig,
    List<EmbeddedResource> embeddedResources,
    ActiveMainFlavorRepository activeMainFlavorRepository,
    CoreSupport coreSupport,
  ) {
    try {
      // Initialize basic features
      final embeddedFeature = EmbeddedFeature.fromConfig(embeddedResources);

      // Initialize dependent features
      // Note: TermsFeature must be initialized before SettingsFeature because Settings might fallback to Terms config.
      final termsFeature = TermsFeature.fromConfig(embeddedResources);

      final customLoginFeature = LoginFeature.fromConfig(appConfig, embeddedFeature.embeddedResources);
      final bottomMenuManager = BottomMenuFeature.fromConfig(appConfig, activeMainFlavorRepository, embeddedFeature);
      final settingsFeature = SettingsFeature.fromConfig(appConfig, embeddedResources, coreSupport, termsFeature);
      final callFeature = CallFeature.fromConfig(appConfig);
      final messagingFeature = MessagingFeature.fromConfig(appConfig, coreSupport);
      final contactsFeature = ContactsFeature.fromConfig(appConfig);
      final systemNotificationsFeature = SystemNotificationsFeature.fromConfig(coreSupport, appConfig);
      final sipPresenceFeature = SipPresenceFeature.fromConfig(coreSupport, appConfig);

      return FeatureAccess._(
        embeddedFeature,
        customLoginFeature,
        bottomMenuManager,
        settingsFeature,
        callFeature,
        messagingFeature,
        contactsFeature,
        termsFeature,
        systemNotificationsFeature,
        sipPresenceFeature,
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
  }
}

class LoginFeature {
  final String? titleL10n;
  final List<LoginModeAction> actions;
  final EmbeddedData? launchLoginPage;

  LoginFeature({required this.titleL10n, required this.actions, required this.launchLoginPage});

  // TODO(Serdun): Refactor login configuration to separate concerns more cleanly.
  // Currently, modeSelectActions control both the launch screen and the buttons on the login_mode_select_screen,
  // which leads to unclear and tightly coupled logic.
  factory LoginFeature.fromConfig(AppConfig appConfig, List<EmbeddedData> embeddedData) {
    final rawButtons = appConfig.loginConfig.modeSelect.actions.where((button) => button.enabled);
    final buttons = <LoginModeAction>[];

    for (var actions in rawButtons) {
      final loginFlavor = LoginFlavor.values.byName(actions.type);
      final loginEmbeddedData = embeddedData.firstWhereOrNull((dto) => dto.id == actions.embeddedId);

      if (loginEmbeddedData != null && loginFlavor == LoginFlavor.embedded) {
        buttons.add(
          LoginEmbeddedModeButton(
            titleL10n: actions.titleL10n,
            flavor: loginFlavor,
            customLoginFeature: loginEmbeddedData,
          ),
        );
      } else if (loginFlavor == LoginFlavor.login) {
        buttons.add(LoginDefaultModeAction(titleL10n: actions.titleL10n, flavor: loginFlavor));
      }
    }

    return LoginFeature(
      titleL10n: appConfig.loginConfig.modeSelect.greetingL10n,
      actions: buttons,
      launchLoginPage: embeddedData.firstWhereOrNull(
        (it) => it.id == appConfig.loginConfig.common.fullScreenLaunchEmbeddedResourceId,
      ),
    );
  }

  List<LoginEmbeddedModeButton> get embeddedConfigurations => actions.whereType<LoginEmbeddedModeButton>().toList();

  bool get hasEmbeddedPage => embeddedConfigurations.isNotEmpty;

  List<LoginModeAction> get launchButtons => actions.toList();
}

class BottomMenuFeature {
  BottomMenuFeature(List<BottomMenuTab> tabs, this._activeMainFlavorRepository, {bool cacheSelectedTab = true})
    : _tabs = List.unmodifiable(tabs) {
    final savedFlavor = cacheSelectedTab ? _activeMainFlavorRepository.getActiveMainFlavor() : null;
    _activeTab = _findInitialTab(savedFlavor);
  }

  final List<BottomMenuTab> _tabs;
  final ActiveMainFlavorRepository _activeMainFlavorRepository;
  late BottomMenuTab _activeTab;

  factory BottomMenuFeature.fromConfig(
    AppConfig appConfig,
    ActiveMainFlavorRepository activeMainFlavorRepository,
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

    return BottomMenuFeature(bottomMenuTabs, activeMainFlavorRepository, cacheSelectedTab: bottomMenu.cacheSelectedTab);
  }

  static BottomMenuTab _createBottomMenuTab(BottomMenuTabScheme tab, List<EmbeddedData> embeddedResources) {
    return tab.when(
      favorites: (bool enabled, bool initial, String titleL10n, String icon) => FavoritesBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      recents: (bool enabled, bool initial, String titleL10n, String icon, bool useCdrs) => RecentsBottomMenuTab(
        useCdrs: useCdrs,
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      contacts: (enabled, initial, titleL10n, icon, contactSourceTypes) => ContactsBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
        contactSourceTypes: contactSourceTypes.map((type) => ContactSourceType.values.byName(type)).toList(),
      ),
      keypad: (bool enabled, bool initial, String titleL10n, String icon) => KeypadBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      messaging: (bool enabled, bool initial, String titleL10n, String icon) => MessagingBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      embedded: (enabled, initial, titleL10n, icon, embeddedId) {
        final embeddedResource = embeddedResources.firstWhereOrNull((resource) => resource.id == embeddedId);
        return EmbeddedBottomMenuTab(
          id: embeddedId,
          enabled: tab.enabled,
          initial: tab.initial,
          titleL10n: tab.titleL10n,
          icon: tab.icon.toIconData(),
          data: embeddedResource,
        );
      },
    );
  }

  List<BottomMenuTab> get tabs => _tabs;

  List<EmbeddedBottomMenuTab> get embeddedTabs => _tabs.whereType<EmbeddedBottomMenuTab>().toList(growable: false);

  BottomMenuTab get activeTab => _activeTab;

  int get activeIndex => _tabs.indexOf(_activeTab);

  /// Returns the first enabled tab of the specified type [T], or `null` if no such tab exists.
  T? getTabEnabled<T extends BottomMenuTab>() {
    final tab = _tabs.firstWhereOrNull((tab) => tab is T && tab.enabled);
    return tab is T ? tab : null;
  }

  /// Returns the embedded tab with the specified [id].
  EmbeddedBottomMenuTab getEmbeddedTabById(String id) {
    return embeddedTabs.firstWhere((tab) => tab.id == id);
  }

  /// Sets the active tab to [newTab] and persists the selection in preferences.
  set activeFlavor(BottomMenuTab newTab) {
    _activeTab = newTab;
    _activeMainFlavorRepository.setActiveMainFlavor(newTab.flavor);
  }

  /// Finds the initial tab to be selected based on the saved flavor or the initial flag.
  BottomMenuTab _findInitialTab(MainFlavor? savedFlavor) {
    return _tabs.firstWhereOrNull((tab) => tab.flavor == savedFlavor) ??
        _tabs.firstWhereOrNull((tab) => tab.initial) ??
        _tabs.first;
  }
}

class SettingsFeature {
  SettingsFeature(this._sections, this._coreSupport);

  final List<SettingsSection> _sections;
  final CoreSupport _coreSupport;

  factory SettingsFeature.fromConfig(
    AppConfig appConfig,
    List<EmbeddedResource> embeddedResources,
    CoreSupport coreSupport,
    TermsFeature termsFeature,
  ) {
    final settingSections = <SettingsSection>[];

    for (var section in appConfig.settingsConfig.sections.where((section) => section.enabled)) {
      final items = <SettingItem>[];

      for (var item in section.items.where((item) => item.enabled)) {
        final flavor = SettingsFlavor.values.byName(item.type);

        /// Skip unsupported features based on platform and core support.
        if (!_isFeatureSupportedByPlatform(flavor)) continue;
        if (!_isFeatureSupportedByCore(flavor, coreSupport)) continue;

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon.toIconData(),
          data: _getEmbeddedDataResource(appConfig, embeddedResources, item, flavor, termsFeature),
          flavor: SettingsFlavor.values.byName(item.type),
        );

        items.add(settingItem);
      }

      // Skip empty sections
      if (items.isNotEmpty) {
        settingSections.add(SettingsSection(titleL10n: section.titleL10n, items: items));
      }
    }

    return SettingsFeature(settingSections, coreSupport);
  }

  // TODO (Serdun): Move platform-specific configuration to a separate config file.
  // Currently, the settings screen includes this configuration only for Android.
  // For other platforms, this item is hidden. Update the logic to handle configurations for all platforms.
  static bool _isFeatureSupportedByPlatform(SettingsFlavor flavor) {
    return !(flavor == SettingsFlavor.network && !kIsWeb && !Platform.isAndroid);
  }

  /// Returns true for all flavors except voicemail, which requires core support verification.
  static bool _isFeatureSupportedByCore(SettingsFlavor flavor, CoreSupport coreSupport) {
    return flavor != SettingsFlavor.voicemail || coreSupport.supportsVoicemail;
  }

  static EmbeddedData? _getEmbeddedDataResource(
    AppConfig appConfig,
    List<EmbeddedResource> embeddedResources,
    AppConfigSettingsItem item,
    SettingsFlavor flavor,
    TermsFeature termsFeature,
  ) {
    // Retrieve the embedded resource URL by matching the provided item ID.
    var embeddedDataResource = embeddedResources.firstWhereOrNull((resource) => resource.id == item.embeddedResourceId);

    // If no direct match is found and the flavor is 'terms', attempt to fetch the privacy policy resource.
    if (embeddedDataResource?.uriOrNull == null && flavor == SettingsFlavor.terms) {
      return termsFeature.configData;
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

  List<SettingsSection> get sections => List.unmodifiable(_sections);

  bool get isVoicemailsEnabled => _sections.any((section) {
    return section.items.any((item) {
      return item.flavor == SettingsFlavor.voicemail && _coreSupport.supportsVoicemail;
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

  factory CallFeature.fromConfig(AppConfig appConfig) {
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
          removeExtmaps: defaultPresetOverride.removeExtmaps,
          removeStaticAudioRtpMaps: defaultPresetOverride.removeStaticAudioRtpMaps,
          remapTE8payloadTo101: defaultPresetOverride.remapTE8payloadTo101,
        ),
      ),
      peerConnection: PeerConnectionSettings(
        negotiationSettings: NegotiationSettings(
          includeInactiveVideoInOfferAnswer: peerConnectionConfig.negotiation.includeInactiveVideoInOfferAnswer,
        ),
      ),
    );
  }
}

class MessagingFeature {
  MessagingFeature(this._coreSupport, {bool tabEnabled = false, bool groupChatButtonEnabled = true})
    : _tabEnabled = tabEnabled,
      _groupChatSupport = groupChatButtonEnabled;

  final CoreSupport _coreSupport;
  final bool _tabEnabled;
  final bool _groupChatSupport;

  factory MessagingFeature.fromConfig(AppConfig appConfig, CoreSupport coreSupport) {
    final tabEnabled = appConfig.mainConfig.bottomMenu.tabs.any(
      (tab) => tab.maybeWhen(messaging: (enabled, _, _, _) => enabled, orElse: () => false),
    );

    return MessagingFeature(
      coreSupport,
      tabEnabled: tabEnabled,
      groupChatButtonEnabled: appConfig.messaging.chats.groupChatButtonEnabled,
    );
  }

  /// Check if the SMS messaging feature is supported by remote system.
  bool get coreSmsSupport => _coreSupport.supportsSms;

  /// Check if the internal messaging feature is supported by remote system.
  bool get coreChatsSupport => _coreSupport.supportsChats;

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

  /// Check if the group chat functionality is enabled.
  bool get isGroupChatSupport => _groupChatSupport;
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

  factory TermsFeature.fromConfig(List<EmbeddedResource> embeddedResources) {
    // Attempt to find the terms resource from the embedded resources list.
    final termsResource = embeddedResources.firstWhereOrNull((resource) => resource.type == EmbeddedResourceType.terms);

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

    return TermsFeature(
      EmbeddedData(
        id: termsResource.id,
        uri: termsResource.uriOrNull!,
        reconnectStrategy: ReconnectStrategy.softReload,
        titleL10n: termsResource.toolbar.titleL10n,
      ),
    );
  }
}

class EmbeddedFeature {
  final List<EmbeddedData> embeddedResources;

  EmbeddedFeature(this.embeddedResources);

  factory EmbeddedFeature.fromConfig(List<EmbeddedResource> embeddedResources) {
    final embeddedData = embeddedResources.map((resource) {
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

    return EmbeddedFeature(embeddedData);
  }
}

class SystemNotificationsFeature {
  SystemNotificationsFeature(this._coreSupport, this.enabled);

  final bool enabled;
  final CoreSupport _coreSupport;

  factory SystemNotificationsFeature.fromConfig(CoreSupport coreSupport, AppConfig appConfig) {
    final enabled = appConfig.mainConfig.systemNotificationsEnabled;
    return SystemNotificationsFeature(coreSupport, enabled);
  }

  bool get coreSystemSupport => _coreSupport.supportsSystemNotifications;

  bool get coreSystemPushSupport => _coreSupport.supportsSystemPushNotifications;

  /// Check if the system notifications feature is enabled and supported by the remote system.
  bool get systemNotificationsSupport => enabled && coreSystemSupport;

  /// Check if the system notifications push feature is enabled and supported by the remote system.
  bool get systemNotificationsPushSupport => enabled && coreSystemPushSupport;
}

class SipPresenceFeature {
  SipPresenceFeature(this._coreSupport, this.enabled);

  final CoreSupport _coreSupport;
  final bool enabled;

  factory SipPresenceFeature.fromConfig(CoreSupport coreSupport, AppConfig appConfig) {
    final enabled = appConfig.mainConfig.sipPresenceEnabled;
    return SipPresenceFeature(coreSupport, enabled);
  }

  /// Check if the SIP presence feature is enabled and supported by the remote system.
  bool get sipPresenceSupport => enabled && _coreSupport.supportsSipPresence;
}

/// Manages contact-related features, such as actions available on the contact details screen.
class ContactsFeature {
  /// Creates an instance of [ContactsFeature] with a given [detailsConfig].
  const ContactsFeature({required this.detailsConfig});

  /// The configuration for the contact details screen.
  final ContactDetailsConfig detailsConfig;

  static const Set<ContactAction> _defaultAppBarActions = {ContactAction.chat};

  static const Set<ContactAction> _defaultEmailActions = {ContactAction.sendEmail};

  static final Map<String, ContactAction> _actionByName = ContactAction.values.asNameMap();

  /// Creates a [ContactsFeature] from the given [appConfig].
  ///
  /// It parses the actions defined in the contacts configuration for different UI elements.
  /// If the config is null or contains invalid values, it falls back to defined defaults.
  factory ContactsFeature.fromConfig(AppConfig appConfig) {
    final detailsDto = appConfig.contacts.details;

    // Pre-calculate the default "All except chat" for phone tiles
    // to avoid recalculating it on every instantiation.
    final defaultPhoneActions = ContactAction.values.where((action) => action != ContactAction.chat).toSet();

    return ContactsFeature(
      detailsConfig: ContactDetailsConfig(
        appBarActions: _parseActions(detailsDto.actions.appBar, fallback: _defaultAppBarActions),
        phoneTileActions: _parseActions(detailsDto.actions.phoneTile, fallback: defaultPhoneActions),
        emailTileActions: _parseActions(detailsDto.actions.emailTile, fallback: _defaultEmailActions),
      ),
    );
  }

  /// Parses a list of raw action strings into a set of [ContactAction] enums.
  ///
  /// Returns [fallback] if [rawActions] is null.
  /// Invalid strings inside [rawActions] are ignored.
  static Set<ContactAction> _parseActions(List<String>? rawActions, {required Set<ContactAction> fallback}) {
    if (rawActions == null) return fallback;

    final parsed = rawActions.map((e) => _actionByName[e]).whereType<ContactAction>().toSet();

    return parsed;
  }
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
