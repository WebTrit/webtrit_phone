// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:logging/logging.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

final _logger = Logger('SDPMunger');

/// Modifies the SDP of a [RTCSessionDescription] object.
/// Used to change outgoing SDP before sending it to the server to change some specific parameters of negotiation.
abstract class SDPMunger {
  void apply(RTCSessionDescription description);
}

/// A class that modifies SDP (Session Description Protocol) with encoding settings.
///
/// This class implements the [SDPMunger] interface and provides functionality
/// to alter SDP based on [EncodingSettings] stored in [AppPreferences].
///
/// can be used to set bitrate, ptime, opus stereo & bandwidth
/// and audio/video profiles reordering and exclusion by settings.
class ModifyWithEncodingSettings implements SDPMunger {
  ModifyWithEncodingSettings(this._prefs);

  final AppPreferences _prefs;

  @override
  void apply(RTCSessionDescription description) {
    final settings = _prefs.getEncodingSettings();

    final sdp = description.sdp;
    if (sdp == null) return;

    final builder = SDPModBuilder(sdp: sdp);
    bool modified = false;

    if (settings.audioBitrate != null || settings.videoBitrate != null) {
      _logger.info('Setting bitrate audio:${settings.audioBitrate} video:${settings.videoBitrate}');
      builder.setBitrate(settings.audioBitrate, settings.videoBitrate);
      modified = true;
    }

    if (settings.ptime != null || settings.maxptime != null) {
      _logger.info('Setting audio ptime:${settings.ptime} maxptime:${settings.maxptime}');
      builder.setPtime(settings.ptime, settings.maxptime);
      modified = true;
    }

    if (settings.opusBandwidthLimit != null || settings.opusStereo != null || settings.opusDtx != null) {
      _logger.info('Setting opus params, stereo:${settings.opusStereo} bandwidth:${settings.opusBandwidthLimit}');
      builder.setOpusParams(settings.opusBandwidthLimit, settings.opusStereo, settings.opusDtx);
      modified = true;
    }

    if (settings.audioProfiles != null) {
      final profiles = settings.audioProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      _logger.info('Audio profiles to remove: $toRemove');
      _logger.info('Audio profiles to reorder: $toReorder');

      toRemove.forEach((p) => builder.removeProfile(p));
      builder.reorderProfiles(toReorder, RTPCodecKind.audio);
      modified = true;
    }

    if (settings.videoProfiles != null) {
      final profiles = settings.videoProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      _logger.info('Video profiles to remove: $toRemove');
      _logger.info('Video profiles to reorder: $toReorder');

      toRemove.forEach((p) => builder.removeProfile(p));
      builder.reorderProfiles(toReorder, RTPCodecKind.video);
      modified = true;
    }

    if (modified) {
      _logger.info('SDP Modified with: $settings');
      final mod = builder.sdp;
      _logger.finest('Original SDP: $sdp');
      _logger.finest('Modified SDP: $mod');
      description.sdp = mod;
    }
  }
}
