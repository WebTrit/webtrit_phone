import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockWebtritApiClient extends Mock implements WebtritApiClient {}

void main() {
  const token = 'token_1';
  final now = DateTime.utc(2026, 8, 31, 10, 0, 0);

  late _MockWebtritApiClient apiClient;
  late IceServersRepositoryImpl repository;

  /// The first instant at which a configuration fetched at [fetchedAt] is due,
  /// yet still valid - what a background renewal is about.
  DateTime renewalPoint(DateTime fetchedAt) =>
      fetchedAt.add(const Duration(seconds: 43200)).subtract(IceServersConfig.renewalLeadTime);

  IceServersResponse response({int? ttl = 43200, DateTime? expiresAt, List<IceServer>? servers}) => IceServersResponse(
    ttl: ttl,
    expiresAt: expiresAt ?? now.add(const Duration(seconds: 43200)),
    iceServers:
        servers ??
        const [
          IceServer(urls: ['stun:host:3478']),
          IceServer(urls: ['turn:host:3478?transport=udp'], username: 'user', credential: 'secret'),
        ],
  );

  setUp(() {
    apiClient = _MockWebtritApiClient();
    repository = IceServersRepositoryImpl(webtritApiClient: apiClient, token: token);
  });

  tearDown(() => repository.dispose());

  group('refresh', () {
    test('fetches and caches the configuration on the first tick', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      await withClock(Clock.fixed(now), repository.refresh);
      final servers = await withClock(Clock.fixed(now), repository.resolveIceServers);

      expect(servers, hasLength(2));
      verify(() => apiClient.getUserIceServers(token)).called(1);
    });

    test('is a noop while the cached configuration is still fresh', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      await withClock(Clock.fixed(now), repository.refresh);
      await withClock(Clock.fixed(now.add(const Duration(hours: 5))), repository.refresh);

      verify(() => apiClient.getUserIceServers(token)).called(1);
    });

    test('refetches once the cached configuration approaches expiration', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      await withClock(Clock.fixed(now), repository.refresh);
      // The response expires 12 h out, so the renewal point is the lead time
      // short of that.
      await withClock(Clock.fixed(renewalPoint(now)), repository.refresh);

      verify(() => apiClient.getUserIceServers(token)).called(2);
    });

    test('does not cache a configuration without servers', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response(servers: const []));

      await withClock(Clock.fixed(now), repository.refresh);
      final servers = await withClock(Clock.fixed(now), repository.resolveIceServers);

      expect(servers, kFallbackRtcIceServers);
    });

    test('reports a transport failure without throwing, and the next tick retries', () async {
      when(() => apiClient.getUserIceServers(token)).thenThrow(Exception('offline'));

      await withClock(Clock.fixed(now), repository.refresh);
      await withClock(Clock.fixed(now), repository.refresh);

      expect(repository.isActive, isTrue);
      verify(() => apiClient.getUserIceServers(token)).called(2);
    });
  });

  group('resolveIceServers', () {
    test('returns the fetched servers when nothing is cached yet', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      final servers = await withClock(Clock.fixed(now), repository.resolveIceServers);

      expect(servers, [
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

    test('serves the cached configuration without another request', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      await withClock(Clock.fixed(now), repository.refresh);
      await withClock(Clock.fixed(now.add(const Duration(hours: 1))), repository.resolveIceServers);

      verify(() => apiClient.getUserIceServers(token)).called(1);
    });

    test('falls back to the public STUN server when the fetch fails', () async {
      when(() => apiClient.getUserIceServers(token)).thenThrow(Exception('offline'));

      final servers = await withClock(Clock.fixed(now), repository.resolveIceServers);

      expect(servers, kFallbackRtcIceServers);
    });

    test('falls back when the fetch outlives the first-fetch timeout', () {
      fakeAsync((async) {
        when(() => apiClient.getUserIceServers(token))
            .thenAnswer((_) => Future.delayed(kIceServersFirstFetchTimeout * 2, response));

        List<Map<String, dynamic>>? servers;
        withClock(Clock.fixed(now), () {
          repository.resolveIceServers().then((value) => servers = value);
        });
        async.elapse(kIceServersFirstFetchTimeout);
        async.flushMicrotasks();

        expect(servers, kFallbackRtcIceServers);

        // Let the delayed request settle so the fake zone drains cleanly.
        async.elapse(kIceServersFirstFetchTimeout * 2);
      });
    });

    test('serves a due configuration while the renewal runs in the background', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());
      await withClock(Clock.fixed(now), repository.refresh);

      // Past the renewal point but before the declared expiration: the cached
      // credentials still work, so the call must not wait for the refetch.
      final servers = await withClock(Clock.fixed(renewalPoint(now)), repository.resolveIceServers);

      expect(servers, hasLength(2));
      verify(() => apiClient.getUserIceServers(token)).called(2);
    });

    test('issues one request for concurrent resolves', () async {
      when(() => apiClient.getUserIceServers(token)).thenAnswer((_) async => response());

      await withClock(
        Clock.fixed(now),
        () => Future.wait([repository.resolveIceServers(), repository.resolveIceServers()]),
      );

      verify(() => apiClient.getUserIceServers(token)).called(1);
    });
  });

  group('EmptyIceServersRepository', () {
    test('always resolves the fallback and cannot be polled', () async {
      const empty = EmptyIceServersRepository();

      expect(await empty.resolveIceServers(), kFallbackRtcIceServers);
      expect(empty, isNot(isA<Refreshable>()));
    });
  });
}
