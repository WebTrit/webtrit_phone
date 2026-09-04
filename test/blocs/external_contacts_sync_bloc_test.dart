import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/blocs/external_contacts_sync/external_contacts_sync_bloc.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockExternalContactsRepository extends Mock implements ExternalContactsRepository {}

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockOnDemandRefresher extends Mock implements OnDemandRefresher {}

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
  late MockOnDemandRefresher contactsRefresher;
  late ExternalContactsSyncBloc bloc;

  setUp(() {
    userRepository = MockUserRepository();
    externalContactsRepository = MockExternalContactsRepository();
    contactsRepository = MockContactsRepository();
    contactsRefresher = MockOnDemandRefresher();

    when(() => userRepository.getAndListen()).thenAnswer((_) => Stream.value(_testUser));
    when(() => contactsRefresher.refreshNow()).thenAnswer((_) async {});
    when(() => contactsRepository.syncExternalContacts(any())).thenAnswer((_) async {});

    bloc = ExternalContactsSyncBloc(
      userRepository: userRepository,
      externalContactsRepository: externalContactsRepository,
      contactsRepository: contactsRepository,
      contactsRefresher: contactsRefresher,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('ExternalContactsSyncBloc', () {
    test('initial state is ExternalContactsSyncInitial', () {
      bloc = ExternalContactsSyncBloc(
        userRepository: userRepository,
        externalContactsRepository: externalContactsRepository,
        contactsRepository: contactsRepository,
        contactsRefresher: contactsRefresher,
      );
      expect(bloc.state, const ExternalContactsSyncInitial());
    });

    blocTest<ExternalContactsSyncBloc, ExternalContactsSyncState>(
      'emits RefreshInProgress and refreshes through the port on ExternalContactsSyncRefreshed',
      build: () {
        when(() => externalContactsRepository.contacts()).thenAnswer((_) => Stream.value([]));
        return ExternalContactsSyncBloc(
          userRepository: userRepository,
          externalContactsRepository: externalContactsRepository,
          contactsRepository: contactsRepository,
          contactsRefresher: contactsRefresher,
        );
      },
      act: (bloc) => bloc.add(const ExternalContactsSyncRefreshed()),
      expect: () => [const ExternalContactsSyncRefreshInProgress()],
      verify: (_) {
        verify(() => contactsRefresher.refreshNow()).called(1);
        verifyNever(() => externalContactsRepository.load());
      },
    );

    blocTest<ExternalContactsSyncBloc, ExternalContactsSyncState>(
      'emits RefreshFailure when the port refresh fails',
      build: () {
        when(() => externalContactsRepository.contacts()).thenAnswer((_) => Stream.value([]));
        when(() => contactsRefresher.refreshNow()).thenThrow(Exception('offline'));
        return ExternalContactsSyncBloc(
          userRepository: userRepository,
          externalContactsRepository: externalContactsRepository,
          contactsRepository: contactsRepository,
          contactsRefresher: contactsRefresher,
        );
      },
      act: (bloc) => bloc.add(const ExternalContactsSyncRefreshed()),
      expect: () => [const ExternalContactsSyncRefreshInProgress(), const ExternalContactsSyncRefreshFailure()],
    );

    blocTest<ExternalContactsSyncBloc, ExternalContactsSyncState>(
      'start subscribes to the repository without fetching on its own',
      build: () {
        when(() => externalContactsRepository.contacts()).thenAnswer((_) => Stream.value([]));
        return ExternalContactsSyncBloc(
          userRepository: userRepository,
          externalContactsRepository: externalContactsRepository,
          contactsRepository: contactsRepository,
          contactsRefresher: contactsRefresher,
        );
      },
      act: (bloc) => bloc.add(const ExternalContactsSyncStarted()),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verifyNever(() => externalContactsRepository.load());
        verifyNever(() => contactsRefresher.refreshNow());
      },
    );

    blocTest<ExternalContactsSyncBloc, ExternalContactsSyncState>(
      'filters out current user contact and syncs the rest when repository emits contacts',
      build: () {
        when(() => externalContactsRepository.contacts())
            .thenAnswer((_) => Stream.value([_contactSelf, _contactOther]));

        return ExternalContactsSyncBloc(
          userRepository: userRepository,
          externalContactsRepository: externalContactsRepository,
          contactsRepository: contactsRepository,
          contactsRefresher: contactsRefresher,
        );
      },
      act: (bloc) => bloc.add(const ExternalContactsSyncStarted()),
      wait: const Duration(milliseconds: 100),
      expect: () => [const ExternalContactsSyncSuccess()],
      verify: (_) {
        verify(
          () => contactsRepository.syncExternalContacts(
            any(
              that: isA<List<ExternalContact>>()
                  .having((list) => list.length, 'length', 1)
                  .having((list) => list.first.id, 'id', _contactOther.id),
            ),
          ),
        ).called(1);
      },
    );

    blocTest<ExternalContactsSyncBloc, ExternalContactsSyncState>(
      'emits RefreshFailure if load() fails',
      build: () {
        when(() => externalContactsRepository.contacts()).thenAnswer((_) => Stream.value([_contactOther]));
        when(() => userRepository.getAndListen()).thenAnswer((_) => Stream.error(Exception('User info error')));

        return ExternalContactsSyncBloc(
          userRepository: userRepository,
          externalContactsRepository: externalContactsRepository,
          contactsRepository: contactsRepository,
          contactsRefresher: contactsRefresher,
        );
      },
      act: (bloc) => bloc.add(const ExternalContactsSyncStarted()),
      wait: const Duration(seconds: 5),
      expect: () => [const ExternalContactsSyncUpdateFailure()],
    );
  });
}
