import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/equatable_prop_to_string.dart';

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

    try {
      userInfo ??= await userRepository.getInfo();

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
        await _onUpdated(event, emit, retryCount: retryCount + 1, userInfo: userInfo);
      } else {
        emit(const ExternalContactsSyncUpdateFailure());
      }
    }
  }
}
