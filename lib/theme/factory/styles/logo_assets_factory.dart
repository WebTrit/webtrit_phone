import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class LogoAssetsFactory implements ThemeStyleFactory<LogoAssets> {
  LogoAssetsFactory(this.config);

  final ImageAssetsConfig config;

  @override
  LogoAssets create() {
    final primaryOnboardingLogoPath = config.primaryOnboardingLogo;
    final secondaryOnboardingLogoPath = config.secondaryOnboardingLogo;

    return LogoAssets(
      primaryOnboarding: primaryOnboardingLogoPath.toThemeSvgAsset()!,
      secondaryOnboarding: secondaryOnboardingLogoPath.toThemeSvgAsset()!,
    );
  }
}
