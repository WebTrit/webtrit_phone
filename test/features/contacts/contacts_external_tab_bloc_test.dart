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

class MockPollingTaskStateSource extends Mock implements PollingTaskStateSource {}

class MockPollingTaskRunner extends Mock implements PollingTaskRunner {}

void main() {
  late MockContactsRepository contactsRepository;
  late MockContactsBloc searchBloc;
  late MockPollingTaskStateSource syncState;
  late MockPollingTaskRunner syncRunner;

  setUp(() {
    contactsRepository = MockContactsRepository();
    searchBloc = MockContactsBloc();
    syncState = MockPollingTaskStateSource();
    syncRunner = MockPollingTaskRunner();

    when(() => contactsRepository.watchContacts('', ContactSourceType.external))
        .thenAnswer((_) => Stream.value(const <Contact>[]));
    when(() => searchBloc.state).thenReturn(const ContactsState(sourceType: ContactSourceType.external));
    when(() => syncState.states).thenAnswer((_) => const Stream.empty());
    when(() => syncRunner.runNow()).thenAnswer((_) async {});
  });

  ContactsExternalTabBloc build() => ContactsExternalTabBloc(
    contactsRepository: contactsRepository,
    contactsSearchBloc: searchBloc,
    syncState: syncState,
    syncRunner: syncRunner,
  );

  void withSyncPhase(PollingTaskPhase phase) {
    when(() => syncState.state).thenReturn(PollingTaskState(phase: phase));
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
    'waiting for connectivity maps to failure',
    setUp: () => withSyncPhase(PollingTaskPhase.waitingForConnectivity),
    build: build,
    act: (bloc) => bloc.add(const ContactsExternalTabStarted(search: '')),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
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
      when(() => syncState.states).thenAnswer(
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

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'manual refresh runs through the polling registration',
    build: build,
    act: (bloc) async => expect(await bloc.refresh(), isTrue),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.success),
    ],
    verify: (_) => verify(() => syncRunner.runNow()).called(1),
  );

  blocTest<ContactsExternalTabBloc, ContactsExternalTabState>(
    'manual refresh failure is mapped without escaping the BLoC',
    setUp: () => when(() => syncRunner.runNow()).thenThrow(StateError('task was unregistered')),
    build: build,
    act: (bloc) async => expect(await bloc.refresh(), isFalse),
    expect: () => [
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.inProgress),
      isA<ContactsExternalTabState>().having((s) => s.status, 'status', ContactsExternalTabStatus.failure),
    ],
    verify: (_) => verify(() => syncRunner.runNow()).called(1),
  );
}
