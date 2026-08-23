import 'package:equatable/equatable.dart';

/// How the contacts section arranges what it shows.
///
/// The arrangements are separate screens rather than one screen with a
/// switch: they differ in what the header offers and in where favourites
/// live, and a deployment configured for one must not be able to reach the
/// other by accident.
///
/// A type rather than a name with settings beside it, because the settings
/// belong to one arrangement each: stating favourites for the arrangement
/// that keeps them in a section of their own would be a value nothing reads,
/// and a reader would be right to wonder what it meant.
sealed class ContactsLayout extends Equatable {
  const ContactsLayout();

  /// Whether this arrangement offers favourites within the contacts section.
  bool get offersFavorites;

  @override
  bool get stringify => true;
}

/// Each address book is a tab of its own, and favourites are a section
/// elsewhere in the bottom bar - so this arrangement offers none of its own.
final class ContactsTabbedLayout extends ContactsLayout {
  const ContactsTabbedLayout();

  @override
  bool get offersFavorites => false;

  @override
  List<Object?> get props => const [];
}

/// One list: the address book behind it is chosen in the header, and
/// favourites narrow the same list rather than living apart from it.
final class ContactsUnifiedLayout extends ContactsLayout {
  const ContactsUnifiedLayout({this.favorites = true});

  /// Whether the list can be narrowed to favourites. A deployment that picks
  /// this arrangement is picking the one favourites live in, so they are on
  /// unless it says otherwise.
  final bool favorites;

  @override
  bool get offersFavorites => favorites;

  @override
  List<Object?> get props => [favorites];
}
