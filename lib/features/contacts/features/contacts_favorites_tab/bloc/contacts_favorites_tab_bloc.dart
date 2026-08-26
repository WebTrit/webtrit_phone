import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../contacts.dart';

part 'contacts_favorites_tab_event.dart';

part 'contacts_favorites_tab_state.dart';

/// The favourites of every address book, in one list.
///
/// Unlike the tabs of a single address book, this one owns no sync: it reads
/// what those syncs have already written, across every source, and the people
/// it shows were put there one by one from a contact card. So it has no
/// refresh of its own and no failure of its own - a source that cannot be
/// reached simply contributes nothing, and the rest of the list still stands.
/// That also keeps it independent of `ExternalContactsSyncBloc`, which a
/// deployment without extensions never provides.
class ContactsFavoritesTabBloc extends Bloc<ContactsFavoritesTabEvent, ContactsFavoritesTabState> {
  ContactsFavoritesTabBloc({required this.contactsRepository, required this.contactsSearchBloc})
    : super(const ContactsFavoritesTabState()) {
    on<ContactsFavoritesTabStarted>(_onStarted, transformer: restartable());
  }

  final ContactsRepository contactsRepository;
  final ContactsBloc contactsSearchBloc;

  Future<void> _onStarted(ContactsFavoritesTabStarted event, Emitter<ContactsFavoritesTabState> emit) async {
    // No source type: the list spans every address book, which is what makes
    // it a list of its own rather than a narrowed view of one tab.
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search),
      onData: (List<Contact> contacts) => state.copyWith(
        status: ContactsFavoritesTabStatus.success,
        contacts: contacts.favoritesOnly,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchStateOnEachFuture = emit.onEach(
      contactsSearchBloc.stream,
      onData: (state) => add(ContactsFavoritesTabStarted(search: state.search)),
    );

    await Future.wait([watchContactsForEachFuture, contactsSearchStateOnEachFuture]);
  }
}
