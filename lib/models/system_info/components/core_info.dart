import 'package:equatable/equatable.dart';
import 'package:pub_semver/pub_semver.dart';

class CoreInfo with EquatableMixin {
  CoreInfo({required this.version, this.iceServersConfigured = false});

  final Version version;

  /// Whether the deployment bundles its own STUN/TURN servers, which the app
  /// then loads from the core instead of falling back to a public STUN server.
  final bool iceServersConfigured;

  @override
  List<Object?> get props => [version, iceServersConfigured];

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
    // Hybrid presence was was added in 0.28.0-alpha.1
    return verifyVersionStr('>=0.28.0-alpha.1 <2.0.0');
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
