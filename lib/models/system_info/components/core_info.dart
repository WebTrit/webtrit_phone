import 'package:equatable/equatable.dart';
import 'package:pub_semver/pub_semver.dart';

class CoreInfo with EquatableMixin {
  CoreInfo({
    required this.version,
  });

  final Version version;

  @override
  List<Object?> get props => [version];

  @override
  bool get stringify => true;

  /// Returns true if the actual version is allowed by the constraint.
  bool verifyVersion(VersionConstraint constraint) {
    return constraint.allows(version);
  }

  /// Returns true if the actual version is allowed by the constraint.
  /// Using a string representation of the constraint. e.g. '>=0.7.0-alpha <2.0.0'.
  bool verifyVersionStr(String constraintString) {
    return verifyVersion(VersionConstraint.parse(constraintString));
  }
}
