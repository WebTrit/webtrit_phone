enum BottomMenuTabType {
  favorites,
  recents,
  contacts,
  keypad,
  messaging,
  embedded;

  bool get isEmbedded => this == BottomMenuTabType.embedded;
}
