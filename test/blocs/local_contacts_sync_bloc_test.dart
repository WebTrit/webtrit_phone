import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/blocs/local_contacts_sync/local_contacts_sync_bloc.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MockLocalContactsRepository extends Mock implements LocalContactsRepository {}

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockContactsAgreementStatusRepository extends Mock implements ContactsAgreementStatusRepository {}

final _localContact1 = LocalContact(id: '1', firstName: 'Local', lastName: 'User', phones: const [], emails: const []);

void main() {
  late MockLocalContactsRepository localContactsRepository;
  late MockContactsRepository contactsRepository;
  late MockContactsAgreementStatusRepository contactsAgreementStatusRepository;

  late bool featureEnabled;
  late bool agreementAccepted;
  late bool contactsPermissionGranted;
  late bool requestPermissionResult;

  setUp(() {
    localContactsRepository = MockLocalContactsRepository();
    contactsRepository = MockContactsRepository();
    contactsAgreementStatusRepository = MockContactsAgreementStatusRepository();

    when(() => localContactsRepository.load()).thenAnswer((_) async {});
    when(() => contactsRepository.syncLocalContacts(any())).thenAnswer((_) async {});

    featureEnabled = true;
    agreementAccepted = true;
    contactsPermissionGranted = true;
    requestPermissionResult = true;
  });

  LocalContactsSyncBloc buildBloc() {
    return LocalContactsSyncBloc(
      localContactsRepository: localContactsRepository,
      contactsRepository: contactsRepository,
      contactsAgreementStatusRepository: contactsAgreementStatusRepository,
      isFeatureEnabled: () async => featureEnabled,
      isAgreementAccepted: () async => agreementAccepted,
      isContactsPermissionGranted: () async => contactsPermissionGranted,
      requestContactPermission: () async => requestPermissionResult,
    );
  }

  void setupDelayedStreamEmission(StreamController<List<LocalContact>> controller, List<LocalContact> contacts) {
    Future.delayed(Duration.zero, () {
      controller.add(contacts);
      controller.close();
    });
  }

  group('LocalContactsSyncBloc', () {
    test('initial state is LocalContactsSyncInitial', () {
      expect(buildBloc().state, const LocalContactsSyncInitial());
    });

    group('LocalContactsSyncStarted', () {
      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits ContactsFeatureDisabledException when feature is disabled',
        build: () {
          featureEnabled = false;
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        expect: () => [const ContactsFeatureDisabledException()],
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits ContactsAgreementMissingException when agreement is not accepted',
        build: () {
          agreementAccepted = false;
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        expect: () => [const ContactsAgreementMissingException()],
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits LocalContactsSyncPermissionFailure when permission request is denied',
        build: () {
          requestPermissionResult = false;
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        expect: () => [const LocalContactsSyncPermissionFailure()],
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'subscribes to contacts and triggers refresh when all checks pass',
        build: () {
          final controller = StreamController<List<LocalContact>>();
          when(() => localContactsRepository.contacts()).thenAnswer((_) => controller.stream);
          setupDelayedStreamEmission(controller, []);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        wait: const Duration(milliseconds: 50),
        expect: () => [const LocalContactsSyncRefreshInProgress(), const LocalContactsSyncSuccess()],
        verify: (_) {
          verify(() => localContactsRepository.contacts()).called(1);
          verify(() => localContactsRepository.load()).called(1);
        },
      );
    });

    group('LocalContactsSyncRefreshed', () {
      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits PermissionFailure if permission is not granted (without requesting)',
        build: () {
          contactsPermissionGranted = false;
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncRefreshed()),
        expect: () => [const LocalContactsSyncPermissionFailure()],
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits RefreshInProgress then nothing if load succeeds',
        build: () {
          when(() => localContactsRepository.contacts()).thenAnswer((_) => Stream.empty());
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncRefreshed()),
        expect: () => [const LocalContactsSyncRefreshInProgress()],
        verify: (_) => verify(() => localContactsRepository.load()).called(1),
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits RefreshFailure if repository load throws',
        build: () {
          when(() => localContactsRepository.contacts()).thenAnswer((_) => Stream.empty());
          when(() => localContactsRepository.load()).thenThrow(Exception('Load error'));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncRefreshed()),
        expect: () => [const LocalContactsSyncRefreshInProgress(), const LocalContactsSyncRefreshFailure()],
      );
    });

    group('Logic updates from Stream (_LocalContactsSyncUpdated)', () {
      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'emits Success when contacts repository syncs successfully',
        build: () {
          final controller = StreamController<List<LocalContact>>();
          when(() => localContactsRepository.contacts()).thenAnswer((_) => controller.stream);
          setupDelayedStreamEmission(controller, [_localContact1]);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        wait: const Duration(milliseconds: 100),
        expect: () => [const LocalContactsSyncRefreshInProgress(), const LocalContactsSyncSuccess()],
        verify: (_) => verify(() => contactsRepository.syncLocalContacts([_localContact1])).called(1),
      );

      blocTest<LocalContactsSyncBloc, LocalContactsSyncState>(
        'triggers syncLocalContacts and handles errors',
        build: () {
          final controller = StreamController<List<LocalContact>>();
          when(() => localContactsRepository.contacts()).thenAnswer((_) => controller.stream);
          when(() => contactsRepository.syncLocalContacts(any())).thenThrow(Exception('Sync error'));
          setupDelayedStreamEmission(controller, [_localContact1]);
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LocalContactsSyncStarted()),
        wait: const Duration(milliseconds: 100),
        verify: (_) => verify(() => contactsRepository.syncLocalContacts(any())).called(1),
      );
    });
  });
}
