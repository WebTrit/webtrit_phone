import 'dart:async';

/// A simple [StreamTransformer] that captures events from the source [Stream] and
/// hold events inside [StreamController] until the sink [Stream] being listened.
class BufferTransformer<T> extends StreamTransformerBase<T, T> {
  BufferTransformer();

  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    final StreamSubscription(:cancel, :pause, :resume) = stream.listen(
      controller.add,
      onError: controller.addError,
      onDone: controller.close,
    );

    controller.onCancel = cancel;
    controller.onPause = pause;
    controller.onResume = resume;

    return controller.stream;
  }
}
