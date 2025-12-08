import 'dart:async';

extension StreamSideEffects<T> on Stream<T> {
  Stream<T> doOnData(void Function(T event) onData) {
    return map((event) {
      onData(event);
      return event;
    });
  }
}
