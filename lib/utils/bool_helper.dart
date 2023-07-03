class BoolHelper {
  static bool parseString(
    String value, {
    bool defaultValue = false,
  }) {
    if (value.trim().toLowerCase() == 'true') {
      return true;
    } else if (value.trim().toLowerCase() == 'false') {
      return false;
    }
    return defaultValue;
  }
}
