import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
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
class FeatureAccess extends Equatable {
  const FeatureAccess._(
    this.embeddedConfig,
    this.loginConfig,
    this.bottomMenuConfig,
    this.settingsConfig,
    this.callConfig,
    this.messagingConfig,
    this.contactsConfig,
    this.termsConfig,
    this.systemNotificationsConfig,
    this.sipPresenceConfig,
  );

  final EmbeddedConfig embeddedConfig;
  final LoginConfig loginConfig;
  final BottomMenuConfig bottomMenuConfig;
  final SettingsConfig settingsConfig;
  final CallConfig callConfig;
  final MessagingConfig messagingConfig;
  final ContactsConfig contactsConfig;
  final TermsConfig termsConfig;
  final SystemNotificationsConfig systemNotificationsConfig;
  final SipPresenceConfig sipPresenceConfig;

  static FeatureAccess create(
    AppConfig appConfig,
    List<EmbeddedResource> embeddedResources,
    WebtritSystemInfo? systemInfo,
  ) {
    try {
      final coreSupportSnapshot = CoreSupportImpl(() => systemInfo);
      // Initialize basic features
      final embeddedConfig = EmbeddedMapper.map(embeddedResources);

      // Initialize dependent features
      // Note: TermsConfig must be initialized before SettingsConfig because Settings might fallback to Terms config.
      final termsConfig = TermsMapper.map(embeddedResources);

      final loginConfig = LoginMapper.map(appConfig, embeddedConfig.embeddedResources);
      final bottomMenuConfig = BottomMenuMapper.map(appConfig, embeddedConfig);
      final settingsConfig = SettingsMapper.map(appConfig, embeddedResources, coreSupportSnapshot, termsConfig);
      final callConfig = CallMapper.map(appConfig);
      final messagingConfig = MessagingMapper.map(appConfig, coreSupportSnapshot);
      final contactsConfig = ContactsMapper.map(appConfig);
      final systemNotificationsConfig = SystemNotificationsMapper.map(coreSupportSnapshot, appConfig);
      final sipPresenceConfig = SipPresenceMapper.map(coreSupportSnapshot, appConfig);

      return FeatureAccess._(
        embeddedConfig,
        loginConfig,
        bottomMenuConfig,
        settingsConfig,
        callConfig,
        messagingConfig,
        contactsConfig,
        termsConfig,
        systemNotificationsConfig,
        sipPresenceConfig,
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
  }

  @override
  List<Object?> get props => [
    embeddedConfig,
    loginConfig,
    bottomMenuConfig,
    settingsConfig,
    callConfig,
    messagingConfig,
    contactsConfig,
    termsConfig,
    systemNotificationsConfig,
    sipPresenceConfig,
  ];
}

/// Mapper responsible for constructing [LoginConfig] from application configuration.
abstract final class LoginMapper {
  /// Maps [AppConfig] and pre-processed [EmbeddedData] to a [LoginConfig].
  // TODO(Serdun): Refactor login configuration to separate concerns more cleanly.
  // Currently, modeSelectActions control both the launch screen and the buttons on the login_mode_select_screen,
  // which leads to unclear and tightly coupled logic.
  static LoginConfig map(AppConfig appConfig, List<EmbeddedData> embeddedData) {
    final rawButtons = appConfig.loginConfig.modeSelect.actions.where((button) => button.enabled);
    final buttons = <LoginModeAction>[];

    for (final action in rawButtons) {
      final loginFlavor = LoginFlavor.values.byName(action.type);
      final loginEmbeddedData = embeddedData.firstWhereOrNull((dto) => dto.id == action.embeddedId);

      if (loginEmbeddedData != null && loginFlavor == LoginFlavor.embedded) {
        buttons.add(
          LoginEmbeddedModeButton(
            titleL10n: action.titleL10n,
            flavor: loginFlavor,
            customLoginFeature: loginEmbeddedData,
          ),
        );
      } else if (loginFlavor == LoginFlavor.login) {
        buttons.add(LoginDefaultModeAction(titleL10n: action.titleL10n, flavor: loginFlavor));
      }
    }

    return LoginConfig(
      titleL10n: appConfig.loginConfig.modeSelect.greetingL10n,
      actions: List.unmodifiable(buttons),
      launchLoginPage: embeddedData.firstWhereOrNull(
        (it) => it.id == appConfig.loginConfig.common.fullScreenLaunchEmbeddedResourceId,
      ),
    );
  }
}

/// Mapper responsible for transforming [AppConfig] into [BottomMenuConfig].
abstract final class BottomMenuMapper {
  /// Maps [AppConfig] and [EmbeddedConfig] to a [BottomMenuConfig].
  static BottomMenuConfig map(AppConfig appConfig, EmbeddedConfig embeddedConfig) {
    final bottomMenu = appConfig.mainConfig.bottomMenu;

    if (bottomMenu.tabs.isEmpty) {
      throw Exception('Bottom menu configuration is missing or empty');
    }

    final bottomMenuTabs = bottomMenu.tabs
        .where((tab) => tab.enabled)
        .map((tab) => _createBottomMenuTab(tab, embeddedConfig))
        .toList();

    if (bottomMenuTabs.isEmpty) {
      throw Exception('No enabled tabs found in bottom menu configuration');
    }

    return BottomMenuConfig(tabs: List.unmodifiable(bottomMenuTabs));
  }

  static BottomMenuTab _createBottomMenuTab(BottomMenuTabScheme tab, EmbeddedConfig embeddedConfig) {
    return tab.when(
      favorites: (enabled, initial, titleL10n, icon) => FavoritesBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      recents: (enabled, initial, titleL10n, icon, useCdrs) => RecentsBottomMenuTab(
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
      keypad: (enabled, initial, titleL10n, icon) => KeypadBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      messaging: (enabled, initial, titleL10n, icon) => MessagingBottomMenuTab(
        enabled: tab.enabled,
        initial: tab.initial,
        titleL10n: tab.titleL10n,
        icon: tab.icon.toIconData(),
      ),
      embedded: (enabled, initial, titleL10n, icon, embeddedId) {
        final embeddedResource = embeddedConfig.embeddedResources.firstWhereOrNull(
          (resource) => resource.id == embeddedId,
        );
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
}

/// Mapper responsible for building [SettingsConfig] by filtering items
/// based on platform support and core capabilities.
abstract final class SettingsMapper {
  /// Maps configuration, embedded resources, and core support to [SettingsConfig].
  static SettingsConfig map(
    AppConfig appConfig,
    List<EmbeddedResource> embeddedResources,
    CoreSupport coreSupport,
    TermsConfig termsConfig,
  ) {
    final settingSections = <SettingsSection>[];
    bool hasVoicemail = false;

    for (final section in appConfig.settingsConfig.sections.where((s) => s.enabled)) {
      final items = <SettingItem>[];

      for (final item in section.items.where((i) => i.enabled)) {
        final flavor = SettingsFlavor.values.byName(item.type);

        if (!_isFeatureSupportedByPlatform(flavor)) continue;
        if (!_isFeatureSupportedByCore(flavor, coreSupport)) continue;

        if (flavor == SettingsFlavor.voicemail) {
          hasVoicemail = true;
        }

        final settingItem = SettingItem(
          titleL10n: item.titleL10n,
          icon: item.icon.toIconData(),
          iconColor: item.iconColor?.toColor(),
          data: _getEmbeddedDataResource(embeddedResources, item, flavor, termsConfig),
          flavor: flavor,
        );

        items.add(settingItem);
      }

      if (items.isNotEmpty) {
        settingSections.add(SettingsSection(titleL10n: section.titleL10n, items: items));
      }
    }

    return SettingsConfig(voicemailsEnabled: hasVoicemail, sections: List.unmodifiable(settingSections));
  }

  // TODO (Serdun): Move platform-specific configuration to a separate config file.
  static bool _isFeatureSupportedByPlatform(SettingsFlavor flavor) {
    return !(flavor == SettingsFlavor.network && !kIsWeb && !Platform.isAndroid);
  }

  static bool _isFeatureSupportedByCore(SettingsFlavor flavor, CoreSupport coreSupport) {
    return flavor != SettingsFlavor.voicemail || coreSupport.supportsVoicemail;
  }

  static EmbeddedData? _getEmbeddedDataResource(
    List<EmbeddedResource> embeddedResources,
    AppConfigSettingsItem item,
    SettingsFlavor flavor,
    TermsConfig termsConfig,
  ) {
    final resource = embeddedResources.firstWhereOrNull((r) => r.id == item.embeddedResourceId);

    if (resource?.uriOrNull == null && flavor == SettingsFlavor.terms) {
      return termsConfig.configData;
    }

    if (resource?.uriOrNull == null) return null;

    final reconnectStrategy = resource?.reconnectStrategy != null
        ? ReconnectStrategy.values.byName(resource!.reconnectStrategy!)
        : ReconnectStrategy.softReload;

    return EmbeddedData(
      id: resource!.id,
      uri: resource.uriOrNull!,
      reconnectStrategy: reconnectStrategy,
      titleL10n: item.titleL10n,
      enableConsoleLogCapture: resource.enableConsoleLogCapture,
    );
  }
}

/// Mapper responsible for constructing [CallCapabilitiesConfig] from application configuration
/// and environment settings.
abstract final class CallMapper {
  /// Maps [AppConfig] to [CallCapabilitiesConfig].
  static CallConfig map(AppConfig appConfig) {
    final rawCallConfig = appConfig.callConfig;
    final transferConfig = rawCallConfig.transfer;
    final encodingConfig = rawCallConfig.encoding;
    final peerConnectionConfig = rawCallConfig.peerConnection;
    final defaultPresetOverride = encodingConfig.defaultPresetOverride;

    // Determine if the media settings UI should be accessible
    final encodingViewEnabled = appConfig.settingsConfig.sections.any(
      (section) => section.items.any((item) => item.type == SettingsFlavor.mediaSettings.name && item.enabled),
    );

    return CallConfig(
      capabilities: CallCapabilitiesConfig(
        isVideoCallEnabled: rawCallConfig.videoEnabled,
        isBlindTransferEnabled: transferConfig.enableBlindTransfer,
        isAttendedTransferEnabled: transferConfig.enableAttendedTransfer,
      ),
      triggerConfig: const CallTriggerConfig(
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

abstract final class MessagingMapper {
  /// Maps configuration and core support to [MessagingConfig].
  static MessagingConfig map(AppConfig appConfig, CoreSupport coreSupport) {
    final tabEnabled = appConfig.mainConfig.bottomMenu.tabs.any(
      (tab) => tab.maybeWhen(messaging: (enabled, _, _, _) => enabled, orElse: () => false),
    );

    return MessagingConfig(
      coreSmsSupport: coreSupport.supportsSms,
      coreChatsSupport: coreSupport.supportsChats,
      tabEnabled: tabEnabled,
      groupChatSupport: appConfig.messaging.chats.groupChatButtonEnabled,
      contactInfoVideoCallSupport: appConfig.messaging.chats.contactInfo.showVideoButtonAction,
    );
  }
}

/// Mapper responsible for identifying and preparing terms and privacy policy resources.
abstract final class TermsMapper {
  /// Maps embedded resources to [TermsConfig].
  ///
  /// The [TermsConfig] is responsible for assigning the correct terms resource,
  /// either from a provided embedded resource ID or by searching for a resource of type `terms`.
  static TermsConfig map(List<EmbeddedResource> embeddedResources) {
    // Attempt to find the terms resource from the embedded resources list.
    final termsResource = embeddedResources.firstWhereOrNull((resource) => resource.type == EmbeddedResourceType.terms);

    // TODO(Serdun): It would be better to add a separate privacy policy feature in AppConfig,
    // with a direct link to the embedded resource. Implement logic to check if the feature access
    // doesn't have a link, and if not, search the embedded resources by type in the list.
    if (termsResource == null) {
      throw EmbeddedResourceMissingException(
        message: 'Terms resource is missing',
        embeddedResourceType: EmbeddedResourceType.terms,
      );
    }

    return TermsConfig(
      EmbeddedData(
        id: termsResource.id,
        uri: termsResource.uriOrNull!,
        reconnectStrategy: ReconnectStrategy.softReload,
        titleL10n: termsResource.toolbar.titleL10n,
      ),
    );
  }
}

abstract final class EmbeddedMapper {
  /// Maps a list of [EmbeddedResource] to [EmbeddedConfig].
  static EmbeddedConfig map(List<EmbeddedResource> embeddedResources) {
    final embeddedDataList = embeddedResources.map((resource) {
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

    return EmbeddedConfig(List.unmodifiable(embeddedDataList));
  }
}

/// Mapper responsible for evaluating system notification support based on config and core capabilities.
abstract final class SystemNotificationsMapper {
  /// Maps [CoreSupport] and [AppConfig] to [SystemNotificationsConfig].
  static SystemNotificationsConfig map(CoreSupport coreSupport, AppConfig appConfig) {
    final enabled = appConfig.mainConfig.systemNotificationsEnabled;

    return SystemNotificationsConfig(
      systemNotificationsSupport: enabled && coreSupport.supportsSystemNotifications,
      systemNotificationsPushSupport: enabled && coreSupport.supportsSystemPushNotifications,
    );
  }
}

/// Mapper responsible for evaluating SIP presence support based on config and core capabilities.
abstract final class SipPresenceMapper {
  /// Maps [CoreSupport] and [AppConfig] to [SipPresenceConfig].
  static SipPresenceConfig map(CoreSupport coreSupport, AppConfig appConfig) {
    final enabled = appConfig.mainConfig.sipPresenceEnabled;
    final coreSupportEnabled = coreSupport.supportsSipPresence;

    return SipPresenceConfig(sipPresenceSupport: enabled && coreSupportEnabled);
  }
}

/// Mapper responsible for parsing and preparing [ContactsConfig] from application configuration.
abstract final class ContactsMapper {
  static const Set<ContactAction> _defaultAppBarActions = {ContactAction.chat};
  static const Set<ContactAction> _defaultEmailActions = {ContactAction.sendEmail};

  static final Map<String, ContactAction> _actionByName = ContactAction.values.asNameMap();

  /// Maps [AppConfig] to [ContactsConfig].
  ///
  /// It parses the actions defined in the contacts configuration for different UI elements.
  /// If the config is null or contains invalid values, it falls back to defined defaults.
  static ContactsConfig map(AppConfig appConfig) {
    final detailsDto = appConfig.contacts.details;

    // Pre-calculate the default "All except chat" for phone tiles.
    final defaultPhoneActions = ContactAction.values.where((action) => action != ContactAction.chat).toSet();

    return ContactsConfig(
      detailsConfig: ContactDetailsConfig(
        appBarActions: _parseActions(detailsDto.actions.appBar, fallback: _defaultAppBarActions),
        phoneTileActions: _parseActions(detailsDto.actions.phoneTile, fallback: defaultPhoneActions),
        emailTileActions: _parseActions(detailsDto.actions.emailTile, fallback: _defaultEmailActions),
      ),
    );
  }

  /// Parses a list of raw action strings into a set of [ContactAction] enums.
  static Set<ContactAction> _parseActions(List<String>? rawActions, {required Set<ContactAction> fallback}) {
    if (rawActions == null) return fallback;

    final parsed = rawActions.map((e) => _actionByName[e]).whereType<ContactAction>().toSet();

    return parsed.isEmpty ? fallback : parsed;
  }
}

class FeatureChecker {
  const FeatureChecker(this._access);

  final FeatureAccess _access;

  /// Returns `true` if the given [feature] is enabled, otherwise `false`.
  bool isEnabled(FeatureFlag feature) {
    final isEnabled = _resolve(feature);
    _logger.fine('Feature flag resolution: $feature = $isEnabled');
    return isEnabled;
  }

  bool _resolve(FeatureFlag feature) {
    return switch (feature) {
      FeatureFlag.voicemail => _access.settingsConfig.voicemailsEnabled,
    };
  }
}
