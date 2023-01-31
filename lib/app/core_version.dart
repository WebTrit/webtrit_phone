import 'package:pub_semver/pub_semver.dart';

class CoreVersion {
  static final supportedConstraint = VersionConstraint.parse('>=0.5.0-alpha <0.6.0');

  const CoreVersion(this.constraint);

  CoreVersion.supported() : this(supportedConstraint);

  final VersionConstraint constraint;

  void verify(Version actualVersion) {
    if (constraint.allows(actualVersion)) {
      return;
    } else {
      throw CoreVersionUnsupportedException(
        actualVersion,
        constraint,
      );
    }
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CoreVersion && runtimeType == other.runtimeType && constraint == other.constraint;
  }

  @override
  int get hashCode {
    return runtimeType.hashCode ^ constraint.hashCode;
  }

  @override
  String toString() {
    return constraint.toString();
  }
}

class CoreVersionUnsupportedException implements Exception {
  const CoreVersionUnsupportedException(
    this.actual,
    this.supportedConstraint,
  );

  final Version actual;
  final VersionConstraint supportedConstraint;
}
