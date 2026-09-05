import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockExternalContactsRepository extends Mock implements ExternalContactsRepository {}

class MockContactsRepository extends Mock implements ContactsRepository {}

final _testUser = UserInfo(
  numbers: Numbers(main: '1000', additional: []),
  balance: Balance(amount: 0, currency: 'USD'),
);

final _contactSelf = ExternalContact(
  id: '1000',
  firstName: 'Self',
  lastName: 'User',
  number: '1000',
  registered: true,
  userRegistered: true,
);

final _contactOther = ExternalContact(
  id: '2000',
  firstName: 'Other',
  lastName: 'User',
  number: '2000',
  registered: true,
  userRegistered: true,
);

void main() {
  late MockUserRepository userRepository;
  late MockExternalContactsRepository externalContactsRepository;
  late MockContactsRepository contactsRepository;
  late ExternalContactsSyncWorker worker;

  setUp(() {
    userRepository = MockUserRepository();
    externalContactsRepository = MockExternalContactsRepository();
    contactsRepository = MockContactsRepository();

    when(() => userRepository.getLocalInfo()).thenReturn(_testUser);
    when(() => userRepository.getAndListen()).thenAnswer((_) => Stream.value(_testUser));
    when(() => externalContactsRepository.fetchContacts()).thenAnswer((_) async => [_contactSelf, _contactOther]);
    when(() => contactsRepository.syncExternalContacts(any())).thenAnswer((_) async {});

    worker = ExternalContactsSyncWorker(
      userRepository: userRepository,
      externalContactsRepository: externalContactsRepository,
      contactsRepository: contactsRepository,
    );
  });

  tearDown(() => worker.dispose());

  group('ExternalContactsSyncWorker', () {
    test('starts in syncing until the first cycle resolves', () {
      expect(worker.status, ExternalContactsSyncStatus.syncing);
    });

    test('one refresh cycle fetches, filters out the current user and syncs', () async {
      await worker.refresh();

      expect(worker.status, ExternalContactsSyncStatus.synced);
      verify(
        () => contactsRepository.syncExternalContacts(
          any(
            that: isA<List<ExternalContact>>()
                .having((list) => list.length, 'length', 1)
                .having((list) => list.first.id, 'id', _contactOther.id),
          ),
        ),
      ).called(1);
    });

    test('a failed fetch rethrows and reports the failed status', () async {
      when(() => externalContactsRepository.fetchContacts()).thenThrow(Exception('offline'));

      await expectLater(worker.refresh(), throwsException);
      expect(worker.status, ExternalContactsSyncStatus.failed);
    });

    test('status transitions are published and every cycle re-enters syncing', () async {
      final statuses = <ExternalContactsSyncStatus>[];
      final sub = worker.statusStream.listen(statuses.add);

      await worker.refresh();
      when(() => externalContactsRepository.fetchContacts()).thenThrow(Exception('offline'));
      await worker.refresh().catchError((_) {});
      await Future<void>.delayed(Duration.zero);

      // The first cycle starts from the initial syncing (deduplicated), the
      // second re-enters it - so the empty-state Refresh shows progress.
      expect(statuses, [
        ExternalContactsSyncStatus.synced,
        ExternalContactsSyncStatus.syncing,
        ExternalContactsSyncStatus.failed,
      ]);
      await sub.cancel();
    });

    test('an unchanged list does not touch the local store again', () async {
      await worker.refresh();
      await worker.refresh();

      verify(() => contactsRepository.syncExternalContacts(any())).called(1);
      expect(worker.status, ExternalContactsSyncStatus.synced);
    });

    test('a changed list is merged again', () async {
      await worker.refresh();
      when(() => externalContactsRepository.fetchContacts()).thenAnswer((_) async => [_contactOther, _contactSelf]);
      when(() => userRepository.getLocalInfo()).thenReturn(_testUser);
      when(() => externalContactsRepository.fetchContacts())
          .thenAnswer((_) async => [_contactOther]..removeWhere((c) => false));
      await worker.refresh();

      // Same filtered content -> still one merge; now change it for real.
      when(() => externalContactsRepository.fetchContacts()).thenAnswer((_) async => []);
      await worker.refresh();

      verify(() => contactsRepository.syncExternalContacts(any())).called(2);
    });

    test('a user-info stream that never emits fails the cycle instead of wedging it', () {
      fakeAsync((async) {
        when(() => userRepository.getLocalInfo()).thenReturn(null);
        final silent = StreamController<UserInfo>.broadcast();
        addTearDown(silent.close);
        when(() => userRepository.getAndListen()).thenAnswer((_) => silent.stream);

        Object? failure;
        worker.refresh().catchError((Object e) => failure = e);
        async.elapse(const Duration(seconds: 15));

        expect(failure, isA<TimeoutException>(), reason: 'the cycle must give up, not hang the shared future');
        expect(worker.status, ExternalContactsSyncStatus.failed);

        // The next cycle is a fresh run, not the wedged future.
        when(() => userRepository.getLocalInfo()).thenReturn(_testUser);
        var recovered = false;
        worker.refresh().then((_) => recovered = true);
        async.flushMicrotasks();
        expect(recovered, isTrue);
      });
    });

    test('transient store errors are retried within one cycle', () {
      fakeAsync((async) {
        var attempts = 0;
        when(() => contactsRepository.syncExternalContacts(any())).thenAnswer((_) async {
          attempts++;
          if (attempts < 3) throw Exception('transient');
        });

        var completed = false;
        worker.refresh().then((_) => completed = true);
        async.elapse(const Duration(seconds: 5));

        expect(completed, isTrue);
        expect(attempts, 3);
        expect(worker.status, ExternalContactsSyncStatus.synced);
      });
    });

    test('a refresh landing during a running cycle rides it instead of doubling', () async {
      var fetches = 0;
      when(() => externalContactsRepository.fetchContacts()).thenAnswer((_) async {
        fetches++;
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return [_contactOther];
      });

      final first = worker.refresh();
      final second = worker.refresh();
      await Future.wait([first, second]);

      expect(fetches, 1, reason: 'the second caller must ride the in-flight cycle');

      await worker.refresh();
      expect(fetches, 2, reason: 'a later refresh starts a fresh cycle');
    });

    test('a persistently failing store fails the cycle after the retries', () {
      fakeAsync((async) {
        when(() => contactsRepository.syncExternalContacts(any())).thenThrow(Exception('broken'));

        Object? failure;
        worker.refresh().catchError((Object e) => failure = e);
        async.elapse(const Duration(seconds: 10));

        expect(failure, isException);
        expect(worker.status, ExternalContactsSyncStatus.failed);
      });
    });
  });
}
