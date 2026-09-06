import 'package:equatable/equatable.dart';

import 'contact_source_type.dart';

/// What the contacts list of the unified arrangement is drawn from: one
/// address book, or the favourites a person has kept.
///
/// A type of its own rather than one more value on [ContactSourceType],
/// because that enum is stored against every contact row in the database and
/// is what a sync writes. Favourites are not a place a row comes from - they
/// are the list the favourites section keeps, spanning every address book - so
/// an enum value for them would have to be excluded by hand everywhere a
/// source type is persisted.
sealed class ContactsListSelection extends Equatable {
  const ContactsListSelection();

  @override
  bool get stringify => true;
}

/// One address book.
final class ContactsSourceSelection extends ContactsListSelection {
  const ContactsSourceSelection(this.sourceType);

  final ContactSourceType sourceType;

  @override
  List<Object?> get props => [sourceType];
}

/// The favourites section's own list.
final class ContactsFavoritesSelection extends ContactsListSelection {
  const ContactsFavoritesSelection();

  @override
  List<Object?> get props => const [];
}
