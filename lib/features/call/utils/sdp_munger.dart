// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:logging/logging.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/feature_access/encoding_config.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

final _logger = Logger('SDPMunger');

/// Modifies the SDP of a [RTCSessionDescription] object.
/// Used to change outgoing SDP before sending it to the server to change some specific parameters of negotiation.
abstract class SDPMunger {
  void apply(RTCSessionDescription description, [RTCSessionDescription negotiatedRemoteSdp]);
}

/// A class that modifies SDP (Session Description Protocol) with encoding settings.
///
/// This class implements the [SDPMunger] interface and provides functionality
/// to alter SDP based on [EncodingSettings] stored in [AppPreferences].
///
/// can be used to set bitrate, ptime, opus stereo & bandwidth
/// and audio/video profiles reordering and exclusion by settings.
class ModifyWithEncodingSettings implements SDPMunger {
  ModifyWithEncodingSettings(this._prefs, this._encodingConfig);

  final AppPreferences _prefs;
  final EncodingConfig _encodingConfig;

  EncodingSettings _makeSettings(EncodingPreset? preset) {
    final defaultPresetOverride = _encodingConfig.defaultPresetOverride;

    EncodingSettings settings = switch (preset) {
      null => EncodingSettings.defaultWithOverrides(
          audioBitrate: defaultPresetOverride.audioBitrate,
          videoBitrate: defaultPresetOverride.videoBitrate,
          ptime: defaultPresetOverride.ptime,
          maxptime: defaultPresetOverride.maxptime,
          opusBandwidthLimit: defaultPresetOverride.opusBandwidthLimit,
          opusStereo: defaultPresetOverride.opusStereo,
          opusDtx: defaultPresetOverride.opusDtx,
        ),
      EncodingPreset.eco => EncodingSettings.eco(),
      EncodingPreset.balance => EncodingSettings.balance(),
      EncodingPreset.quality => EncodingSettings.quality(),
      EncodingPreset.fullFlex => EncodingSettings.fullFlex(),
      EncodingPreset.custom => _prefs.getEncodingSettings(),
    };
    return settings;
  }

  @override
  void apply(RTCSessionDescription description, [RTCSessionDescription? negotiatedRemoteSdp]) {
    final bypass = _encodingConfig.bypassConfig;
    final configurationAllowed = _encodingConfig.configurationAllowed;

    if (bypass) return;

    final preset = configurationAllowed ? _prefs.getEncodingPreset() : null;
    EncodingSettings settings = _makeSettings(preset);

    final sdp = description.sdp;
    if (sdp == null) return;

    final builder = SDPModBuilder(sdp: sdp);
    bool modified = false;

    // If a previously negotiated remote SDP is available, extract the list of audio codecs
    // that are *not* present (i.e., unsupported by the remote party) and remove them from
    // the local offer to avoid SDP negotiation errors (e.g., caused by including opus when
    // it was not previously agreed upon).
    if (negotiatedRemoteSdp?.sdp case final remoteSdp?) {
      final unsupportedCodecs = builder.getUnsupportedCodecsFromSdp(remoteSdp, RTPCodecKind.audio);

      if (unsupportedCodecs.isNotEmpty) {
        _logger.info('SDP will remove unsupported codecs: $unsupportedCodecs');

        for (final profile in RTPCodecProfile.values) {
          final codecKey = profile.codec.sdpKey.toLowerCase();
          if (profile.kind == RTPCodecKind.audio && unsupportedCodecs.contains(codecKey)) {
            builder.removeProfile(profile);
            modified = true;
          }
        }
      }
    }

    if (settings.audioProfiles != null) {
      final profiles = settings.audioProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      toRemove.forEach((p) => builder.removeProfile(p));
      builder.reorderProfiles(toReorder, RTPCodecKind.audio);
      modified = true;
    }

    if (settings.videoProfiles != null) {
      final profiles = settings.videoProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      toRemove.forEach((p) => builder.removeProfile(p));
      builder.reorderProfiles(toReorder, RTPCodecKind.video);
      modified = true;
    }

    // Make sure to set codec parameters after profiles removing
    // because some params depends on codecs list

    if (settings.audioBitrate != null || settings.videoBitrate != null) {
      builder.setBitrate(settings.audioBitrate, settings.videoBitrate);
      modified = true;
    }

    if (settings.ptime != null || settings.maxptime != null) {
      builder.setPtime(settings.ptime, settings.maxptime);
      modified = true;
    }

    if (settings.opusBandwidthLimit != null || settings.opusStereo != null || settings.opusDtx != null) {
      builder.setOpusParams(settings.opusBandwidthLimit, settings.opusStereo, settings.opusDtx);
      modified = true;
    }

    if (modified) {
      _logger.info('SDP Modified with: $settings');
      final mod = builder.sdp;
      description.sdp = mod;
    }
  }
}
