import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin SystemInfoApiMapper {
  WebtritSystemInfo systemInfoFromApi(api.SystemInfo systemInfo) {
    return WebtritSystemInfo(
      core: coreInfoFromApi(systemInfo.core),
      postgres: postgresInfoFromApi(systemInfo.postgres),
      adapter: systemInfo.adapter != null ? adapterInfoFromApi(systemInfo.adapter!) : null,
      janus: systemInfo.janus != null ? janusInfoFromApi(systemInfo.janus!) : null,
      gorush: systemInfo.gorush != null ? gorushInfoFromApi(systemInfo.gorush!) : null,
      minSupportedAppVersion: _tryParseVersion(systemInfo.minSupportedAppVersion),
    );
  }

  /// Parses a backend-provided semver string into a [Version], tolerating null
  /// or malformed input by returning null (treated as "no minimum enforced").
  Version? _tryParseVersion(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return Version.parse(raw);
    } on FormatException {
      return null;
    }
  }

  CoreInfo coreInfoFromApi(api.CoreInfo coreInfo) {
    return CoreInfo(version: coreInfo.version);
  }

  AdapterInfo adapterInfoFromApi(api.AdapterInfo adapterInfo) {
    return AdapterInfo(
      name: adapterInfo.name,
      version: adapterInfo.version,
      supported: adapterInfo.supported,
      custom: adapterInfo.custom,
    );
  }

  PostgresInfo postgresInfoFromApi(api.PostgresInfo postgresInfo) {
    return PostgresInfo(version: postgresInfo.version);
  }

  JanusInfo janusInfoFromApi(api.JanusInfo janusInfo) {
    return JanusInfo(
      plugins: janusInfo.plugins != null ? pluginsFromApi(janusInfo.plugins!) : null,
      transports: janusInfo.transports != null ? transportsFromApi(janusInfo.transports!) : null,
      version: janusInfo.version,
    );
  }

  Plugins pluginsFromApi(api.Plugins plugins) {
    return Plugins(sip: plugins.sip != null ? sipFromApi(plugins.sip!) : null);
  }

  SipVersion sipFromApi(api.SipVersion sip) {
    return SipVersion(version: sip.version);
  }

  Transports transportsFromApi(api.Transports transports) {
    return Transports(websocket: transports.websocket != null ? websocketFromApi(transports.websocket!) : null);
  }

  Websocket websocketFromApi(api.Websocket websocket) {
    return Websocket(version: websocket.version);
  }

  GorushInfo gorushInfoFromApi(api.GorushInfo gorushInfo) {
    return GorushInfo(version: gorushInfo.version);
  }
}
