import 'package:auto_route/auto_route.dart';

import 'app_router.dart';
import '../constants.dart';

/// Resolves `/settings` and its declared sub-screens (e.g. `/settings/voicemail`) to a
/// [SettingsRouterPageRoute].
///
/// Shared by [HandleSettings] (external universal links) and [TextMatchers.urlMatcher]
/// (in-app links tapped from chat messages / system notifications), so both entry points
/// stay in sync with the settings route tree declared in `app_router.dart`.
class SettingsDeepLink {
  const SettingsDeepLink._();

  static bool matches(Uri uri) => uri.path == kSettingsRout || uri.path.startsWith('$kSettingsRout/');

  /// Returns `null` if [uri] isn't a settings path, or its sub-screen segment is unrecognised.
  static PageRouteInfo? resolve(Uri uri) {
    if (!matches(uri)) return null;

    final subScreen = uri.path.length > kSettingsRout.length ? uri.path.substring(kSettingsRout.length + 1) : '';

    PageRouteInfo? child;
    if (subScreen.isNotEmpty) {
      child = _subScreenRoute(subScreen);
      if (child == null) return null;
    }

    return SettingsRouterPageRoute(children: child != null ? [child] : null);
  }

  // 'self_config' is deliberately not mapped: SelfConfigScreenPageRoute requires a
  // `url` argument the deep link/tap has no way to supply.
  static PageRouteInfo? _subScreenRoute(String subScreen) => switch (subScreen) {
    'about' => const AboutScreenPageRoute(),
    'help' => HelpScreenPageRoute(),
    'language' => const LanguageScreenPageRoute(),
    'network' => const NetworkScreenPageRoute(),
    'media-settings' => const MediaSettingsScreenPageRoute(),
    'cache-management' => const CacheManagementScreenPageRoute(),
    'theme-mode' => const ThemeModeScreenPageRoute(),
    'dev-tools' => const DevToolsScreenPageRoute(),
    'diagnostic' => const DiagnosticScreenPageRoute(),
    'voicemail' => const VoicemailScreenPageRoute(),
    'presence' => const PresenceSettingsScreenPageRoute(),
    'caller-id' => const CallerIdSettingsScreenPageRoute(),
    _ => null,
  };
}
