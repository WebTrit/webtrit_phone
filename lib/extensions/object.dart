extension CastExtension on Object {
  T? castTo<T>() {
    if (this is T) {
      return this as T;
    } else {
      return null;
    }
  }
}
