import 'dart:async';

abstract final class StreamUtils {
  /// Obtains the latest values from two streams and emits a new value whenever any of them emits.
  ///
  /// This implementation creates a broadcast stream. It closes the controller when:
  /// 1. All listeners have unsubscribed.
  /// 2. Both source streams have completed.
  static Stream<R> combineLatest2<A, B, R>(Stream<A> streamA, Stream<B> streamB, R Function(A? a, B? b) combiner) {
    final controller = StreamController<R>.broadcast();
    A? latestA;
    B? latestB;

    bool doneA = false;
    bool doneB = false;

    void emit() {
      if (controller.isClosed) return;
      try {
        controller.add(combiner(latestA, latestB));
      } catch (e, s) {
        controller.addError(e, s);
      }
    }

    void tryClose() {
      if (doneA && doneB && !controller.isClosed) {
        controller.close();
      }
    }

    StreamSubscription<A>? subA;
    StreamSubscription<B>? subB;

    controller.onListen = () {
      subA = streamA.listen(
        (data) {
          latestA = data;
          emit();
        },
        onError: controller.addError,
        onDone: () {
          doneA = true;
          tryClose();
        },
      );

      subB = streamB.listen(
        (data) {
          latestB = data;
          emit();
        },
        onError: controller.addError,
        onDone: () {
          doneB = true;
          tryClose();
        },
      );
    };

    controller.onCancel = () {
      subA?.cancel();
      subB?.cancel();
      if (!controller.isClosed) {
        controller.close();
      }
    };

    return controller.stream;
  }
}
