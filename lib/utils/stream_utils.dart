import 'dart:async';

class StreamUtils {
  /// Obtains the latest values from two streams and emits a new value whenever any of them emits.
  ///
  /// Unlike the strict Rx `combineLatest`, this implementation does not wait for
  /// both streams to emit at least once. It passes `null` for values that haven't appeared yet.
  static Stream<R> combineLatest2<A, B, R>(Stream<A> streamA, Stream<B> streamB, R Function(A? a, B? b) combiner) {
    final controller = StreamController<R>();
    A? latestA;
    B? latestB;

    void emit() {
      if (controller.isClosed) return;
      try {
        controller.add(combiner(latestA, latestB));
      } catch (e, s) {
        controller.addError(e, s);
      }
    }

    StreamSubscription<A>? subA;
    StreamSubscription<B>? subB;

    controller.onListen = () {
      subA = streamA.listen((data) {
        latestA = data;
        emit();
      }, onError: controller.addError);

      subB = streamB.listen((data) {
        latestB = data;
        emit();
      }, onError: controller.addError);
    };

    controller.onCancel = () {
      subA?.cancel();
      subB?.cancel();
    };

    return controller.stream;
  }
}
