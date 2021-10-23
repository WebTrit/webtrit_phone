import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/repositories/external_contacts/external_contacts_repository.dart';

part 'external_contacts_event.dart';

part 'external_contacts_state.dart';

class ExternalContactsBloc extends Bloc<ExternalContactsEvent, ExternalContactsState> {
  final ExternalContactsRepository externalContactsRepository;
  StreamSubscription? _externalContactsSubscription;

  ExternalContactsBloc({
    required this.externalContactsRepository,
  }) : super(const ExternalContactsInitial());

  @override
  Stream<ExternalContactsState> mapEventToState(ExternalContactsEvent event) async* {
    if (event is ExternalContactsInitialLoaded) {
      yield* _mapExternalContactsInitialLoadedToState(event);
    } else if (event is ExternalContactsRefreshed) {
      yield* _mapExternalContactsRefreshedToState(event);
    } else if (event is ExternalContactsUpdated) {
      yield* _mapExternalContactsUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _externalContactsSubscription?.cancel();
    return super.close();
  }

  Stream<ExternalContactsState> _mapExternalContactsInitialLoadedToState(ExternalContactsInitialLoaded event) async* {
    yield const ExternalContactsInitial();
    _externalContactsSubscription?.cancel();
    _externalContactsSubscription = externalContactsRepository.contacts().listen(
          (contacts) => add(ExternalContactsUpdated(contacts: contacts)),
        );

    try {
      await externalContactsRepository.load();
    } catch (error) {
      yield const ExternalContactsInitialLoadFailure();
    }
  }

  Stream<ExternalContactsState> _mapExternalContactsRefreshedToState(ExternalContactsRefreshed event) async* {
    try {
      await externalContactsRepository.load();
    } catch (error) {
      yield const ExternalContactsRefreshFailure();
    }
  }

  Stream<ExternalContactsState> _mapExternalContactsUpdatedToState(ExternalContactsUpdated event) async* {
    yield ExternalContactsLoadSuccess(contacts: event.contacts);
  }
}
