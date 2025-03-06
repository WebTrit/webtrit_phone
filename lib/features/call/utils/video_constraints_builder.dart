import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

/// Builds WebRTC video constraints for the call.
abstract class VideoConstraintsBuilder {
  Map<String, String> build();
}

/// A builder class that constructs video constraints based on the application's settings.
///
/// This class implements the [VideoConstraintsBuilder] interface and provides
/// functionality to create video constraints that are tailored to the specific
/// settings and requirements of the application.
class VideoConstraintsWithAppSettingsBuilder implements VideoConstraintsBuilder {
  VideoConstraintsWithAppSettingsBuilder(this._prefs);

  final AppPreferences _prefs;

  @override
  Map<String, String> build() {
    final settings = _prefs.getVideoCapturingSettings();
    final resolution = settings.resolution;
    final framerate = settings.framerate;

    return {
      if (resolution != null) ...{
        'minWidth': switch (resolution) {
          Resolution.p360 => '640',
          Resolution.p480 => '854',
          Resolution.p720 => '1280',
          Resolution.p1080 => '1920',
        },
        'minHeight': switch (resolution) {
          Resolution.p360 => '360',
          Resolution.p480 => '480',
          Resolution.p720 => '720',
          Resolution.p1080 => '1080',
        },
      } else ...{
        'minWidth': '1280',
        'minHeight': '720',
      },
      if (framerate != null) ...{
        'minFrameRate': switch (framerate) {
          Framerate.f25 => '25',
          Framerate.f30 => '30',
          Framerate.f50 => '50',
          Framerate.f60 => '60',
        },
      } else ...{
        'minFrameRate': '30',
      },
    };
  }
}
