import 'debounce.dart';

/// Debounces rapid transitions between transient states.
///
/// Immediate update when either the old or new value is non-transient.
/// Debounced update when both old and new are transient, so quick
/// oscillations within a transient zone don't flicker the UI.
///
/// Usage in a StatefulWidget:
/// ```dart
/// late final _debouncer = TransientDebouncer<MyStatus>(
///   initial: widget.status,
///   duration: kDebounce,
///   isTransient: (s) => s.isTransient,
///   getLatest: () => widget.status,
/// );
///
/// // In didUpdateWidget:
/// _debouncer.update(widget.status, (s) => setState(() {}));
///
/// // In dispose:
/// _debouncer.dispose();
/// ```
class TransientDebouncer<T> {
  TransientDebouncer({
    required T initial,
    required Duration duration,
    required bool Function(T) isTransient,
    required T Function() getLatest,
  }) : _displayed = initial,
       _isTransient = isTransient,
       _getLatest = getLatest,
       _debounce = Debounce(duration);

  T _displayed;
  T? _pending;

  final bool Function(T) _isTransient;
  final T Function() _getLatest;
  final Debounce _debounce;

  T get displayed => _displayed;

  /// Call whenever the value may have changed.
  /// [onUpdate] is called synchronously on immediate updates; the debounced
  /// callback also fires it after the quiet window expires.
  void update(T newValue, void Function() onUpdate) {
    if (_isTransient(newValue) && _isTransient(_displayed)) {
      if (newValue == _displayed || newValue == _pending) return;
      _pending = newValue;
      _debounce.schedule(() {
        _pending = null;
        _displayed = _getLatest();
        onUpdate();
      });
    } else {
      _pending = null;
      _debounce.cancel();
      _displayed = newValue;
      onUpdate();
    }
  }

  void dispose() => _debounce.dispose();
}
