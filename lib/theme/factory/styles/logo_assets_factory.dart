import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class LogoAssetsFactory implements ThemeStyleFactory<LogoAssets> {
  LogoAssetsFactory(this.config);

  final ImageAssetsConfig config;

  @override
  LogoAssets create() {
    final primaryOnboardingLogo = config.primaryOnboardingLogo;
    final secondaryOnboardingLogo = config.secondaryOnboardingLogo;

    final primaryOnboardingLogoUri =
        // TODO: Remove after migrating all themes to use imageSource
        // ignore: deprecated_member_use
        primaryOnboardingLogo.imageSource?.uri ?? primaryOnboardingLogo.uri;
    final secondaryOnboardingLogoUri =
        // TODO: Remove after migrating all themes to use imageSource
        // ignore: deprecated_member_use
        secondaryOnboardingLogo.imageSource?.uri ?? secondaryOnboardingLogo.uri;

    return LogoAssets(
      primaryOnboarding: primaryOnboardingLogoUri!.toThemeSvgAsset()!,
      secondaryOnboarding: secondaryOnboardingLogoUri!.toThemeSvgAsset()!,
    );
  }
}
