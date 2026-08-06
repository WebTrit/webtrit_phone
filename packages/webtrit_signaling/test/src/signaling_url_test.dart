/// The connect URL is the whole contract with the server for the connect flags:
/// if a parameter name drifts, the app silently keeps attaching to a session it
/// asked to have rebuilt, and nothing else in the suite would notice (WT-1766).
library;

import 'package:test/test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

void main() {
  final baseUrl = Uri.parse('https://core.example.com');

  test('a plain connect carries the token and force, and nothing more', () {
    final url = WebtritSignalingClient.buildSignalingUrl(baseUrl, '', 'tok', true);

    expect(url.path, endsWith('/signaling/v1'));
    expect(url.queryParameters, {'token': 'tok', 'force': 'true'});
  });

  test('a session rebuild is requested as reregister=true', () {
    final url = WebtritSignalingClient.buildSignalingUrl(baseUrl, '', 'tok', true, reregister: true);

    expect(url.queryParameters['reregister'], 'true');
  });

  test('a tenant is kept in the path', () {
    final url = WebtritSignalingClient.buildSignalingUrl(baseUrl, 'acme', 'tok', false);

    expect(url.path, contains('acme'));
    expect(url.path, endsWith('/signaling/v1'));
  });
}
