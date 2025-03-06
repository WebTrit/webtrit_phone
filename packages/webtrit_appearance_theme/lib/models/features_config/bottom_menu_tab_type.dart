enum BottomMenuTabType {
  favorites,
  recents,
  contacts,
  keypad,
  messaging,
  embedded1,
  embedded2,
  embedded3;

  bool get isEmbedded =>
      this == BottomMenuTabType.embedded1 || this == BottomMenuTabType.embedded2 || this == BottomMenuTabType.embedded3;
}
