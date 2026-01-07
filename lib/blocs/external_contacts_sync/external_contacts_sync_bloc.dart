import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'external_contacts_sync_event.dart';

part 'external_contacts_sync_state.dart';

final _logger = Logger('ExternalContactsSyncBloc');

class ExternalContactsSyncBloc extends Bloc<ExternalContactsSyncEvent, ExternalContactsSyncState> {
  ExternalContactsSyncBloc({
    required this.userRepository,
    required this.externalContactsRepository,
    required this.contactsRepository,
  }) : super(const ExternalContactsSyncInitial()) {
    on<ExternalContactsSyncStarted>(_onStarted, transformer: restartable());
    on<ExternalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_ExternalContactsSyncUpdated>(_onUpdated, transformer: droppable());
  }

  final UserRepository userRepository;
  final ExternalContactsRepository externalContactsRepository;
  final ContactsRepository contactsRepository;

  void _onStarted(ExternalContactsSyncStarted event, Emitter<ExternalContactsSyncState> emit) async {
    _logger.finer('_onStarted');

    final externalContactsForEachFuture = emit.onEach<List<ExternalContact>>(
      externalContactsRepository.contacts(),
      onData: (contacts) => add(_ExternalContactsSyncUpdated(contacts: contacts)),
      onError: (e, stackTrace) => _logger.warning('_onStarted', e, stackTrace),
    );

    add(const ExternalContactsSyncRefreshed());

    await externalContactsForEachFuture;
  }

  void _onRefreshed(ExternalContactsSyncRefreshed event, Emitter<ExternalContactsSyncState> emit) async {
    _logger.finer('_onRefreshed');

    emit(const ExternalContactsSyncRefreshInProgress());
    try {
      await externalContactsRepository.load();
    } catch (error) {
      _logger.warning('_onRefreshed error: ', error);
      emit(const ExternalContactsSyncRefreshFailure());
    }
  }

  Future _onUpdated(
    _ExternalContactsSyncUpdated event,
    Emitter<ExternalContactsSyncState> emit, {
    int retryCount = 0,
    UserInfo? userInfo,
  }) async {
    _logger.finer('_onUpdated contacts count:${event.contacts.length}');

    // Retrieve `UserInfo` separately because filtering requires the user's primary number.
    // If obtaining `UserInfo` fails, treat it as a refresh failure and abort processing.
    // Do not perform automatic retries for failures at this stage.
    try {
      userInfo ??= await userRepository.getInfo();
    } catch (error) {
      _logger.warning('_onUpdated userInfo error: ', error);
      emit(const ExternalContactsSyncRefreshFailure());
      return;
    }

    // Synchronize external contacts into the local contacts store.
    // On transient database errors, retry the transaction up to 3 attempts with a short backoff.
    try {
      // TODO: Clarify this filtering logic. Comparing `externalContact.id` with `userInfo.numbers.main` implies a type mismatch (ID vs Number).
      // This might be related to the legacy change: "fix(api): remove overabundant SIP information from user information response" (2023-08-08).
      final filteredContacts = event.contacts
          .where((externalContact) => externalContact.id != userInfo!.numbers.main)
          .toList();

      await contactsRepository.syncExternalContacts(filteredContacts);

      emit(const ExternalContactsSyncSuccess());
    } on Exception catch (e) {
      _logger.warning('_onUpdated retry: $retryCount, error: ', e);

      if (retryCount < 3) {
        await Future<void>.delayed(const Duration(seconds: 1));
        if (isClosed) return;
        // Provide the retrieved `userInfo` to the recursive retry
        // to avoid redundant fetches and preserve the valid user context.
        await _onUpdated(event, emit, retryCount: retryCount + 1, userInfo: userInfo);
      } else {
        emit(const ExternalContactsSyncUpdateFailure());
      }
    }
  }
}
