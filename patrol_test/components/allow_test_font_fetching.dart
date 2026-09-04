import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Lets a bench run fetch fonts over the network.
///
/// The dev checkout bundles no white-label font assets, and bootstrap locks
/// runtime fetching off for production builds; on the bench the network
/// fetch is the intended substitute. Restored on teardown so one test's
/// choice does not leak into the next in the bundle.
void allowTestFontFetching() {
  final original = GoogleFonts.config.allowRuntimeFetching;
  GoogleFonts.config.allowRuntimeFetching = true;
  addTearDown(() => GoogleFonts.config.allowRuntimeFetching = original);
}
