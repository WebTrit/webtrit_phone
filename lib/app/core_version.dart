import 'package:version/version.dart';

class CoreVersion {
  static final expectedGreaterThanOrEqual = Version(0, 4, 0);
  static final expectedLessThan = Version(0, 5, 0);

  const CoreVersion(this.greaterThanOrEqual, this.lessThan);

  CoreVersion.expected() : this(expectedGreaterThanOrEqual, expectedLessThan);

  final Version greaterThanOrEqual; // Allows the given version or any greater one
  final Version lessThan; // Allows any version lower than the specified one but not that version itself

  void verifyCompatibility(Version actual) {
    if (actual >= greaterThanOrEqual && actual < lessThan) {
      return;
    } else {
      throw IncompatibleCoreVersionException(
        actual,
        greaterThanOrEqual,
        lessThan,
      );
    }
  }
}

class IncompatibleCoreVersionException implements Exception {
  const IncompatibleCoreVersionException(
    this.actual,
    this.expectedGreaterThanOrEqual,
    this.expectedLessThan,
  );

  final Version actual;
  final Version expectedGreaterThanOrEqual;
  final Version expectedLessThan;
}
