import 'package:equatable/equatable.dart';

import 'contact_source_type.dart';

/// What the contacts list of the unified arrangement is drawn from: one
/// address book, or the favourites gathered from all of them.
///
/// A type of its own rather than one more value on [ContactSourceType],
/// because that enum is stored against every contact row in the database and
/// is what a sync writes. Favourites are a view over those rows - people can
/// be favourites in either address book - so a row can never come from
/// "favourites", and an enum value that no row can carry would have to be
/// excluded by hand at every place that persists one.
sealed class ContactsListSelection extends Equatable {
  const ContactsListSelection();

  /// The address book behind this selection, or null where the selection is
  /// not one address book.
  ContactSourceType? get sourceType;

  @override
  bool get stringify => true;
}

/// One address book, drawn exactly as the tabbed arrangement draws it.
final class ContactsSourceSelection extends ContactsListSelection {
  const ContactsSourceSelection(this.sourceType);

  @override
  final ContactSourceType sourceType;

  @override
  List<Object?> get props => [sourceType];
}

/// The favourites of every configured address book, in one list.
final class ContactsFavoritesSelection extends ContactsListSelection {
  const ContactsFavoritesSelection();

  @override
  ContactSourceType? get sourceType => null;

  @override
  List<Object?> get props => const [];
}
