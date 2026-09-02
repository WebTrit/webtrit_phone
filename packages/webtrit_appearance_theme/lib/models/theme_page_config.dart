import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/common.dart';
import 'features_config/elevated_button_style_type.dart';
import 'features_config/metadata.dart';
import 'pages/pages.dart';
import 'resources/image_source.dart';
import 'theme_widget_config.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ThemePageConfig with _$ThemePageConfig {
  const ThemePageConfig({
    this.login = const LoginPageConfig(),
    this.about = const AboutPageConfig(),
    this.dialing = const CallPageConfig(),
    this.keypad = const KeypadPageConfig(),
    this.settings = const SettingsPageConfig(),
    this.contacts = const ContactsPageConfig(),
    this.embedded = const EmbeddedPageConfig(),
    this.favorites = const FavoritesPageConfig(),
    this.conversations = const ConversationsPageConfig(),
    this.recents = const RecentsPageConfig(),
    this.numberCdrs = const NumberCdrsPageConfig(),
  });

  @override
  final LoginPageConfig login;

  @override
  final AboutPageConfig about;

  @override
  final CallPageConfig dialing;

  @override
  final KeypadPageConfig keypad;

  @override
  final SettingsPageConfig settings;

  @override
  final ContactsPageConfig contacts;

  @override
  final EmbeddedPageConfig embedded;

  @override
  final FavoritesPageConfig favorites;

  @override
  final ConversationsPageConfig conversations;

  @override
  final RecentsPageConfig recents;

  @override
  final NumberCdrsPageConfig numberCdrs;

  factory ThemePageConfig.fromJson(Map<String, Object?> json) => _$ThemePageConfigFromJson(json);

  Map<String, Object?> toJson() => _$ThemePageConfigToJson(this);
}

/// Configuration for forcing a specific theme mode (Light/Dark) on a screen.
@freezed
@JsonSerializable(explicitToJson: true)
class ThemeOverrideConfig with _$ThemeOverrideConfig {
  const ThemeOverrideConfig({this.mode = ThemeModeConfig.system, this.applyToAppBar = true});

  /// The target mode to force (e.g., ensure screen is always Dark).
  @override
  final ThemeModeConfig mode;

  /// If true (default), the AppBar adopts the [mode].
  /// If false, the AppBar keeps the global theme.
  @override
  final bool applyToAppBar;

  factory ThemeOverrideConfig.fromJson(Map<String, Object?> json) => _$ThemeOverrideConfigFromJson(json);

  Map<String, Object?> toJson() => _$ThemeOverrideConfigToJson(this);
}

/// Declarative configuration for the **Login Page**.
///
/// Defines appearance, layout, and metadata options
/// for the login-related screens.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginPageConfig with _$LoginPageConfig {
  const LoginPageConfig({
    this.modeSelect = const LoginModeSelectPageConfig(),
    this.switchPage = const LoginSwitchPageConfig(),
    this.otpSignin = const LoginOtpSigninPageConfig(),
    this.passwordSignin = const LoginPasswordSigninPageConfig(),
    this.otpSigninVerify = const LoginOtpSigninVerifyScreenPageConfig(),
    this.signupVerify = const LoginSignupVerifyScreenPageConfig(),
    this.coreUrlAssign = const LoginCoreUrlAssignPageConfig(),
  });

  @override
  final LoginModeSelectPageConfig modeSelect;

  @override
  final LoginSwitchPageConfig switchPage;

  @override
  final LoginOtpSigninPageConfig otpSignin;

  @override
  final LoginPasswordSigninPageConfig passwordSignin;

  @override
  final LoginOtpSigninVerifyScreenPageConfig otpSigninVerify;

  @override
  final LoginSignupVerifyScreenPageConfig signupVerify;

  @override
  final LoginCoreUrlAssignPageConfig coreUrlAssign;

  factory LoginPageConfig.fromJson(Map<String, Object?> json) => _$LoginPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginPageConfigToJson(this);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the login page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

/// Configuration for the **OTP Signin Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginOtpSigninPageConfig with _$LoginOtpSigninPageConfig {
  const LoginOtpSigninPageConfig({this.refTextField});

  @override
  final TextFieldConfig? refTextField;

  factory LoginOtpSigninPageConfig.fromJson(Map<String, Object?> json) => _$LoginOtpSigninPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginOtpSigninPageConfigToJson(this);
}

/// Configuration for the **Password Signin Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginPasswordSigninPageConfig with _$LoginPasswordSigninPageConfig {
  const LoginPasswordSigninPageConfig({this.refTextField, this.passwordTextField});

  @override
  final TextFieldConfig? refTextField;

  @override
  final TextFieldConfig? passwordTextField;

  factory LoginPasswordSigninPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginPasswordSigninPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginPasswordSigninPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginOtpSigninVerifyScreenPageConfig with _$LoginOtpSigninVerifyScreenPageConfig {
  const LoginOtpSigninVerifyScreenPageConfig({this.countdownRepeatIntervalSeconds = 30});

  @override
  final int countdownRepeatIntervalSeconds;

  factory LoginOtpSigninVerifyScreenPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginOtpSigninVerifyScreenPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginOtpSigninVerifyScreenPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginSignupVerifyScreenPageConfig with _$LoginSignupVerifyScreenPageConfig {
  const LoginSignupVerifyScreenPageConfig({this.countdownRepeatIntervalSeconds = 30});

  @override
  final int countdownRepeatIntervalSeconds;

  factory LoginSignupVerifyScreenPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginSignupVerifyScreenPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginSignupVerifyScreenPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig implements BasePageConfig {
  const LoginModeSelectPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.systemUiOverlayStyle,
    this.mainLogo,
    this.buttonLoginStyleType = ElevatedButtonStyleType.primary,
    this.buttonSignupStyleType = ElevatedButtonStyleType.primary,
    this.background,
    this.greetingTextStyle,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final ImageSource? mainLogo;

  @override
  final ElevatedButtonStyleType buttonLoginStyleType;

  @override
  final ElevatedButtonStyleType buttonSignupStyleType;

  @override
  final PageBackground? background;

  @override
  final TextStyleConfig? greetingTextStyle;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory LoginModeSelectPageConfig.fromJson(Map<String, Object?> json) => _$LoginModeSelectPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginModeSelectPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginSwitchPageConfig with _$LoginSwitchPageConfig implements BasePageConfig {
  const LoginSwitchPageConfig({
    this.mainLogo,
    this.background,
    this.themeOverride = const ThemeOverrideConfig(),
    this.segmentButtonStyle,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final ImageSource? mainLogo;

  @override
  final PageBackground? background;

  @override
  final ButtonStyleConfig? segmentButtonStyle;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory LoginSwitchPageConfig.fromJson(Map<String, Object?> json) => _$LoginSwitchPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginSwitchPageConfigToJson(this);
}

/// Declarative configuration for the **About Page**.
@freezed
@JsonSerializable(explicitToJson: true)
class AboutPageConfig with _$AboutPageConfig implements BasePageConfig {
  const AboutPageConfig({
    this.mainLogo,
    this.metadata = const Metadata(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  @override
  final ImageSource? mainLogo;

  @override
  final Metadata metadata;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory AboutPageConfig.fromJson(Map<String, Object?> json) => _$AboutPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$AboutPageConfigToJson(this);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the About page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

/// Declarative configuration for the **Call Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageConfig with _$CallPageConfig implements BasePageConfig {
  const CallPageConfig({
    this.systemUiOverlayStyle,
    this.callInfo,
    this.callList,
    this.actingOnHint,
    this.actions,
    this.background,
    this.appBarStyle,
    this.appBarBlurredSurface,
  });

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final AppBarConfig? appBarStyle;

  @override
  final CallPageInfoConfig? callInfo;

  @override
  final CallPageListConfig? callList;

  @override
  final CallPageHintConfig? actingOnHint;

  @override
  final CallPageActionsConfig? actions;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  factory CallPageConfig.fromJson(Map<String, Object?> json) => _$CallPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class CallPageActionsConfig with _$CallPageActionsConfig {
  const CallPageActionsConfig({
    this.callStart = const ButtonStyleConfig(),
    this.hangup = const ButtonStyleConfig(),
    this.transfer = const ButtonStyleConfig(),
    this.camera = const ButtonStyleConfig(),
    this.muted = const ButtonStyleConfig(),
    this.speaker = const ButtonStyleConfig(),
    this.held = const ButtonStyleConfig(),
    this.swap = const ButtonStyleConfig(),
    this.key = const ButtonStyleConfig(),
    this.keypadInputStyle,
  });

  @override
  final ButtonStyleConfig callStart;

  @override
  final ButtonStyleConfig hangup;

  @override
  final ButtonStyleConfig transfer;

  @override
  final ButtonStyleConfig camera;

  @override
  final ButtonStyleConfig muted;

  @override
  final ButtonStyleConfig speaker;

  @override
  final ButtonStyleConfig held;

  @override
  final ButtonStyleConfig swap;

  @override
  final ButtonStyleConfig key;

  /// Text style for the digits typed on the in-call DTMF keypad (the value shown
  /// above the keys). When unset the app falls back to its default display text
  /// style for the keypad input.
  @override
  final TextStyleConfig? keypadInputStyle;

  factory CallPageActionsConfig.fromJson(Map<String, Object?> json) => _$CallPageActionsConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageActionsConfigToJson(this);
}

/// Declarative configuration for the **Call Info section**.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageInfoConfig with _$CallPageInfoConfig {
  const CallPageInfoConfig({
    this.usernameTextStyle,
    this.numberTextStyle,
    this.callStatusTextStyle,
    this.processingStatusTextStyle,
  });

  @override
  final TextStyleConfig? usernameTextStyle;

  @override
  final TextStyleConfig? numberTextStyle;

  @override
  final TextStyleConfig? callStatusTextStyle;

  @override
  final TextStyleConfig? processingStatusTextStyle;

  factory CallPageInfoConfig.fromJson(Map<String, Object?> json) => _$CallPageInfoConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageInfoConfigToJson(this);
}

/// Colors of the call-list rows on the **Call Screen** (the list-based
/// multi-call layout): row overlays, the focused border and the per-state
/// status dots. CSS hex strings, alpha-first (#AARRGGBB) supported.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageListConfig with _$CallPageListConfig {
  const CallPageListConfig({
    this.rowBackgroundColor,
    this.rowFocusedBackgroundColor,
    this.rowFocusedBorderColor,
    this.dotRingingColor,
    this.dotOnCallColor,
    this.dotHeldColor,
  });

  @override
  final String? rowBackgroundColor;

  @override
  final String? rowFocusedBackgroundColor;

  @override
  final String? rowFocusedBorderColor;

  @override
  final String? dotRingingColor;

  @override
  final String? dotOnCallColor;

  @override
  final String? dotHeldColor;

  factory CallPageListConfig.fromJson(Map<String, Object?> json) => _$CallPageListConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageListConfigToJson(this);
}

/// Colors of the "Acting on" hint pill on the **Call Screen**: the pill
/// background and the highlighted affected-call names.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageHintConfig with _$CallPageHintConfig {
  const CallPageHintConfig({this.backgroundColor, this.affectedNameColor});

  @override
  final String? backgroundColor;

  @override
  final String? affectedNameColor;

  factory CallPageHintConfig.fromJson(Map<String, Object?> json) => _$CallPageHintConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageHintConfigToJson(this);
}

/// Declarative configuration for the **Keypad Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class KeypadPageConfig with _$KeypadPageConfig implements BasePageConfig {
  const KeypadPageConfig({
    this.systemUiOverlayStyle,
    this.textField,
    this.contactName,
    this.keypad,
    this.actionpad,
    this.background,
    this.themeOverride = const ThemeOverrideConfig(),
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final TextFieldConfig? textField;

  @override
  final TextFieldConfig? contactName;

  @override
  final KeypadStyleConfig? keypad;

  @override
  final ActionPadWidgetConfig? actionpad;

  @override
  final PageBackground? background;

  /// Configuration to force override the theme mode (e.g., force Dark mode).
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory KeypadPageConfig.fromJson(Map<String, Object?> json) => _$KeypadPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$KeypadPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ActionPadWidgetConfig with _$ActionPadWidgetConfig {
  const ActionPadWidgetConfig({
    this.callStart = const ButtonStyleConfig(),
    this.callTransfer = const ButtonStyleConfig(),
    this.backspace = const ButtonStyleConfig(),
  });

  @override
  final ButtonStyleConfig callStart;

  @override
  final ButtonStyleConfig callTransfer;

  /// Style of the backspace key under the dial pad.
  @override
  final ButtonStyleConfig backspace;

  /// The retired name of [backspace], read and written for as long as themes
  /// and app builds from before the rename are around.
  static const _legacyBackspaceKey = 'backspacePressed';

  // TODO(Serdun): Remove the two `_legacyBackspaceKey` blocks below, and the key
  // itself, once no stored theme carries it and every supported release line
  // reads `backspace`. Migrating the stored themes is what closes this out -
  // carrying both names forever is not the plan.
  factory ActionPadWidgetConfig.fromJson(Map<String, Object?> json) {
    // A theme saved before the rename only has the old name.
    if (json['backspace'] == null && json[_legacyBackspaceKey] != null) {
      json = {...json, 'backspace': json[_legacyBackspaceKey]};
    }
    return _$ActionPadWidgetConfigFromJson(json);
  }

  Map<String, Object?> toJson() {
    final json = _$ActionPadWidgetConfigToJson(this);
    // An app built from an older release line only looks for the old name, so a
    // theme saved here would otherwise lose this button's colors on it.
    return {...json, _legacyBackspaceKey: json['backspace']};
  }
}

@freezed
@JsonSerializable(explicitToJson: true)
class SettingsPageConfig with _$SettingsPageConfig implements BasePageConfig {
  const SettingsPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.leadingIconsColor,
    this.userIconColor,
    this.logoutIconColor,
    this.groupTitleListTile,
    this.separator,
    this.background,
    this.itemTextStyle,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final String? leadingIconsColor;

  @override
  final String? userIconColor;

  @override
  final String? logoutIconColor;

  @override
  final GroupTitleListTileWidgetConfig? groupTitleListTile;

  /// Style of the divider lines between setting items (visibility + color).
  @override
  final SeparatorStyleConfig? separator;

  @override
  final PageBackground? background;

  @override
  final TextStyleConfig? itemTextStyle;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory SettingsPageConfig.fromJson(Map<String, Object?> json) => _$SettingsPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$SettingsPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ContactsPageConfig with _$ContactsPageConfig implements BasePageConfig {
  const ContactsPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory ContactsPageConfig.fromJson(Map<String, Object?> json) => _$ContactsPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$ContactsPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class EmbeddedPageConfig with _$EmbeddedPageConfig implements BasePageConfig {
  const EmbeddedPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory EmbeddedPageConfig.fromJson(Map<String, Object?> json) => _$EmbeddedPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$EmbeddedPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class FavoritesPageConfig with _$FavoritesPageConfig implements BasePageConfig {
  const FavoritesPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory FavoritesPageConfig.fromJson(Map<String, Object?> json) => _$FavoritesPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$FavoritesPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ConversationsPageConfig with _$ConversationsPageConfig implements BasePageConfig {
  const ConversationsPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory ConversationsPageConfig.fromJson(Map<String, Object?> json) => _$ConversationsPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$ConversationsPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class RecentsPageConfig with _$RecentsPageConfig implements BasePageConfig {
  const RecentsPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  /// Configuration to force override the theme mode.
  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory RecentsPageConfig.fromJson(Map<String, Object?> json) => _$RecentsPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$RecentsPageConfigToJson(this);
}

/// Configuration for the **Core URL assign (server address) Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginCoreUrlAssignPageConfig with _$LoginCoreUrlAssignPageConfig implements BasePageConfig {
  const LoginCoreUrlAssignPageConfig({
    this.themeOverride = const ThemeOverrideConfig(),
    this.systemUiOverlayStyle,
    this.background,
    this.appBarBlurredSurface,
    this.appBarStyle,
  });

  @override
  final ThemeOverrideConfig themeOverride;

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory LoginCoreUrlAssignPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginCoreUrlAssignPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginCoreUrlAssignPageConfigToJson(this);
}

/// Configuration for the **per-number call log (CDR details) Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class NumberCdrsPageConfig with _$NumberCdrsPageConfig implements BasePageConfig {
  const NumberCdrsPageConfig({this.background, this.appBarBlurredSurface, this.appBarStyle});

  @override
  final PageBackground? background;

  @override
  final BlurredSurfaceConfig? appBarBlurredSurface;

  @override
  final AppBarConfig? appBarStyle;

  factory NumberCdrsPageConfig.fromJson(Map<String, Object?> json) => _$NumberCdrsPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$NumberCdrsPageConfigToJson(this);
}
