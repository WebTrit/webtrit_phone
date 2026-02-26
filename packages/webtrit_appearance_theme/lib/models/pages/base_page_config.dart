import '../common/blurred_surface_config.dart';
import 'page_background.dart';

abstract class BasePageConfig {
  PageBackground? get background;

  String? get appBarBackgroundColor;

  BlurredSurfaceConfig? get appBarBlurredSurface;
}
