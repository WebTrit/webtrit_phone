extension IterableStringReadableJoinExtension<T extends String?> on Iterable<T> {
  String readableJoin([String separator = ' ']) => where((element) => element != null).join(separator).trim();
}
