import 'dart:convert';

import 'package:webtrit_phone/models/video_capturing_settings.dart';

mixin VideoCapturingSettingsJsonMapper {
  VideoCapturingSettings videoCapturingSettingsFromJson(String json) {
    return videoCapturingSettingsFromMap(jsonDecode(json));
  }

  String videoCapturingSettingsToJson(VideoCapturingSettings settings) {
    return jsonEncode(videoCapturingSettingsToMap(settings));
  }

  VideoCapturingSettings videoCapturingSettingsFromMap(Map<String, dynamic> map) {
    return VideoCapturingSettings(
      resolution: map['resolution'] != null ? Resolution.values.byName(map['resolution']) : null,
      framerate: map['framerate'] != null ? Framerate.values.byName(map['framerate']) : null,
    );
  }

  Map<String, dynamic> videoCapturingSettingsToMap(VideoCapturingSettings settings) {
    return {
      'resolution': settings.resolution?.name,
      'framerate': settings.framerate?.name,
    };
  }
}
