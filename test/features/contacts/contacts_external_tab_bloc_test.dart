import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockContactsBloc extends MockBloc<ContactsEvent, ContactsState> implements ContactsBloc {}

class MockContactsSyncProgress extends Mock implements ContactsSyncProgress {}

void main() {
  late MockContactsRepository contactsRepository;
  late MockContactsBloc searchBloc;
  late MockContactsSyncProgress syncProgress;

  setUp(() {
    contactsRepository = MockContactsRepository();
    searchBloc = MockContactsBloc();
    syncProgress = MockContactsSyncProgress();

    when(() => contactsRepository.watchContacts('', ContactSourceType.external))
        .thenAnswer((_) => Stream.value(const <Contact>[]));
    when(() => searchBloc.state).thenReturn(const ContactsState(sourceType: ContactSourceType.external));
    when(() => syncProgress.statusStream).thenAnswer((_) => const Stream.empty());
  });

  ContactsExternalTabBloc build() => ContactsExternalTabBloc(
    contactsRepository: contactsRepository,
    contactsSearchBloc: searchBloc,
    syncProgress: syncProgress,
  );

  void withSyncStatus(ExternalContactsSyncStatus syncStatus) {
    when(() => syncProgress.status).thenReturn(syncStatus);
  }

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'syncing with an empty cache maps to inProgress (loading), not failure',
    setUp: () => withSyncStatus(ExternalContactsSyncStatus.syncing),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>()
          .having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress)
          .having((s) => s.contacts, 'contacts', isEmpty),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'synced with an empty cache maps to success (empty state, not loading)',
    setUp: () => withSyncStatus(ExternalContactsSyncStatus.synced),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'failed maps to failure',
    setUp: () => withSyncStatus(ExternalContactsSyncStatus.failed),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'worker status transitions arrive through the stream',
    setUp: () {
      withSyncStatus(ExternalContactsSyncStatus.syncing);
      when(() => syncProgress.statusStream)
          .thenAnswer((_) => Stream.fromIterable(const [ExternalContactsSyncStatus.synced]));
    },
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
  );
}
