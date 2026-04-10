import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/features/call/utils/sdp_mod_builder.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

void main() {
  group('SDPModBuilder', () {
    test('setPtime configures ptime and maxptime', () {
      final builder = _buildBuilder();
      builder.setPtime(50, 100);

      final result = builder.sdp;
      expect(result, contains('a=ptime:50'));
      expect(result, contains('a=maxptime:100'));
    });

    test('setPtime clamps both values', () {
      final builder = _buildBuilder();
      builder.setPtime(200, 5);

      final result = builder.sdp;
      expect(result, contains('a=ptime:120'));
      expect(result, contains('a=maxptime:120'));
    });

    test('setBitrate configures bandwidth for audio and video', () {
      final builder = _buildBuilder();

      builder.setBitrate(128, 2000);

      final result = builder.sdp;
      expect(result, contains('b=AS:154'));
      expect(result, contains('b=TIAS:128000'));
      expect(result, contains('b=AS:2400'));
      expect(result, contains('b=TIAS:2000000'));
    });

    test('setBitrate clamps both values', () {
      final builder = _buildBuilder();

      builder.setBitrate(999, 6000);

      final result = builder.sdp;
      expect(result, contains('b=AS:307'));
      expect(result, contains('b=TIAS:256000'));
      expect(result, contains('b=AS:4800'));
      expect(result, contains('b=TIAS:4000000'));
    });

    test('setOpusParams overrides fmtp config map', () {
      final builder = _buildBuilder();

      builder.setOpusParams(16000, 64, true, false);

      final fmtpLine = _line(builder.sdp, 'a=fmtp:111');
      expect(fmtpLine, contains('stereo=1'));
      expect(fmtpLine, contains('sprop-stereo=1'));
      expect(fmtpLine, contains('maxplaybackrate=16000'));
      expect(fmtpLine, contains('sprop-maxcapturerate=16000'));
      expect(fmtpLine, contains('maxaveragebitrate=64000'));
      expect(fmtpLine, contains('usedtx=0'));
    });

    test('removeProfile drops codec and related RTX entries', () {
      final builder = _buildBuilder();

      builder.removeProfile(RTPCodecProfile.vp8);

      final result = builder.sdp;
      final videoLine = _line(result, 'm=video');
      expect(videoLine, equals('m=video 9 UDP/TLS/RTP/SAVPF 127 103 39 40 200'));
      expect(result, isNot(contains('a=rtpmap:96 VP8/90000')));
      expect(result, isNot(contains('a=rtpmap:97 rtx/90000')));
      expect(result, isNot(contains('a=fmtp:96 ')));
      expect(result, isNot(contains('a=fmtp:97 ')));
    });

    test('reorderProfiles prioritizes provided codecs while keeping others', () {
      final builder = _buildBuilder();

      builder.reorderProfiles([RTPCodecProfile.av1, RTPCodecProfile.vp8], RTPCodecKind.video);

      final result = builder.sdp;
      final videoLine = _line(result, 'm=video');
      expect(videoLine, equals('m=video 9 UDP/TLS/RTP/SAVPF 39 40 96 97 127 103 200'));
      expect(result.indexOf('a=rtpmap:39 AV1/90000'), lessThan(result.indexOf('a=rtpmap:127 H264/90000')));
      expect(result.indexOf('a=rtpmap:96 VP8/90000'), lessThan(result.indexOf('a=rtpmap:127 H264/90000')));
    });

    test('removeAudioExtmaps drops ext definitions', () {
      final builder = _buildBuilder();

      builder.removeAudioExtmaps();

      final result = builder.sdp;
      expect(result, isNot(contains('a=extmap:1 ')));
      expect(result, isNot(contains('a=extmap:2 ')));
    });

    test('removeStaticAudioRtpMaps strips static payload metadata', () {
      final builder = _buildBuilder();

      builder.removeStaticAudioRtpMaps();

      final result = builder.sdp;
      for (final removed in ['a=rtpmap:0 ', 'a=rtpmap:8 ', 'a=rtpmap:9 ', 'a=rtpmap:13 ']) {
        expect(result, isNot(contains(removed)));
      }
      expect(result, isNot(contains('a=fmtp:8 ')));
      expect(result, isNot(contains('a=rtcp-fb:9 ')));
    });

    test('remapTE8payloadTo101 updates telephone-event entries', () {
      final builder = _buildBuilder();

      builder.remapTE8payloadTo101();

      final result = builder.sdp;
      final audioLine = _line(result, 'm=audio');
      expect(audioLine, equals('m=audio 9 UDP/TLS/RTP/SAVPF 111 63 101 0 8 2 9 13 18'));
      expect(result, contains('a=rtpmap:101 telephone-event/8000'));
      expect(result, isNot(contains('a=rtpmap:126 telephone-event/8000')));
      expect(result, contains('a=fmtp:101 0-15'));
      expect(result, isNot(contains('a=fmtp:126 0-15')));
      expect(result, contains('a=rtcp-fb:101 nack'));
      expect(result, isNot(contains('a=rtcp-fb:126 nack')));
    });

    test('remove unknown audio profiles', () {
      final builder = _buildBuilder();

      builder.removeUnknownProfiles(RTPCodecKind.audio);

      final result = builder.sdp;
      final audioLine = _line(result, 'm=audio');
      expect(audioLine, equals('m=audio 9 UDP/TLS/RTP/SAVPF 111 63 126 0 8 9 13'));
      expect(result, isNot(contains('a=rtpmap:18 G729a/8000')));
      expect(result, isNot(contains('a=rtpmap:2 G726-32/8000')));
    });
  });
}

SDPModBuilder _buildBuilder() => SDPModBuilder(sdp: _baseSdp);

String _line(String sdp, String prefix) {
  final lines = sdp.split('\r\n');
  return lines.firstWhere((line) => line.startsWith(prefix), orElse: () => '');
}

const String _baseSdp =
    'v=0\r\n'
    'o=- 0 0 IN IP4 127.0.0.1\r\n'
    's=-\r\n'
    't=0 0\r\n'
    'a=group:BUNDLE 0 1\r\n'
    'm=audio 9 UDP/TLS/RTP/SAVPF 111 63 126 0 8 2 9 13 18\r\n'
    'c=IN IP4 0.0.0.0\r\n'
    'a=mid:0\r\n'
    'a=sendrecv\r\n'
    'a=ptime:20\r\n'
    'a=maxptime:60\r\n'
    'a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level\r\n'
    'a=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time\r\n'
    'a=rtpmap:111 opus/48000/2\r\n'
    'a=fmtp:111 minptime=10;useinbandfec=1\r\n'
    'a=rtcp-fb:111 transport-cc\r\n'
    'a=rtpmap:63 red/48000/2\r\n'
    'a=fmtp:63 111/111\r\n'
    'a=rtpmap:126 telephone-event/8000\r\n'
    'a=fmtp:126 0-15\r\n'
    'a=rtcp-fb:126 nack\r\n'
    'a=rtpmap:0 PCMU/8000\r\n'
    'a=rtpmap:8 PCMA/8000\r\n'
    'a=fmtp:8 vad=on\r\n'
    'a=rtpmap:9 G722/8000\r\n'
    'a=rtcp-fb:9 nack\r\n'
    'a=rtpmap:13 CN/8000\r\n'
    'a=rtpmap:18 G729a/8000\r\n'
    'a=rtpmap:2 G726-32/8000\r\n'
    'm=video 9 UDP/TLS/RTP/SAVPF 127 103 39 40 96 97 200\r\n'
    'c=IN IP4 0.0.0.0\r\n'
    'a=mid:1\r\n'
    'a=sendrecv\r\n'
    'a=rtpmap:127 H264/90000\r\n'
    'a=fmtp:127 packetization-mode=1;profile-level-id=42e01f\r\n'
    'a=rtcp-fb:127 transport-cc\r\n'
    'a=rtpmap:103 rtx/90000\r\n'
    'a=fmtp:103 apt=127\r\n'
    'a=rtpmap:39 AV1/90000\r\n'
    'a=fmtp:39 profile=0\r\n'
    'a=rtcp-fb:39 transport-cc\r\n'
    'a=rtpmap:40 rtx/90000\r\n'
    'a=fmtp:40 apt=39\r\n'
    'a=rtpmap:96 VP8/90000\r\n'
    'a=fmtp:96 max-fs=12288\r\n'
    'a=rtcp-fb:96 transport-cc\r\n'
    'a=rtpmap:97 rtx/90000\r\n'
    'a=fmtp:97 apt=96\r\n'
    'a=rtpmap:200 H265/90000\r\n'
    'a=fmtp:200 profile-id=1\r\n';
