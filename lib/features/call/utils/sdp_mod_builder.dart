import 'package:sdp_transform/sdp_transform.dart' as sdp_transform;
import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

// TODO: cover with tests

class SDPModBuilder {
  SDPModBuilder({required String sdp}) : data = sdp_transform.parse(sdp);
  final Map<String, dynamic> data;

  /// Get the modified SDP string.
  String get sdp => sdp_transform.write(data, null);

  /// Sets the packetization-time for the audio codec.
  /// [ptime] is in milliseconds, range `10-120ms`
  /// Attects the packet size for transporting layer used to avoud MTU fitting issues.
  setPtime(int? ptime, int? maxptime) {
    final audioMedia = _getMedia(RTPCodecKind.audio);

    if (ptime != null) {
      ptime = ptime.clamp(10, 120);
      audioMedia?['ptime'] = ptime;
    }

    if (maxptime != null) {
      maxptime = maxptime.clamp(10, 120);
      if (ptime != null && ptime > maxptime) maxptime = ptime;
      audioMedia?['maxptime'] = maxptime;
    }
  }

  /// Sets the target bitrate for audio and video media sections in the SDP (in kbps).
  ///
  /// Bitrate values are clamped using [getMinBitrate] and [getMaxBitrate],
  /// and then applied via [_setBandwidth] to ensure proper SDP signaling.
  ///
  /// Pass `null` to skip setting bitrate for either media kind.
  void setBitrate(int? audio, int? video) {
    if (audio != null) {
      audio = audio.clamp(getMinBitrate(RTPCodecKind.audio), getMaxBitrate(RTPCodecKind.audio));
      final media = _getMedia(RTPCodecKind.audio);
      if (media != null) _setBandwidth(media, audio);
    }

    if (video != null) {
      video = video.clamp(getMinBitrate(RTPCodecKind.video), getMaxBitrate(RTPCodecKind.video));
      final media = _getMedia(RTPCodecKind.video);
      if (media != null) _setBandwidth(media, video);
    }
  }

  /// Set opus specific parameters
  /// [bandWidthLimit] limit maximum bandwidth in hz, range `8000-48000`.
  /// [stereo] stereo support on/off.
  /// [dtx] DTX support on/off.
  setOpusParams(int? bandWidthLimit, bool? stereo, bool? dtx) {
    final profileId = getProfileId(RTPCodecProfile.opus);
    if (profileId == null) return;

    final media = _getMedia(RTPCodecKind.audio);
    if (media == null) return;

    final fmtps = media['fmtp'] as List<dynamic>;

    for (var fmtp in fmtps) {
      if (fmtp['payload'] == profileId) {
        final config = fmtp['config'];
        if (config is! String) return;

        final configList = config.split(';');
        final configMap = <String, String>{};
        for (var item in configList) {
          final kv = item.split('=');
          if (kv.length == 2) configMap[kv[0]] = kv[1];
        }

        if (stereo != null) {
          configMap['stereo'] = stereo ? '1' : '0';
          configMap['sprop-stereo'] = stereo ? '1' : '0';
        }

        if (bandWidthLimit != null) {
          bandWidthLimit = bandWidthLimit.clamp(8000, 48000);
          configMap['maxplaybackrate'] = bandWidthLimit.toStringAsFixed(0);
          configMap['sprop-maxcapturerate'] = bandWidthLimit.toStringAsFixed(0);
        }

        if (dtx != null) {
          configMap['usedtx'] = dtx ? '1' : '0';
        }

        String newConfig = '';
        for (var item in configMap.entries) {
          newConfig += '${item.key}=${item.value}';
          final hasNext = item.key != configMap.entries.last.key;
          if (hasNext) newConfig += ';';
        }

        fmtp['config'] = newConfig;
      }
    }
  }

  /// Removes the codec profile and all associated records e.g. fmtp, rtcp-fb, rtx etc.
  removeProfile(RTPCodecProfile profile) {
    final profileId = getProfileId(profile);

    final media = _getMedia(profile.kind);
    if (media == null) return null;

    final originalPayloads = [];
    final originalRtpMaps = [];
    final originalFmtps = [];
    final originalRtcpFbs = [];

    if (media['payloads'] is String) originalPayloads.addAll((media['payloads'] as String).split(' '));
    if (media['rtp'] is List<dynamic>) originalRtpMaps.addAll(media['rtp'] as List<dynamic>);
    if (media['fmtp'] is List<dynamic>) originalFmtps.addAll(media['fmtp'] as List<dynamic>);
    if (media['rtcpFb'] is List<dynamic>) originalRtcpFbs.addAll(media['rtcpFb'] as List<dynamic>);

    var rtxProfileId = originalFmtps.firstWhereOrNull((f) => f['config'] == 'apt=$profileId')?['payload'];

    final modedPayloads = originalPayloads.where((p) => p != profileId.toString() && p != rtxProfileId.toString());
    final modedRtpMaps = originalRtpMaps.where((r) => r['payload'] != profileId && r['payload'] != rtxProfileId);
    final modedFmtps = originalFmtps.where((f) => f['payload'] != profileId && f['payload'] != rtxProfileId);
    final modedRtcpFbs = originalRtcpFbs.where((f) => f['payload'] != profileId);

    media['payloads'] = modedPayloads.join(' ');
    media['rtp'] = modedRtpMaps.toList();
    media['fmtp'] = modedFmtps.toList();
    media['rtcpFb'] = modedRtcpFbs.toList();
  }

  /// Reorder the media codecs by the given order.
  /// [profiles] is a list of RTPCodecProfile.
  /// [kind] is the kind of media profiles to reorder.
  /// Used to prioritize the codecs in the SDP negotiation.
  reorderProfiles(List<RTPCodecProfile> profiles, RTPCodecKind kind) {
    final media = _getMedia(kind);

    if (profiles.isNotEmpty && media != null) {
      final originalPayloads = [];
      final originalRtpMaps = [];
      final originalFmtps = [];
      final originalRtcpFbs = [];

      if (media['payloads'] is String) originalPayloads.addAll((media['payloads'] as String).split(' '));
      if (media['rtp'] is List<dynamic>) originalRtpMaps.addAll(media['rtp'] as List<dynamic>);
      if (media['fmtp'] is List<dynamic>) originalFmtps.addAll(media['fmtp'] as List<dynamic>);
      if (media['rtcpFb'] is List<dynamic>) originalRtcpFbs.addAll(media['rtcpFb'] as List<dynamic>);

      final newPayloads = <String>[];
      final reorderedRtpMaps = [];
      final reorderedFmtps = [];
      final reorderedRtcpFbs = [];

      for (var profile in profiles) {
        final profileId = getProfileId(profile);

        final rtpMap = originalRtpMaps.firstWhereOrNull((r) => r['payload'] == profileId);
        final fmtp = originalFmtps.firstWhereOrNull((f) => f['payload'] == profileId);
        final rtcpFb = originalRtcpFbs.firstWhereOrNull((f) => f['payload'] == profileId);

        final rtxFmtp = originalFmtps.firstWhereOrNull((f) => f['config'] == 'apt=$profileId');
        final rtxProfileId = rtxFmtp != null ? rtxFmtp['payload'] : null;
        final rtxRtpMap = originalRtpMaps.firstWhereOrNull((r) => r['payload'] == rtxProfileId);

        if (profileId != null) {
          newPayloads.add(profileId.toString());
          originalPayloads.remove(profileId.toString());
        }

        if (rtxProfileId != null) {
          newPayloads.add(rtxProfileId.toString());
          originalPayloads.remove(rtxProfileId.toString());
        }

        if (rtpMap != null) {
          reorderedRtpMaps.add(rtpMap);
          originalRtpMaps.remove(rtpMap);
        }

        if (fmtp != null) {
          reorderedFmtps.add(fmtp);
          originalFmtps.remove(fmtp);
        }
        if (rtcpFb != null) {
          reorderedRtcpFbs.add(rtcpFb);
          originalRtcpFbs.remove(rtcpFb);
        }

        if (rtxRtpMap != null) {
          reorderedRtpMaps.add(rtxRtpMap);
          originalRtpMaps.remove(rtxRtpMap);
        }
        if (rtxFmtp != null) {
          reorderedFmtps.add(rtxFmtp);
          originalFmtps.remove(rtxFmtp);
        }

        // Mix the reordered and rest of original records for the media that are not in the known profiles list.
        media['payloads'] = [...newPayloads, ...originalPayloads].join(' ');
        media['rtp'] = [...reorderedRtpMaps, ...originalRtpMaps];
        media['fmtp'] = [...reorderedFmtps, ...originalFmtps];
        media['rtcpFb'] = [...reorderedRtcpFbs, ...originalRtcpFbs];
      }
    }
  }

  /// Get the codec profile payload id.
  /// Return codec by specific profile using fmtp records for multiprofile codecs
  /// e.g. H264 with profile 42e01f, 42e034, 640c34 etc.
  /// Elsewhere return codec finded by rtp records.
  getProfileId(RTPCodecProfile profile) {
    final media = _getMedia(profile.kind);
    if (media == null) return null;

    final rtps = media['rtp'] as List<dynamic>;
    final fmtps = media['fmtp'] as List<dynamic>;

    final rtp = rtps.firstWhereOrNull((r) {
      final sameCodec = r['codec'] == profile.codec.sdpKey;
      final sameRate = r['rate'] == profile.rate;
      final sameChannels = r['encoding'] == profile.channels;

      return sameCodec && sameRate && sameChannels;
    });

    final fmtp = fmtps.firstWhereOrNull((f) {
      final levelId = profile.levelId;
      final config = f['config'];

      if (levelId != null && config is String) {
        return config.contains(levelId);
      }

      return false;
    });

    if (profile.codec == RTPCodec.h264) return fmtp?['payload'];
    return rtp?['payload'];
  }

  Map<String, dynamic>? _getMedia(RTPCodecKind kind) {
    return (data['media'] as List<dynamic>).firstWhereOrNull((m) => m['type'] == kind.name);
  }

  /// Applies default corrections to inbound SDP to ensure compatibility.
  ///
  /// Currently, this method ensures that the audio bitrate is not set below
  /// the minimum threshold required by the active audio codecs (e.g., Opus, G722).
  ///
  /// This helps prevent WebRTC negotiation errors or crashes caused by
  /// unsupported or invalid SDP parameters.
  void clean() {
    _fixInvalidAudioBitrate();
  }

  /// Validates and enforces a minimum audio bitrate to ensure inbound SDP  compatibility.
  ///
  /// This method checks whether the audio media section exists and applies a safe minimum bitrate
  /// required for stable WebRTC negotiation based on available codecs:
  ///
  /// - If Opus is present, uses 8 kbps as the minimum.
  /// - If Opus is not present, uses a fallback of 64 kbps.
  /// - The G722 check has been removed for simplicity and consistency.
  ///
  /// The method delegates bandwidth value construction (`AS` and `TIAS`) to [_setBandwidth],
  /// which ensures proper formatting and RTP overhead calculation.
  ///
  /// This correction helps prevent negotiation errors, poor audio quality, or client crashes
  /// due to unsupported or underspecified bandwidth settings.
  void _fixInvalidAudioBitrate() {
    final media = _getMedia(RTPCodecKind.audio);
    if (media == null) return;

    // Extract the original 'b=AS' bandwidth value, if present
    final originalBandwidth = media['bandwidth'] as List<dynamic>? ?? [];
    final originalAsLimitRaw = originalBandwidth.firstWhereOrNull((bw) => bw['type'] == 'AS')?['limit'];
    final originalAsLimit = parseBandwidthLimit(originalAsLimitRaw);

    // If the bandwidth is explicitly set to 0, treat it as a disabled stream and do not override
    if (originalAsLimit == 0) return;

    // Convert AS value (which includes RTP overhead) to approximate clean media bitrate (TIAS-equivalent)
    final originalBitrateKbps = (originalAsLimit / 1.2).round();

    // Get the minimum required bitrate based on active codecs (e.g., 8 kbps if Opus is present, 64 kbps otherwise)
    final minAudioBitrate = getMinBitrate(RTPCodecKind.audio);

    // If the original bitrate is below the codec's minimum, increase it; otherwise, keep as is
    final finalBitrateKbps = originalBitrateKbps >= minAudioBitrate ? originalBitrateKbps : minAudioBitrate;

    _setBandwidth(media, finalBitrateKbps);
  }

  /// Returns the minimum allowed bitrate (in kbps) for the given media kind,
  /// clamped to match the allowed codec ranges.
  ///
  /// - For audio:
  ///   - If Opus is available: min 8 kbps
  ///   - If Opus is not available: min 64 kbps (safe fallback)
  /// - For video: min 32 kbps
  int getMinBitrate(RTPCodecKind kind) {
    switch (kind) {
      case RTPCodecKind.audio:
        final hasOpus = getProfileId(RTPCodecProfile.opus) != null;
        final min = hasOpus ? 8 : 64;
        final max = getMaxBitrate(RTPCodecKind.audio);
        return min.clamp(min, max);

      case RTPCodecKind.video:
        const min = 32;
        final max = getMaxBitrate(RTPCodecKind.video);
        return min.clamp(min, max);
    }
  }

  /// Returns the maximum allowed bitrate (in kbps) for the given media kind.
  ///
  /// - For audio: `256 kbps`
  /// - For video: `4000 kbps`
  ///
  /// These limits are based on typical codec and transport layer constraints.
  /// Use this to clamp bitrate values to reasonable upper bounds during SDP generation or cleanup.
  int getMaxBitrate(RTPCodecKind kind) {
    switch (kind) {
      case RTPCodecKind.audio:
        return 256;
      case RTPCodecKind.video:
        return 4000;
    }
  }

  /// Sets the bandwidth information (`AS` and `TIAS`) for the given media section.
  ///
  /// This method calculates two bandwidth values based on the provided bitrate:
  /// - `AS` (Application Specific): includes RTP overhead, calculated as `bitrate * 1.2`
  /// - `TIAS` (Transport Independent Application Specific): exact bitrate in bits per second
  ///
  /// These values help browsers and endpoints interpret media constraints more accurately,
  /// and are particularly useful to avoid excessive or insufficient resource allocation.
  ///
  /// [media] is the media section (`audio` or `video`) to update in the parsed SDP map.
  /// [bitrateKbps] is the desired bitrate in kilobits per second (kbps).
  void _setBandwidth(Map<String, dynamic> media, int bitrateKbps) {
    const rtpBitrateOverhead = 1.2;

    final as = (bitrateKbps * rtpBitrateOverhead).toStringAsFixed(0);
    final tias = (bitrateKbps * 1000).toStringAsFixed(0);

    media['bandwidth'] = [
      {'type': 'AS', 'limit': as},
      {'type': 'TIAS', 'limit': tias}
    ];
  }

  int parseBandwidthLimit(dynamic value, [int defaultValue = 0]) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}

// Example of SDPs

// asus zf9
// v=0
// o=- 4775102109986320379 2 IN IP4 127.0.0.1
// s=-
// t=0 0
// a=group:BUNDLE 0 1
// a=extmap-allow-mixed
// a=msid-semantic: WMS 7df20cb1-0140-4448-b70d-94170778b25e

// m=audio 9 UDP/TLS/RTP/SAVPF 111 63 9 102 0 8 13 110 126
// c=IN IP4 0.0.0.0
// a=rtcp:9 IN IP4 0.0.0.0
// a=ice-ufrag:ClwD
// a=ice-pwd:UX6oNMEASmmfPDsFdxPis67H
// a=ice-options:trickle renomination
// a=fingerprint:sha-256 7B:BB:DB:AA:62:63:11:14:C6:C1:BA:DC:59:52:D7:2C:E3:E5:A7:81:E1:91:96:F2:DE:5C:04:43:9A:07:A4:19
// a=setup:actpass
// a=mid:0
// a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
// a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
// a=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
// a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
// a=sendrecv
// a=msid:7df20cb1-0140-4448-b70d-94170778b25e dacf0c99-908a-40b5-89ad-2f95ae0ec6cc
// a=rtcp-mux
// a=rtpmap:111 opus/48000/2
// a=rtcp-fb:111 transport-cc
// a=fmtp:111 minptime=10;useinbandfec=1
// a=rtpmap:63 red/48000/2
// a=fmtp:63 111/111
// a=rtpmap:9 G722/8000
// a=rtpmap:102 ILBC/8000
// a=rtpmap:0 PCMU/8000
// a=rtpmap:8 PCMA/8000
// a=rtpmap:13 CN/8000
// a=rtpmap:110 telephone-event/48000
// a=rtpmap:126 telephone-event/8000
// a=ssrc:267717870 cname:4PfP9kNMcKDO6Vpd
// a=ssrc:267717870 msid:7df20cb1-0140-4448-b70d-94170778b25e dacf0c99-908a-40b5-89ad-2f95ae0ec6cc

// m=video 9 UDP/TLS/RTP/SAVPF 127 103 104 105 96 97 39 40 98 99 106 107 108
// c=IN IP4 0.0.0.0
// a=rtcp:9 IN IP4 0.0.0.0
// a=ice-ufrag:ClwD
// a=ice-pwd:UX6oNMEASmmfPDsFdxPis67H
// a=ice-options:trickle renomination
// a=fingerprint:sha-256 7B:BB:DB:AA:62:63:11:14:C6:C1:BA:DC:59:52:D7:2C:E3:E5:A7:81:E1:91:96:F2:DE:5C:04:43:9A:07:A4:19
// a=setup:actpass
// a=mid:1
// a=extmap:14 urn:ietf:params:rtp-hdrext:toffset
// a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
// a=extmap:13 urn:3gpp:video-orientation
// a=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
// a=extmap:5 http://www.webrtc.org/experiments/rtp-hdrext/playout-delay
// a=extmap:6 http://www.webrtc.org/experiments/rtp-hdrext/video-content-type
// a=extmap:7 http://www.webrtc.org/experiments/rtp-hdrext/video-timing
// a=extmap:8 http://www.webrtc.org/experiments/rtp-hdrext/color-space
// a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
// a=extmap:10 urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id
// a=extmap:11 urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id
// a=sendrecv
// a=msid:7df20cb1-0140-4448-b70d-94170778b25e b7718f62-5f8b-452b-a335-768283ca4e53
// a=rtcp-mux
// a=rtcp-rsize
// a=rtpmap:127 H264/90000
// a=rtcp-fb:127 goog-remb
// a=rtcp-fb:127 transport-cc
// a=rtcp-fb:127 ccm fir
// a=rtcp-fb:127 nack
// a=rtcp-fb:127 nack pli
// a=fmtp:127 level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=42e01f
// a=rtpmap:103 rtx/90000
// a=fmtp:103 apt=127
// a=rtpmap:104 H265/90000
// a=rtcp-fb:104 goog-remb
// a=rtcp-fb:104 transport-cc
// a=rtcp-fb:104 ccm fir
// a=rtcp-fb:104 nack
// a=rtcp-fb:104 nack pli
// a=rtpmap:105 rtx/90000
// a=fmtp:105 apt=104
// a=rtpmap:96 VP8/90000
// a=rtcp-fb:96 goog-remb
// a=rtcp-fb:96 transport-cc
// a=rtcp-fb:96 ccm fir
// a=rtcp-fb:96 nack
// a=rtcp-fb:96 nack pli
// a=rtpmap:97 rtx/90000
// a=fmtp:97 apt=96
// a=rtpmap:39 AV1/90000
// a=rtcp-fb:39 goog-remb
// a=rtcp-fb:39 transport-cc
// a=rtcp-fb:39 ccm fir
// a=rtcp-fb:39 nack
// a=rtcp-fb:39 nack pli
// a=fmtp:39 level-idx=5;profile=0;tier=0
// a=rtpmap:40 rtx/90000
// a=fmtp:40 apt=39
// a=rtpmap:98 VP9/90000
// a=rtcp-fb:98 goog-remb
// a=rtcp-fb:98 transport-cc
// a=rtcp-fb:98 ccm fir
// a=rtcp-fb:98 nack
// a=rtcp-fb:98 nack pli
// a=fmtp:98 profile-id=0
// a=rtpmap:99 rtx/90000
// a=fmtp:99 apt=98
// a=rtpmap:106 red/90000
// a=rtpmap:107 rtx/90000
// a=fmtp:107 apt=106
// a=rtpmap:108 ulpfec/90000
// a=ssrc-group:FID 3418222294 3058890331
// a=ssrc:3418222294 cname:4PfP9kNMcKDO6Vpd
// a=ssrc:3418222294 msid:7df20cb1-0140-4448-b70d-94170778b25e b7718f62-5f8b-452b-a335-768283ca4e53
// a=ssrc:3058890331 cname:4PfP9kNMcKDO6Vpd
// a=ssrc:3058890331 msid:7df20cb1-0140-4448-b70d-94170778b25e b7718f62-5f8b-452b-a335-768283ca4e53

// iphone xs
// v=0
// o=- 1320896438136481616 2 IN IP4 127.0.0.1
// s=-
// t=0 0
// a=group:BUNDLE 0 1
// a=extmap-allow-mixed
// a=msid-semantic: WMS 69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0

// m=audio 9 UDP/TLS/RTP/SAVPF 111 63 9 102 0 8 13 110 126
// c=IN IP4 0.0.0.0
// a=rtcp:9 IN IP4 0.0.0.0
// a=ice-ufrag:TgQB
// a=ice-pwd:IzDF9OcdTBYkwzceskR7C826
// a=ice-options:trickle renomination
// a=fingerprint:sha-256 B5:E0:BA:C9:88:23:87:DB:C8:C9:7B:56:25:8D:05:C3:5F:D1:32:F1:2D:F0:95:C1:AC:F8:57:DE:8E:1C:62:C4
// a=setup:actpass
// a=mid:0
// a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
// a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
// a=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
// a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
// a=sendrecv
// a=msid:69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0 20585180-107B-4A5B-94DA-764DB3C012E2
// a=rtcp-mux
// a=rtpmap:111 opus/48000/2
// a=rtcp-fb:111 transport-cc
// a=fmtp:111 minptime=10;useinbandfec=1
// a=rtpmap:63 red/48000/2
// a=fmtp:63 111/111
// a=rtpmap:9 G722/8000
// a=rtpmap:102 ILBC/8000
// a=rtpmap:0 PCMU/8000
// a=rtpmap:8 PCMA/8000
// a=rtpmap:13 CN/8000
// a=rtpmap:110 telephone-event/48000
// a=rtpmap:126 telephone-event/8000
// a=ssrc:1404469274 cname:JRFjO02mxcKWkaF9
// a=ssrc:1404469274 msid:69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0 20585180-107B-4A5B-94DA-764DB3C012E2

// m=video 9 UDP/TLS/RTP/SAVPF 96 97 98 99 100 101 127 103 35 36 104 105 106
// c=IN IP4 0.0.0.0
// a=rtcp:9 IN IP4 0.0.0.0
// a=ice-ufrag:TgQB
// a=ice-pwd:IzDF9OcdTBYkwzceskR7C826
// a=ice-options:trickle renomination
// a=fingerprint:sha-256 B5:E0:BA:C9:88:23:87:DB:C8:C9:7B:56:25:8D:05:C3:5F:D1:32:F1:2D:F0:95:C1:AC:F8:57:DE:8E:1C:62:C4
// a=setup:actpass
// a=mid:1
// a=extmap:14 urn:ietf:params:rtp-hdrext:toffset
// a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
// a=extmap:13 urn:3gpp:video-orientation
// a=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
// a=extmap:5 http://www.webrtc.org/experiments/rtp-hdrext/playout-delay
// a=extmap:6 http://www.webrtc.org/experiments/rtp-hdrext/video-content-type
// a=extmap:7 http://www.webrtc.org/experiments/rtp-hdrext/video-timing
// a=extmap:8 http://www.webrtc.org/experiments/rtp-hdrext/color-space
// a=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
// a=extmap:10 urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id
// a=extmap:11 urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id
// a=sendrecv
// a=msid:69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0 756C2FD9-48CB-4B62-B81E-72846683A435
// a=rtcp-mux
// a=rtcp-rsize
// a=rtpmap:96 H264/90000
// a=rtcp-fb:96 goog-remb
// a=rtcp-fb:96 transport-cc
// a=rtcp-fb:96 ccm fir
// a=rtcp-fb:96 nack
// a=rtcp-fb:96 nack pli
// a=fmtp:96 level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=640c34
// a=rtpmap:97 rtx/90000
// a=fmtp:97 apt=96
// a=rtpmap:98 H264/90000
// a=rtcp-fb:98 goog-remb
// a=rtcp-fb:98 transport-cc
// a=rtcp-fb:98 ccm fir
// a=rtcp-fb:98 nack
// a=rtcp-fb:98 nack pli
// a=fmtp:98 level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=42e034
// a=rtpmap:99 rtx/90000
// a=fmtp:99 apt=98
// a=rtpmap:100 VP8/90000
// a=rtcp-fb:100 goog-remb
// a=rtcp-fb:100 transport-cc
// a=rtcp-fb:100 ccm fir
// a=rtcp-fb:100 nack
// a=rtcp-fb:100 nack pli
// a=rtpmap:101 rtx/90000
// a=fmtp:101 apt=100
// a=rtpmap:127 VP9/90000
// a=rtcp-fb:127 goog-remb
// a=rtcp-fb:127 transport-cc
// a=rtcp-fb:127 ccm fir
// a=rtcp-fb:127 nack
// a=rtcp-fb:127 nack pli
// a=rtpmap:103 rtx/90000
// a=fmtp:103 apt=127
// a=rtpmap:35 AV1/90000
// a=rtcp-fb:35 goog-remb
// a=rtcp-fb:35 transport-cc
// a=rtcp-fb:35 ccm fir
// a=rtcp-fb:35 nack
// a=rtcp-fb:35 nack pli
// a=rtpmap:36 rtx/90000
// a=fmtp:36 apt=35
// a=rtpmap:104 red/90000
// a=rtpmap:105 rtx/90000
// a=fmtp:105 apt=104
// a=rtpmap:106 ulpfec/90000
// a=ssrc-group:FID 3914854143 3851073852
// a=ssrc:3914854143 cname:JRFjO02mxcKWkaF9
// a=ssrc:3914854143 msid:69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0 756C2FD9-48CB-4B62-B81E-72846683A435
// a=ssrc:3851073852 cname:JRFjO02mxcKWkaF9
// a=ssrc:3851073852 msid:69F8EBC5-1F6C-43BE-8B5A-0FF484EF8EF0 756C2FD9-48CB-4B62-B81E-72846683A435
