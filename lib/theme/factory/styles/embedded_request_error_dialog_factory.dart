import 'package:webtrit_phone/features/login/features/login_signup/widgets/embedded_request_error_dialog.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class EmbeddedRequestErrorDialogFactory implements ThemeStyleFactory<EmbeddedRequestErrorStyles> {
  EmbeddedRequestErrorDialogFactory(this.config);

  final ImageAssetsConfig? config;

  @override
  EmbeddedRequestErrorStyles create() {
    return EmbeddedRequestErrorStyles(
      primary: EmbeddedRequestErrorStyle(picture: config?.defaultPlaceholderImage?.uri?.toThemeSvgAsset()),
    );
  }
}
