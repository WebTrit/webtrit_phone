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

  /// Set the bitrate for the video and audio.
  /// [video] and [audio] are in kbps.
  /// Range `32-4000kbps` for video and `8-256kbps` for audio.
  setBitrate(int? audio, int? video) {
    const rtpBitrateOvehead = 1.2;

    if (audio != null) audio = audio.clamp(8, 256);
    if (video != null) video = video.clamp(32, 4000);

    for (final kind in RTPCodecKind.values) {
      if (kind == RTPCodecKind.audio && audio == null) continue;
      if (kind == RTPCodecKind.video && video == null) continue;

      final bitrate = switch (kind) {
        RTPCodecKind.audio => audio!,
        RTPCodecKind.video => video!,
      };

      String as = (bitrate * rtpBitrateOvehead).toStringAsFixed(0);
      String tias = (bitrate * 1000).toStringAsFixed(0);

      final media = _getMedia(kind);

      media?['bandwidth'] = [
        {'type': 'AS', 'limit': as},
        {'type': 'TIAS', 'limit': tias}
      ];
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

    final rtps = media['rtp'] as List<dynamic>;
    final fmtps = media['fmtp'] as List<dynamic>;
    final rtcpFbs = media['rtcpFb'] as List<dynamic>;

    var rtxProfileId = fmtps.firstWhereOrNull((f) => f['config'] == 'apt=$profileId')?['payload'];

    rtps.removeWhere((r) => r['payload'] == profileId || r['payload'] == rtxProfileId);
    fmtps.removeWhere((f) => f['payload'] == profileId || f['payload'] == rtxProfileId);
    rtcpFbs.removeWhere((f) => f['payload'] == profileId);

    final payloadsList = (media['payloads'] as String).split(' ');
    final payloadsFiltered = payloadsList.where((p) => p != profileId.toString() && p != rtxProfileId.toString());
    media['payloads'] = payloadsFiltered.join(' ');
  }

  /// Reorder the media codecs by the given order.
  /// [profiles] is a list of RTPCodecProfile.
  /// [kind] is the kind of media profiles to reorder.
  /// Used to prioritize the codecs in the SDP negotiation.
  reorderProfiles(List<RTPCodecProfile> profiles, RTPCodecKind kind) {
    final media = _getMedia(kind);

    if (profiles.isNotEmpty && media != null) {
      final originalPayloads = (media['payloads'] as String).split(' ');
      final originalRtpMaps = media['rtp'] as List<dynamic>;
      final originalFmtps = media['fmtp'] as List<dynamic>;
      final originalRtcpFbs = media['rtcpFb'] as List<dynamic>;

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
