import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/repositories/contacts_repository.dart';

import './contacts.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepository contactsRepository;
  StreamSubscription _contactsSubscription;

  @override
  ContactsState get initialState => ContactsInitial();

  ContactsBloc({
    @required this.contactsRepository,
  }) : assert(contactsRepository != null);

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is ContactsInitialLoaded) {
      yield* _mapContactsInitialLoadedToState(event);
    } else if (event is ContactsRefreshed) {
      yield* _mapContactsRefreshedToState(event);
    } else if (event is ContactsUpdated) {
      yield* _mapContactsUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _contactsSubscription?.cancel();
    return super.close();
  }

  Stream<ContactsState> _mapContactsInitialLoadedToState(ContactsInitialLoaded event) async* {
    yield ContactsInitial();
    _contactsSubscription?.cancel();
    _contactsSubscription = contactsRepository.contacts().listen(
          (contacts) => add(ContactsUpdated(contacts: contacts)),
        );

    try {
      await contactsRepository.load();
    } catch (error) {
      yield ContactsInitialLoadFailure();
    }
  }

  Stream<ContactsState> _mapContactsRefreshedToState(ContactsRefreshed event) async* {
    try {
      await contactsRepository.load();
    } catch (error) {
      yield ContactsRefreshFailure();
    }
  }

  Stream<ContactsState> _mapContactsUpdatedToState(ContactsUpdated event) async* {
    yield ContactsLoadSuccess(contacts: event.contacts);
  }
}
