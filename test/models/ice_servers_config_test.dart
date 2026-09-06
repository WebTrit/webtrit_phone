import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  final expiresAt = DateTime.utc(2026, 8, 31, 22, 0, 0);
  final renewAt = expiresAt.subtract(IceServersConfig.renewalLeadTime);

  IceServersConfig config({List<Map<String, dynamic>>? servers, DateTime? expiration}) => IceServersConfig(
    servers:
        servers ??
        const [
          {
            'urls': ['stun:host:3478'],
          },
        ],
    expiresAt: expiration ?? expiresAt,
  );

  group('isDueForRefresh', () {
    test('is not due until the renewal lead time before expiration', () {
      final subject = config();

      expect(subject.isDueForRefresh(expiresAt.subtract(const Duration(hours: 5))), isFalse);
      expect(subject.isDueForRefresh(renewAt.subtract(const Duration(seconds: 1))), isFalse);
    });

    test('is due from the renewal point onwards', () {
      final subject = config();

      expect(subject.isDueForRefresh(renewAt), isTrue);
      expect(subject.isDueForRefresh(expiresAt), isTrue);
      expect(subject.isDueForRefresh(expiresAt.add(const Duration(hours: 1))), isTrue);
    });

    test('compares in UTC regardless of the zone of the given time', () {
      final subject = config();

      expect(subject.isDueForRefresh(renewAt.toLocal()), isTrue);
      expect(subject.isDueForRefresh(renewAt.subtract(const Duration(hours: 1)).toLocal()), isFalse);
    });

    test('normalizes a local expiration to UTC', () {
      final subject = config(expiration: expiresAt.toLocal());

      expect(subject.expiresAt, expiresAt);
      expect(subject.expiresAt.isUtc, isTrue);
    });
  });

  test('isEmpty reports a configuration without servers', () {
    expect(config(servers: const []).isEmpty, isTrue);
    expect(config().isEmpty, isFalse);
  });

  test('equality covers both the servers and the expiration', () {
    expect(config(), equals(config()));
    expect(config(), isNot(equals(config(expiration: expiresAt.add(const Duration(minutes: 1))))));
    expect(config(), isNot(equals(config(servers: const []))));
  });
}
