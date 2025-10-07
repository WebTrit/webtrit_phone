enum BottomMenuTabType {
  favorites,
  recents,
  recentCdrs,
  contacts,
  keypad,
  messaging,
  embedded;

  bool get isEmbedded => this == BottomMenuTabType.embedded;
}
