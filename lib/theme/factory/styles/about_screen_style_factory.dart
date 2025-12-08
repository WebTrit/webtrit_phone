import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class AboutScreenStyleFactory implements ThemeStyleFactory<AboutScreenStyles> {
  AboutScreenStyleFactory(this.config);

  final AboutPageConfig? config;

  @override
  AboutScreenStyles create() {
    final asset = config?.mainLogo?.uri?.toThemeSvgAsset();

    return AboutScreenStyles(primary: AboutScreenStyle(picture: asset));
  }
}
