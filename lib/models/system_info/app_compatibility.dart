import 'package:pub_semver/pub_semver.dart';

import 'system_info.dart';

/// Resolves the [AppCompatibility] of a running build against a backend's
/// system-info. Injected (see `RootApp` providers) so the version policy is a
/// single swappable seam shared by the login gate and the in-app force-update
/// gate, rather than a rule each consumer re-derives.
abstract interface class AppCompatibilityResolver {
  AppCompatibility resolve({
    required WebtritSystemInfo systemInfo,
    required Version appVersion,
    required String coreVersionConstraint,
  });
}

/// Default version policy.
///
/// An explicitly too-old app ([WebtritSystemInfo.minSupportedAppVersion]) takes
/// priority over a core mismatch: the backend-declared minimum is the more
/// authoritative, user-actionable signal. The non-null minimum is proven in the
/// branch itself, so no null-assertion is needed; `0.0.0` debug/sideload builds
/// are never blocked (see [WebtritSystemInfo.isAppVersionSupported]).
class DefaultAppCompatibilityResolver implements AppCompatibilityResolver {
  const DefaultAppCompatibilityResolver();

  @override
  AppCompatibility resolve({
    required WebtritSystemInfo systemInfo,
    required Version appVersion,
    required String coreVersionConstraint,
  }) {
    final minSupportedAppVersion = systemInfo.minSupportedAppVersion;
    if (minSupportedAppVersion != null && !systemInfo.isAppVersionSupported(appVersion)) {
      return AppVersionTooOld(appVersion: appVersion, minSupportedVersion: minSupportedAppVersion);
    }
    if (!systemInfo.core.verifyVersionStr(coreVersionConstraint)) {
      return CoreVersionUnsupported(
        coreVersion: systemInfo.core.version,
        constraint: VersionConstraint.parse(coreVersionConstraint),
      );
    }
    return const AppCompatible();
  }
}

/// Outcome of checking a running build against a backend's system-info: the
/// single source of truth for app/core version compatibility, mapped by each
/// consumer to its own surface (a login notification, a bloc state).
sealed class AppCompatibility {
  const AppCompatibility();
}

/// The running build satisfies both the core constraint and the declared minimum.
final class AppCompatible extends AppCompatibility {
  const AppCompatible();
}

/// The backend core version is outside the app's supported [constraint].
final class CoreVersionUnsupported extends AppCompatibility {
  const CoreVersionUnsupported({required this.coreVersion, required this.constraint});

  final Version coreVersion;
  final VersionConstraint constraint;
}

/// The running app is older than the backend-declared [minSupportedVersion].
final class AppVersionTooOld extends AppCompatibility {
  const AppVersionTooOld({required this.appVersion, required this.minSupportedVersion});

  final Version appVersion;
  final Version minSupportedVersion;
}
