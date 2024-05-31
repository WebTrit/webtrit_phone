extension CastExtension on Object {
  T? castToOrNull<T>() {
    if (this is T) {
      return this as T;
    } else {
      return null;
    }
  }
}
