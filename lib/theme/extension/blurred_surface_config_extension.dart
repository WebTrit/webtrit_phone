import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'package:webtrit_phone/widgets/blurred_surface.dart';

import 'theme_json_serializable.dart';

extension BlurredSurfaceConfigExtension on BlurredSurfaceConfig {
  BlurredSurfaceStyle toStyle() {
    return BlurredSurfaceStyle(color: color?.toColor(), sigmaX: sigmaX, sigmaY: sigmaY);
  }
}
