import 'package:equatable/equatable.dart';
import 'package:pub_semver/pub_semver.dart';

import 'components/adapter_info.dart';
import 'components/core_info.dart';
import 'components/gorush_info.dart';
import 'components/janus_info.dart';
import 'components/postgres_info.dart';

export 'components/core_info.dart';
export 'components/gorush_info.dart';
export 'components/janus_info.dart';
export 'components/postgres_info.dart';
export 'components/adapter_info.dart';
export 'components/plugins.dart';
export 'components/transports.dart';
export 'components/websocket.dart';
export 'components/sip_version.dart';

class WebtritSystemInfo with EquatableMixin {
  WebtritSystemInfo({
    required this.core,
    required this.postgres,
    this.adapter,
    this.janus,
    this.gorush,
    this.minSupportedAppVersion,
  });

  final CoreInfo core;
  final PostgresInfo postgres;
  final AdapterInfo? adapter;
  final JanusInfo? janus;
  final GorushInfo? gorush;

  /// Minimum app version the backend declares it supports. `null` = the
  /// backend does not enforce a minimum.
  final Version? minSupportedAppVersion;

  /// Whether [appVersion] satisfies the backend-declared minimum supported app
  /// version. This is the inverse of the core-compatibility check: here the
  /// backend declares how new the app must be.
  ///
  /// Returns `true` (supported) when:
  /// - the backend does not declare a minimum ([minSupportedAppVersion] null);
  /// - the app reports `0.0.0` (debug/sideload builds whose version never
  ///   carries the real number) -- never block these;
  /// - the app version is greater than or equal to the declared minimum.
  bool isAppVersionSupported(Version appVersion) {
    final minVersion = minSupportedAppVersion;
    if (minVersion == null) return true;
    if (appVersion == Version.none) return true;
    return appVersion >= minVersion;
  }

  @override
  List<Object?> get props => [core, postgres, adapter, janus, gorush, minSupportedAppVersion];

  @override
  bool get stringify => true;
}
