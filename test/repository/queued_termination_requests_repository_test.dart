import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';

void main() {
  const prefsKey = 'queued-termination-requests';

  group('QueuedTerminationRequestsRepositoryPrefsImpl', () {
    late MockAppPreferences appPreferences;
    late QueuedTerminationRequestsRepositoryPrefsImpl repository;

    final hangupRequest = QueuedTerminationRequest(
      type: QueuedTerminationRequestType.hangup,
      callId: 'call-1',
      line: 1,
    );
    final declineRequest = QueuedTerminationRequest(
      type: QueuedTerminationRequestType.decline,
      callId: 'call-2',
      line: 2,
    );

    setUp(() {
      appPreferences = MockAppPreferences();
      repository = QueuedTerminationRequestsRepositoryPrefsImpl(appPreferences);
    });

    test('getAll returns empty map when prefs is empty', () {
      expect(repository.getAll, isEmpty);
    });

    test('put stores request in cache and persistence layer', () {
      repository.put(hangupRequest);

      final all = repository.getAll;
      expect(all.length, 1);
      expect(all[hangupRequest.key]?.type, QueuedTerminationRequestType.hangup);
      expect(all[hangupRequest.key]?.callId, 'call-1');
      expect(all[hangupRequest.key]?.line, 1);
      expect(appPreferences.getString(prefsKey), isNotNull);
    });

    test('remove deletes request by key', () {
      repository.put(hangupRequest);
      repository.put(declineRequest);

      repository.remove(hangupRequest);

      final all = repository.getAll;
      expect(all.length, 1);
      expect(all.containsKey(hangupRequest.key), isFalse);
      expect(all.containsKey(declineRequest.key), isTrue);
    });

    test('clear removes all requests and deletes persisted key', () async {
      repository.put(hangupRequest);

      await repository.clear();

      expect(repository.getAll, isEmpty);
      expect(appPreferences.getString(prefsKey), isNull);
    });

    test('getAll returns unmodifiable map snapshot', () {
      repository.put(hangupRequest);

      final all = repository.getAll;
      expect(
        () => all['new'] = QueuedTerminationRequest(
          type: QueuedTerminationRequestType.decline,
          callId: 'call-3',
          line: null,
        ),
        throwsUnsupportedError,
      );
    });

    test('hydrates queued requests from valid json in preferences', () {
      final payload = QueuedTerminationRequestJsonMapper.toJson({
        hangupRequest.key: hangupRequest,
        declineRequest.key: declineRequest,
      });

      final hydratedPrefs = MockAppPreferences(initialData: {prefsKey: payload});
      final hydratedRepo = QueuedTerminationRequestsRepositoryPrefsImpl(hydratedPrefs);

      final all = hydratedRepo.getAll;
      expect(all.length, 2);
      expect(all[hangupRequest.key]?.type, QueuedTerminationRequestType.hangup);
      expect(all[declineRequest.key]?.type, QueuedTerminationRequestType.decline);
    });

    test('returns empty map on malformed persisted json', () {
      final malformedPrefs = MockAppPreferences(initialData: {prefsKey: '{invalid'});
      final malformedRepo = QueuedTerminationRequestsRepositoryPrefsImpl(malformedPrefs);

      expect(malformedRepo.getAll, isEmpty);
    });
  });
}
