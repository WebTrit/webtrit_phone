import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';
import '../../extension/extension.dart';

class AboutScreenStyleFactory implements ThemeStyleFactory<AboutScreenStyles> {
  AboutScreenStyleFactory(this.config);

  final LoginPageConfig? config;

  @override
  AboutScreenStyles create() {
    final picturePath = config?.picture;
    final picture = picturePath?.toThemeSvgAsset();

    return AboutScreenStyles(
      primary: AboutScreenStyle(
        picture: picture,
      ),
    );
  }
}
