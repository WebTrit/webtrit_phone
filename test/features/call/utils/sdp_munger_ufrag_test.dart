import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdp_transform/sdp_transform.dart' as sdp_transform;

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/features/call/utils/sdp_mod_builder.dart';
import 'package:webtrit_phone/features/call/utils/sdp_munger.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/feature_access/encoding_config.dart';
import 'package:webtrit_phone/repositories/encoding_preset/encoding_preset_repository.dart';
import 'package:webtrit_phone/repositories/encoding_settings/encoding_settings_repository.dart';

// Probe: can the SDP munger (sdp_transform parse -> mutate -> write) alter the
// local answer ICE ufrag and produce a value shorter than 4 chars, which
// setLocalDescription rejects ("ICE ufrag must be between 4 and 256")?
//
// Focus: purely-numeric and hex-prefixed ufrags. sdp_transform's parser runs
// every captured token through toIntIfInt(), so such a ufrag becomes an int and
// leading zeros / hex notation are lost on write (e.g. 0048 -> 48, 0X48 -> 72).
// pwd is 22 base64 chars, so it is practically never all-numeric and survives -
// matching the observed "short ufrag + full pwd" corruption shape.

String _answerSdp(String ufrag, String pwd) =>
    'v=0\r\n'
    'o=- 4775102109986320379 2 IN IP4 127.0.0.1\r\n'
    's=-\r\n'
    't=0 0\r\n'
    'a=group:BUNDLE 0\r\n'
    'a=msid-semantic: WMS *\r\n'
    'm=audio 9 UDP/TLS/RTP/SAVPF 111 9 0 8\r\n'
    'c=IN IP4 0.0.0.0\r\n'
    'a=rtcp:9 IN IP4 0.0.0.0\r\n'
    'a=ice-ufrag:$ufrag\r\n'
    'a=ice-pwd:$pwd\r\n'
    'a=ice-options:trickle\r\n'
    'a=fingerprint:sha-256 AE:C5:30:32:BF:5C:27:B1:18:EB:2C:C6:26:2C:DA:E0:9A:EE:41:C9:E6:B7:9E:FE:50:AD:9E:56:E2:C6:9C:95\r\n'
    'a=setup:active\r\n'
    'a=mid:0\r\n'
    'a=sendrecv\r\n'
    'a=rtcp-mux\r\n'
    'a=rtpmap:111 opus/48000/2\r\n'
    'a=fmtp:111 minptime=10;useinbandfec=1\r\n'
    'a=rtpmap:9 G722/8000\r\n'
    'a=rtpmap:0 PCMU/8000\r\n'
    'a=rtpmap:8 PCMA/8000\r\n';

// A realistic 22-char base64 ICE pwd.
const _pwd = 'i/t5V07djNTEAYr75Avl1rCf';

class _MockEncodingPresetRepository extends Mock implements EncodingPresetRepository {}

class _MockEncodingSettingsRepository extends Mock implements EncodingSettingsRepository {}

// DefaultPresetOverride is required by EncodingConfig but unused on the preset
// branch below (balance returns a self-contained EncodingSettings).
const _override = DefaultPresetOverride(
  audioBitrate: null,
  videoBitrate: null,
  ptime: null,
  maxptime: null,
  opusSamplingRate: null,
  opusBitrate: null,
  opusStereo: null,
  opusDtx: null,
  removeStaticAudioRtpMaps: null,
  remapTE8payloadTo101: null,
);

void main() {
  // The mechanism in isolation: does the parser itself coerce a numeric ufrag?
  group('sdp_transform parse coercion (root mechanism)', () {
    for (final ufrag in ['0048', '0123', '0001', '0000', '7200', '0X48', 'fMNB', 'la/s']) {
      test('iceUfrag survives parse as the literal "$ufrag"', () {
        final parsed = sdp_transform.parse(_answerSdp(ufrag, _pwd));
        final media = (parsed['media'] as List<dynamic>).first as Map<String, dynamic>;
        expect(
          media['iceUfrag'].toString(),
          ufrag,
          reason: 'parser coerced ufrag (toIntIfInt) - leading zeros / type lost',
        );
      });
    }
  });

  // End-to-end through our builder: parse -> a real mutation -> write.
  group('SDPModBuilder round-trip preserves ICE ufrag', () {
    for (final ufrag in ['fMNB', 'la/s', 'a+b1', '7200', '0048', '0123', '0001', '0000', '0X48']) {
      test('ufrag "$ufrag" unchanged after setBitrate mutation', () {
        final builder = SDPModBuilder(sdp: _answerSdp(ufrag, _pwd));
        builder.setBitrate(64, null); // force a modification so .sdp re-serializes

        final out = builder.sdp;

        expect(out, contains('a=ice-ufrag:$ufrag'), reason: 'munger round-trip corrupted ufrag "$ufrag"');
        expect(out, contains('a=ice-pwd:$_pwd'), reason: 'munger round-trip corrupted pwd');

        // Direct length check against the real validation rule.
        final m = RegExp(r'a=ice-ufrag:(\S*)').firstMatch(out);
        final outUfrag = m?.group(1) ?? '';
        expect(
          outUfrag.length,
          greaterThanOrEqualTo(4),
          reason: 'ufrag "$ufrag" emerged shorter than 4 chars ("$outUfrag") - setLocalDescription would reject',
        );
      });
    }
  });

  // The real production munger (ModifyWithEncodingSettings) end-to-end: the same
  // object call_bloc invokes on the local answer (sdpMunger?.apply(localDescription)).
  // With the balance preset the opus path fires, so apply() re-serializes the SDP.
  group('ModifyWithEncodingSettings.apply preserves ICE ufrag', () {
    late _MockEncodingPresetRepository presetRepo;
    late ModifyWithEncodingSettings munger;

    setUp(() {
      presetRepo = _MockEncodingPresetRepository();
      when(() => presetRepo.getEncodingPreset()).thenReturn(EncodingPreset.balance);
      munger = ModifyWithEncodingSettings(
        _MockEncodingSettingsRepository(),
        const EncodingConfig(bypassConfig: false, configurationAllowed: true, defaultPresetOverride: _override),
        presetRepo,
      );
    });

    for (final ufrag in ['fMNB', '7200', '0048', '0001', '0X48']) {
      test('ufrag "$ufrag" unchanged after apply()', () {
        final description = RTCSessionDescription(_answerSdp(ufrag, _pwd), 'answer');

        munger.apply(description);

        final out = description.sdp ?? '';
        final outUfrag = RegExp(r'a=ice-ufrag:(\S*)').firstMatch(out)?.group(1) ?? '';
        expect(outUfrag, ufrag, reason: 'production munger corrupted ufrag "$ufrag" -> "$outUfrag"');
        expect(
          outUfrag.length,
          greaterThanOrEqualTo(4),
          reason: 'ufrag "$ufrag" emerged shorter than 4 chars ("$outUfrag") - setLocalDescription would reject',
        );
      });
    }
  });
}
