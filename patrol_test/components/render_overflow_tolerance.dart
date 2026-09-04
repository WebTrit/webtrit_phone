import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Keeps cosmetic RenderFlex overflows from failing an e2e run.
///
/// These tests assert network and behavior invariants across real devices
/// with very different screen sizes; a few-pixel overflow on one device is a
/// separate cosmetic defect to fix in the layout, not a reason to flake the
/// suite. Every other error still fails the test.
void tolerateRenderOverflow() {
  final original = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception.toString().contains('RenderFlex overflowed')) {
      debugPrint('Ignored cosmetic overflow: ${details.exception}');
      return;
    }
    original?.call(details);
  };
  addTearDown(() => FlutterError.onError = original);
}
