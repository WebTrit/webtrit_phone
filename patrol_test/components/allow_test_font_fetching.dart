import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Keeps the bench from failing on fonts.
///
/// The dev checkout bundles no white-label font assets, and bootstrap locks
/// runtime fetching off for production. Turning fetching on lets a bench
/// with outbound access pull the faces; on a bench without it (a device
/// whose only network was just taken down for an offline-path test) the
/// fetch fails, and that failure is swallowed the same way a cosmetic
/// overflow is - a missing font must not fail a network/behavior test. Both
/// are restored on teardown so one test's choice does not leak to the next.
void allowTestFontFetching() {
  final override = _TestFontFetchingOverride()..enable();
  addTearDown(override.restore);
}

class _TestFontFetchingOverride {
  late final bool _originalFetching;
  late final FlutterExceptionHandler? _originalOnError;

  void enable() {
    _originalFetching = GoogleFonts.config.allowRuntimeFetching;
    _originalOnError = FlutterError.onError;
    GoogleFonts.config.allowRuntimeFetching = true;
    FlutterError.onError = _handleError;
  }

  void restore() {
    GoogleFonts.config.allowRuntimeFetching = _originalFetching;
    FlutterError.onError = _originalOnError;
  }

  void _handleError(FlutterErrorDetails details) {
    if (details.exception.toString().contains('Failed to load font')) {
      debugPrint(
        'Ignored font fetch failure on the bench: ${details.exception}',
      );
      return;
    }

    _originalOnError?.call(details);
  }
}
