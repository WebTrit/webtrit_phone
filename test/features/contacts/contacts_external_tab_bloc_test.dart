import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockContactsBloc extends MockBloc<ContactsEvent, ContactsState> implements ContactsBloc {}

class MockExternalContactsSyncBloc extends MockBloc<ExternalContactsSyncEvent, ExternalContactsSyncState>
    implements ExternalContactsSyncBloc {}

void main() {
  late MockContactsRepository contactsRepository;
  late MockContactsBloc searchBloc;
  late MockExternalContactsSyncBloc syncBloc;

  setUp(() {
    contactsRepository = MockContactsRepository();
    searchBloc = MockContactsBloc();
    syncBloc = MockExternalContactsSyncBloc();

    when(
      () => contactsRepository.watchContacts('', ContactSourceType.external),
    ).thenAnswer((_) => Stream.value(const <Contact>[]));
    when(() => searchBloc.state).thenReturn(const ContactsState(sourceType: ContactSourceType.external));
  });

  ContactsExternalTabBloc build() => ContactsExternalTabBloc(
    contactsRepository: contactsRepository,
    contactsSearchBloc: searchBloc,
    externalContactsSyncBloc: syncBloc,
  );

  void withSyncState(ExternalContactsSyncState syncState) {
    when(() => syncBloc.state).thenReturn(syncState);
  }

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'sync Initial with an empty cache maps to inProgress (loading), not failure',
    setUp: () => withSyncState(const ExternalContactsSyncInitial()),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>()
          .having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress)
          .having((s) => s.contacts, 'contacts', isEmpty),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'sync RefreshInProgress with an empty cache maps to inProgress (loading)',
    setUp: () => withSyncState(const ExternalContactsSyncRefreshInProgress()),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'sync Success with an empty cache maps to success (empty state, not loading)',
    setUp: () => withSyncState(const ExternalContactsSyncSuccess()),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'sync Failure maps to failure',
    setUp: () => withSyncState(const ExternalContactsSyncRefreshFailure()),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
    ],
  );
}
