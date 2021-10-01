import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/repositories/local_contacts/local_contacts_repository.dart';

part 'local_contacts_event.dart';

part 'local_contacts_state.dart';

class LocalContactsBloc extends Bloc<LocalContactsEvent, LocalContactsState> {
  final LocalContactsRepository localContactsRepository;
  StreamSubscription? _localContactsSubscription;

  LocalContactsBloc({
    required this.localContactsRepository,
  }) : super(LocalContactsInitial());

  @override
  Stream<LocalContactsState> mapEventToState(LocalContactsEvent event) async* {
    if (event is LocalContactsInitialLoaded) {
      yield* _mapLocalContactsInitialLoadedToState(event);
    } else if (event is LocalContactsRefreshed) {
      yield* _mapLocalContactsRefreshedToState(event);
    } else if (event is LocalContactsUpdated) {
      yield* _mapLocalContactsUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _localContactsSubscription?.cancel();
    return super.close();
  }

  Stream<LocalContactsState> _mapLocalContactsInitialLoadedToState(LocalContactsInitialLoaded event) async* {
    yield LocalContactsInitial();
    _localContactsSubscription?.cancel();
    _localContactsSubscription = localContactsRepository.contacts().listen(
          (contacts) => add(LocalContactsUpdated(contacts: contacts)),
        );

    try {
      await localContactsRepository.load();
    } catch (error) {
      yield LocalContactsInitialLoadFailure();
    }
  }

  Stream<LocalContactsState> _mapLocalContactsRefreshedToState(LocalContactsRefreshed event) async* {
    try {
      await localContactsRepository.load();
    } catch (error) {
      yield LocalContactsRefreshFailure();
    }
  }

  Stream<LocalContactsState> _mapLocalContactsUpdatedToState(LocalContactsUpdated event) async* {
    yield LocalContactsLoadSuccess(contacts: event.contacts);
  }
}
