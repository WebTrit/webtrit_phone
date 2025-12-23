import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';
import 'theme_image_style.dart';

class AboutScreenStyleFactory implements ThemeStyleFactory<AboutScreenStyles> {
  AboutScreenStyleFactory(this.config);

  final AboutPageConfig? config;

  @override
  AboutScreenStyles create() {
    final pictureLogoStyle = ThemeImageStyleFactory(source: config?.mainLogo).create();
    final backgroundStyle = config?.background?.toStyle();

    return AboutScreenStyles(
      primary: AboutScreenStyle(pictureLogoStyle: pictureLogoStyle, background: backgroundStyle),
    );
  }
}
