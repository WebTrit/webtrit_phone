/// How the contacts section arranges what it shows.
///
/// The two are separate screens rather than one screen with a switch: they
/// differ in what the header offers and where favourites live, and a
/// deployment configured for one must not be able to reach the other by
/// accident.
enum ContactsLayout {
  /// Each address book is a tab of its own, and favourites are a section
  /// elsewhere in the bottom bar.
  tabbed,

  /// One list: the address book behind it is chosen in the header, and
  /// favourites narrow the same list rather than living apart from it.
  unified,
}
