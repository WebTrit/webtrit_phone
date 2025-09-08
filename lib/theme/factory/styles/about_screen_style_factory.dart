import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';
import '../../extension/extension.dart';

class AboutScreenStyleFactory implements ThemeStyleFactory<AboutScreenStyles> {
  AboutScreenStyleFactory(this.config);

  final LoginPageConfig? config;

  @override
  AboutScreenStyles create() {
    final imageSource = config?.imageSource?.uri ??
        // TODO: Remove after migrating all themes to use imageSource
        // ignore: deprecated_member_use
        config?.picture;
    final picture = imageSource?.toThemeSvgAsset();

    return AboutScreenStyles(
      primary: AboutScreenStyle(
        picture: picture,
      ),
    );
  }
}
