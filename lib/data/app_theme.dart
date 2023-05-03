import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'package:style/style.dart';

import 'app_yaml.dart';

class AppTheme {
  static late AppTheme _instance;

  static Future<void> init() async {
    StyleManager.setting(
      host: AppYaml().publisherConfig.host,
    );

    StyleManager.init(
        applicationId: AppYaml().publisherConfig.applicationId,
        themeId: AppYaml().publisherConfig.themeId,
        defaultTheme: Assets.style.webtrit);

    final styleModel = await StyleManager().get();

    final imageScheme = ImagesScheme()
      ..setApplicationLogoByUrl(styleModel.images!.applicationLogo)
      ..setOnboardingByUrl(styleModel.images!.onboarding);

    final colorScheme = ColorSchemeOverride(
      primary: styleModel.colors?.primaryColor,
      onPrimary: styleModel.colors?.onPrimaryColor,
      onSurface: styleModel.colors?.onSurfaceColor,
      surface: styleModel.colors?.surfaceColor,
      onSecondaryContainer: styleModel.colors?.onSecondaryContainerColor,
      secondaryContainer: styleModel.colors?.secondaryContainerColor,
      tertiary: styleModel.colors?.tertiaryColor,
      error: styleModel.colors?.errorColor,
      secondary: styleModel.colors?.secondaryColor,
      outline: styleModel.colors?.outlineColor,
      background: styleModel.colors?.backgroundColor,
      onBackground: styleModel.colors?.onBackgroundColor,
    );

    final gradientTabColor =
        (styleModel.colors?.gradientTabColor ?? []).map((color) => CustomColor(color: color, blend: false)).toList();

    final theme = ThemeSettings(
      seedColor: styleModel.colors!.primaryColor!,
      imagesScheme: imageScheme,
      lightColorSchemeOverride: colorScheme,
      primaryGradientColors: gradientTabColor,
      fontFamily: styleModel.fontFamily ?? 'Montserrat',
    );

    _instance = AppTheme._(theme);
  }

  factory AppTheme() {
    return _instance;
  }

  AppTheme._(this._theme);

  ThemeSettings _theme;

  ThemeSettings get theme => _theme;
}
