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

  bool get supportsHybridPresence {
    // Hybrid presence was was introduced in 0.28.0-alpha.1
    // Dont mess with older implementations, just drop them due to incompatibility.
    return verifyVersionStr('>=0.28.0-alpha.1 <2.0.0');
  }

  bool get directPresenceConfigurable {
    // Starting from 0.36.0-alpha.1 direct presence became configurable
    // but previously from 0.28.0-alpha.1 till 0.36.0-alpha.1 direct presence was always on
    return verifyVersionStr('>=0.36.0-alpha.1 <2.0.0');
  }

  bool get supportsSessionTracking {
    // Listing and revoking the account's sessions was added in 0.35.0
    return verifyVersionStr('>=0.35.0-alpha <2.0.0');
  }

  bool get supportsPeerMessage {
    // peer_message app-to-app side channel was added in 0.33.0
    return verifyVersionStr('>=0.33.0-alpha <2.0.0');
  }
}
