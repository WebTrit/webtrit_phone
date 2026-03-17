import 'package:equatable/equatable.dart';
import 'package:pub_semver/pub_semver.dart';

class CoreInfo with EquatableMixin {
  CoreInfo({required this.version});

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

  bool get supportsRemoteCallerIdSettings {
    // Remote caller ID settings support was added in 0.23.0-alpha.2
    return verifyVersionStr('>=0.23.0-alpha.2 <2.0.0');
  }

  bool get supportsRemoteFavorites {
    // Remote favorites support was added in 0.25.0-alpha.2
    return verifyVersionStr('>=0.25.0-alpha.2 <2.0.0');
  }

  bool get hybridPresenceAware {
    // Hybrid presence was was added in 0.26.0-alpha.2
    return verifyVersionStr('>=0.26.0-alpha.2 <2.0.0');
  }
}
