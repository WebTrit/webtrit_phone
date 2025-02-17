import 'package:webtrit_phone/theme/models/models.dart';

import 'package:logging/logging.dart';

final _logger = Logger('StringExtension');

extension StringExt on String {
  ThemeSvgAsset? toThemeSvgAsset() {
    try {
      return ThemeSvgAsset.fromUri(this);
    } catch (e) {
      _logger.warning('Failed to parse ThemeSvgAsset from JSON: $this');
    }

    return null;
  }
}
