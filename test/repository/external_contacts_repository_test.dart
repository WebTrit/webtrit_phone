import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/repositories/repositories.dart';

class MockWebtritApiClient extends Mock implements api.WebtritApiClient {}

void main() {
  late MockWebtritApiClient apiClient;
  late ExternalContactsRepository repository;

  const contact = api.UserContact(
    userId: '2000',
    numbers: api.Numbers(main: '2000', ext: '2000', additional: []),
  );

  setUp(() {
    apiClient = MockWebtritApiClient();
    repository = ExternalContactsRepository(webtritApiClient: apiClient, token: 'token');
    when(() => apiClient.getUserContactList(any())).thenAnswer((_) async => [contact]);
  });

  group('ExternalContactsRepository', () {
    // Regression: fetches are driven by the polling leading cycle, which may
    // complete before a consumer subscribes; a late subscriber must still
    // receive the last known list.
    test('contacts() replays the last known list to a late subscriber', () async {
      await repository.refresh();

      final replayed = await repository.contacts().first;
      expect(replayed.length, 1);
      expect(replayed.first.id, '2000');
    });

    test('contacts() without any fetch yet waits for the first emission', () async {
      final firstFuture = repository.contacts().first;

      await repository.refresh();

      final first = await firstFuture;
      expect(first.first.id, '2000');
    });
  });
}
