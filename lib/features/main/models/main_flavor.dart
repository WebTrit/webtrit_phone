enum MainFlavor {
  favorites,
  recents,
  contacts,
  keypad;

  static MainFlavor get defaultValue => favorites;

  static const queryParameterName = 'flavor';
}
