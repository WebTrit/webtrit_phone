import 'package:pub_semver/pub_semver.dart';

class CoreVersion {
  static final supportedConstraint = VersionConstraint.parse('>=0.4.0 <0.5.0');

  const CoreVersion(this.constraint);

  CoreVersion.supported() : this(supportedConstraint);

  final VersionConstraint constraint;

  void verify(Version actualVersion) {
    if (constraint.allows(actualVersion)) {
      return;
    } else {
      throw IncompatibleCoreVersionException(
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

class IncompatibleCoreVersionException implements Exception {
  const IncompatibleCoreVersionException(
    this.actual,
    this.supportedConstraint,
  );

  final Version actual;
  final VersionConstraint supportedConstraint;
}
