import '../common/blurred_surface_config.dart';
import '../theme_widget_config.dart';
import 'page_background.dart';

abstract class BasePageConfig {
  PageBackground? get background;

  BlurredSurfaceConfig? get appBarBlurredSurface;

  AppBarConfig? get appBarStyle;
}
