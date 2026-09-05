import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockContactsBloc extends MockBloc<ContactsEvent, ContactsState> implements ContactsBloc {}

class MockPollingTaskHandle extends Mock implements PollingTaskHandle {}

void main() {
  late MockContactsRepository contactsRepository;
  late MockContactsBloc searchBloc;
  late MockPollingTaskHandle syncTask;

  setUp(() {
    contactsRepository = MockContactsRepository();
    searchBloc = MockContactsBloc();
    syncTask = MockPollingTaskHandle();

    when(() => contactsRepository.watchContacts('', ContactSourceType.external))
        .thenAnswer((_) => Stream.value(const <Contact>[]));
    when(() => searchBloc.state).thenReturn(const ContactsState(sourceType: ContactSourceType.external));
    when(() => syncTask.states).thenAnswer((_) => const Stream.empty());
  });

  ContactsExternalTabBloc build() => ContactsExternalTabBloc(
    contactsRepository: contactsRepository,
    contactsSearchBloc: searchBloc,
    syncTask: syncTask,
  );

  void withSyncPhase(PollingTaskPhase phase) {
    when(() => syncTask.state).thenReturn(PollingTaskState(phase: phase));
  }

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'idle with an empty cache maps to inProgress until the leading cycle starts',
    setUp: () => withSyncPhase(PollingTaskPhase.idle),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>()
          .having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress)
          .having((s) => s.contacts, 'contacts', isEmpty),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'running with an empty cache maps to inProgress',
    setUp: () => withSyncPhase(PollingTaskPhase.running),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'succeeded with an empty cache maps to success (empty state, not loading)',
    setUp: () => withSyncPhase(PollingTaskPhase.succeeded),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'failed polling maps to failure',
    setUp: () => withSyncPhase(PollingTaskPhase.failed),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'stopped polling maps to failure',
    setUp: () => withSyncPhase(PollingTaskPhase.stopped),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
    ],
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'polling state transitions arrive through the stream',
    setUp: () {
      withSyncPhase(PollingTaskPhase.running);
      when(() => syncTask.states).thenAnswer(
        (_) => Stream.fromIterable(const [
          PollingTaskState(phase: PollingTaskPhase.running),
          PollingTaskState(phase: PollingTaskPhase.succeeded),
        ]),
      );
    },
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
  );
}
