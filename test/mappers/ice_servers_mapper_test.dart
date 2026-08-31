import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/mappers/mappers.dart';

class _Mapper with IceServersApiMapper {}

void main() {
  final now = DateTime.utc(2026, 8, 31, 10, 0, 0);
  final mapper = _Mapper();

  group('iceServersConfigFromApi', () {
    test('keeps the declared expiration', () {
      final expiresAt = now.add(const Duration(hours: 12));

      final config = withClock(
        Clock.fixed(now),
        () => mapper.iceServersConfigFromApi(api.IceServersResponse(ttl: 43200, expiresAt: expiresAt)),
      );

      expect(config.expiresAt, expiresAt);
    });

    test('resolves a relative ttl against the current time when no expiration is declared', () {
      final config = withClock(
        Clock.fixed(now),
        () => mapper.iceServersConfigFromApi(const api.IceServersResponse(ttl: 600)),
      );

      expect(config.expiresAt, now.add(const Duration(seconds: 600)));
    });

    test('treats a configuration declaring neither ttl nor expiration as already expired', () {
      final config = withClock(Clock.fixed(now), () => mapper.iceServersConfigFromApi(const api.IceServersResponse()));

      expect(config.expiresAt, now);
      expect(config.isDueForRefresh(now), isTrue);
    });

    test('renders entries as RTCIceServer maps, with credentials only where the backend sent them', () {
      final config = withClock(
        Clock.fixed(now),
        () => mapper.iceServersConfigFromApi(
          const api.IceServersResponse(
            iceServers: [
              api.IceServer(urls: ['stun:host:3478']),
              api.IceServer(urls: ['turn:host:3478?transport=udp'], username: 'user', credential: 'secret'),
            ],
          ),
        ),
      );

      expect(config.servers, [
        {
          'urls': ['stun:host:3478'],
        },
        {
          'urls': ['turn:host:3478?transport=udp'],
          'username': 'user',
          'credential': 'secret',
        },
      ]);
    });

    test('drops entries carrying no url', () {
      final config = withClock(
        Clock.fixed(now),
        () => mapper.iceServersConfigFromApi(
          const api.IceServersResponse(
            iceServers: [
              api.IceServer(urls: []),
              api.IceServer(urls: ['stun:host:3478']),
            ],
          ),
        ),
      );

      expect(config.servers, hasLength(1));
    });
  });
}
