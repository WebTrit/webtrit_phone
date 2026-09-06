import 'package:flutter/foundation.dart';

/// Runs [action] while tolerating only small `RenderFlex` overflows.
///
/// The caller must scope this to the known screen phase. The original handler
/// is restored as soon as [action] completes, and every other Flutter error is
/// forwarded unchanged.
Future<T> tolerateSmallRenderOverflows<T>(Future<T> Function() action, {double maxOverflowPixels = 8}) {
  return _RenderOverflowTolerance(maxOverflowPixels).run(action);
}

class _RenderOverflowTolerance {
  _RenderOverflowTolerance(this.maxOverflowPixels);

  final double maxOverflowPixels;
  FlutterExceptionHandler? _original;

  Future<T> run<T>(Future<T> Function() action) async {
    _original = FlutterError.onError;
    FlutterError.onError = _handle;
    try {
      return await action();
    } finally {
      FlutterError.onError = _original;
    }
  }

  void _handle(FlutterErrorDetails details) {
    final overflow = _overflowPixels(details);
    if (overflow != null && overflow <= maxOverflowPixels) {
      debugPrint('Ignored $overflow px RenderFlex overflow in the scoped login phase');
      return;
    }

    _original?.call(details);
  }

  double? _overflowPixels(FlutterErrorDetails details) {
    final match = RegExp(r'A RenderFlex overflowed by ([0-9]+(?:\.[0-9]+)?) pixels')
        .firstMatch(details.exceptionAsString());
    return match == null ? null : double.tryParse(match.group(1)!);
  }
}
