import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/common.dart';
import 'features_config/elevated_button_style_type.dart';
import 'features_config/metadata.dart';
import 'theme_widget_config.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@Freezed()
class ThemePageConfig with _$ThemePageConfig {
  @JsonSerializable(explicitToJson: true)
  // ignore: invalid_annotation_target
  const factory ThemePageConfig({
    @Default(LoginPageConfig()) LoginPageConfig login,
    @Default(AboutPageConfig()) AboutPageConfig about,
    @Default(CallPageConfig()) CallPageConfig dialing,
    @Default(KeypadPageConfig()) KeypadPageConfig keypad,
  }) = _ThemePageConfig;

  factory ThemePageConfig.fromJson(Map<String, dynamic> json) => _$ThemePageConfigFromJson(json);
}

// TODO(Serdun): Decompose image properties into a separate class
// TODO(Serdun): Split LoginPageConfig, as it currently mixes data from the Welcome Page and various login pages.
/// Declarative configuration for the **Login Page**.
///
/// This configuration defines appearance, layout, and metadata options
/// for the [Login screen](https://github.com/WebTrit/webtrit_phone/tree/main/lib/features/login/view).
///
/// Typical use cases:
/// - Displaying a **picture/branding logo** on the login page.
/// - Adjusting **scaling** for different screen sizes.
/// - Defining **label colors** for UI elements.
/// - Configuring the **mode selection** page ([LoginModeSelectPageConfig]).
/// - Providing **structured metadata** (see [Metadata]) such as additional
///   resources, translations, or feature flags.
///
/// It also defines a globally consistent [metadataPictureUrl] key,
/// which can be used to associate a picture URL in metadata.
@Freezed()
class LoginPageConfig with _$LoginPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginPageConfig({
    /// Path or URL to the picture/logo displayed on the login page.
    String? picture,

    /// Scaling factor for the displayed picture/logo.
    double? scale,

    /// Color value for labels, defined as a HEX string (e.g. `#FF0000`).
    String? labelColor,

    /// Configuration for the **mode selection** screen.
    @Default(LoginModeSelectPageConfig()) LoginModeSelectPageConfig modeSelect,

    /// Metadata section with additional information such as links, version, etc.
    @Default(Metadata()) Metadata metadata,
  }) = _LoginPageConfig;

  factory LoginPageConfig.fromJson(Map<String, dynamic> json) => _$LoginPageConfigFromJson(json);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the login page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

@Freezed()
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginModeSelectPageConfig({
    OverlayStyleModel? systemUiOverlayStyle,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonLoginStyleType,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonSignupStyleType,
  }) = _LoginModeSelectPageConfig;

  factory LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) => _$LoginModeSelectPageConfigFromJson(json);
}

/// Declarative configuration for the **About Page**.
///
/// This configuration defines appearance and metadata options
/// for the [About screen](https://github.com/WebTrit/webtrit_phone/tree/main/lib/features/settings/features/about).
///
/// Typical use cases:
/// - Displaying a **picture/logo** on the About page.
/// - Providing **structured metadata** (see [Metadata]) such as app version,
///   build number, or links to external resources.
///
/// It also defines a globally consistent [metadataPictureUrl] key,
/// which can be used to associate a picture URL in metadata.
@Freezed()
class AboutPageConfig with _$AboutPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AboutPageConfig({
    /// Path or URL to the picture/logo displayed on the About page.
    String? picture,

    /// Metadata section with additional information such as version, build number, etc.
    @Default(Metadata()) Metadata metadata,
  }) = _AboutPageConfig;

  factory AboutPageConfig.fromJson(Map<String, dynamic> json) => _$AboutPageConfigFromJson(json);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the About page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

/// Declarative configuration for the **Call Screen**.
///
/// This configuration defines high-level appearance and behavior options
/// for the [Call screen views](https://github.com/WebTrit/webtrit_phone/tree/main/lib/features/call/view).
///
/// It provides a structured way to theme and customize:
/// - `systemUiOverlayStyle` — controls the **status bar / navigation bar**
///   colors and brightness for the call screen.
/// - `appBarStyle` — configuration for the **top AppBar** (icons, title, background).
/// - `callInfo` — configuration for the **call information block**
///   (see [CallPageInfoConfig] for username, number, and status styling).
///
/// This model is intended to be used in **theme definitions** and mapped
/// into [ThemeExtension]s for consistent UI across the app.
@Freezed()
class CallPageConfig with _$CallPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory CallPageConfig({
    /// System UI overlay style (status bar, navigation bar).
    OverlayStyleModel? systemUiOverlayStyle,

    /// Style configuration for the app bar (title, icons, background).
    AppBarStyleConfig? appBarStyle,

    /// Style configuration for the call information area (username, number, status).
    CallPageInfoConfig? callInfo,
  }) = _CallPageConfig;

  factory CallPageConfig.fromJson(Map<String, dynamic> json) => _$CallPageConfigFromJson(json);
}

/// Declarative configuration for the **Call Info section** on the call screen.
///
/// This model defines text styles for different parts of the call information
/// displayed in the [CallInfo widget](https://github.com/WebTrit/webtrit_phone/blob/main/lib/features/call/widgets/call_info.dart).
///
/// Typical usage:
/// - `usernameTextStyle` — large text for the main contact name (e.g. `displaySmall`).
/// - `numberTextStyle` — smaller text for the phone number (used when username is shown).
/// - `callStatusTextStyle` — status message style (e.g. “00:45” duration or “Incoming call”).
/// - `processingStatusTextStyle` — status of an active operation (e.g. “Transfer in progress”).
///
/// These configurations allow theming the **Call Info area** consistently across
/// the app without modifying widget code directly.
@freezed
class CallPageInfoConfig with _$CallPageInfoConfig {
  @JsonSerializable(explicitToJson: true)
  const factory CallPageInfoConfig({
    /// Style for the main username (displayed with `displaySmall`).
    TextStyleConfig? usernameTextStyle,

    /// Style for the phone number if username is present (bodyLarge or displaySmall).
    TextStyleConfig? numberTextStyle,

    /// Style for the call status message (e.g. duration or “incoming”).
    TextStyleConfig? callStatusTextStyle,

    /// Style for the processing status message (e.g. “Transfer in progress”).
    TextStyleConfig? processingStatusTextStyle,
  }) = _CallPageInfoConfig;

  factory CallPageInfoConfig.fromJson(Map<String, dynamic> json) => _$CallPageInfoConfigFromJson(json);
}

/// Declarative configuration for the **Keypad Screen**.
///
/// This model defines the visual and behavioral settings for the
/// [Keypad screen](https://github.com/WebTrit/webtrit_phone/tree/main/lib/features/keypad/view),
/// including the system UI overlay, input fields, keypad, and action pad.
///
/// Typical usage:
/// - `systemUiOverlayStyle` — controls the status bar and system navigation colors.
/// - `textField` — style configuration for the input field where the dialed number is shown.
/// - `contactName` — style configuration for displaying the resolved contact name below the input field.
/// - `keypad` — configuration of the numeric keypad (digits, subtexts, spacing, padding).
/// - `actionpad` — configuration of the action buttons (call, transfer, backspace, etc).
@Freezed()
class KeypadPageConfig with _$KeypadPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory KeypadPageConfig({
    /// System UI overlay configuration (status bar, navigation bar).
    OverlayStyleModel? systemUiOverlayStyle,

    /// Style for the number input field at the top of the keypad screen.
    TextFieldConfig? textField,

    /// Style for the contact name displayed under the number input.
    TextFieldConfig? contactName,

    /// Style configuration for the numeric keypad widget.
    KeypadStyleConfig? keypad,

    /// Style configuration for the action pad (call buttons, backspace, etc).
    ActionPadWidgetConfig? actionpad,
  }) = _KeypadPageConfig;

  factory KeypadPageConfig.fromJson(Map<String, dynamic> json) => _$KeypadPageConfigFromJson(json);
}
