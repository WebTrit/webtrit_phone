extension IterableStringReadableJoinExtension<T extends String?> on Iterable<T> {
  String readableJoin([String separator = ' ']) => where((element) => element != null).join(separator).trim();
}

extension GenericIterableExtension<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
