import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/feature_access/exports.dart';

import '../theme/models/models.dart';

final Logger _logger = Logger('FeatureAccess');

class FeatureAccess {
  static late FeatureAccess _instance;

  final CustomLoginFeature? customLoginFeature;

  FeatureAccess._(this.customLoginFeature);

  static Future<void> init(UiComposeSettings uiComposeSettings) async {
    try {
      final customLoginFeature = _tryEnableCustomLoginFeature(uiComposeSettings);

      _instance = FeatureAccess._(customLoginFeature);
    } catch (e, stackTrace) {
      _logger.severe('Failed to initialize FeatureAccess', e, stackTrace);
      rethrow;
    }
  }

  static CustomLoginFeature? _tryEnableCustomLoginFeature(UiComposeSettings uiComposeSettings) {
    final customLogin = uiComposeSettings.login?.customSignIn;
    _logger.info('Custom sign-in is enabled: $customLogin');

    return uiComposeSettings.isCustomSignInEnabled
        ? CustomLoginFeature(
            titleL10n: customLogin!.titleL10n!,
            uri: Uri.parse(customLogin.url!),
          )
        : null;
  }

  factory FeatureAccess() => _instance;
}
