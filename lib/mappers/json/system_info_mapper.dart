import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_phone/models/models.dart';

WebtritSystemInfo systemInfoFromJson(String json) {
  return systemInfoFromMap(jsonDecode(json));
}

String systemInfoToJson(WebtritSystemInfo data) {
  return jsonEncode(systemInfoToMap(data));
}

WebtritSystemInfo systemInfoFromMap(Map<String, dynamic> map) {
  return WebtritSystemInfo(
    core: coreInfoFromMap(map['core']),
    postgres: postgresInfoFromMap(map['postgres']),
    adapter: map['adapter'] != null ? adapterInfoFromMap(map['adapter']) : null,
    janus: map['janus'] != null ? janusInfoFromMap(map['janus']) : null,
    gorush: map['gorush'] != null ? gorushInfoFromMap(map['gorush']) : null,
  );
}

Map<String, dynamic> systemInfoToMap(WebtritSystemInfo systemInfo) {
  return {
    'core': coreInfoToMap(systemInfo.core),
    'postgres': postgresInfoToMap(systemInfo.postgres),
    'adapter': systemInfo.adapter != null ? adapterInfoToMap(systemInfo.adapter!) : null,
    'janus': systemInfo.janus != null ? janusInfoToMap(systemInfo.janus!) : null,
    'gorush': systemInfo.gorush != null ? gorushInfoToMap(systemInfo.gorush!) : null,
  };
}

CoreInfo coreInfoFromMap(Map<String, dynamic> map) {
  return CoreInfo(version: Version.parse(map['version']));
}

Map<String, dynamic> coreInfoToMap(CoreInfo coreInfo) {
  return {'version': coreInfo.version.toString()};
}

PostgresInfo postgresInfoFromMap(Map<String, dynamic> map) {
  return PostgresInfo(version: map['version']);
}

Map<String, dynamic> postgresInfoToMap(PostgresInfo postgresInfo) {
  return {'version': postgresInfo.version};
}

JanusInfo janusInfoFromMap(Map<String, dynamic> map) {
  return JanusInfo(
    plugins: map['plugins'] != null ? pluginsFromMap(map['plugins']) : null,
    transports: map['transports'] != null ? transportsFromMap(map['transports']) : null,
    version: map['version'],
  );
}

Map<String, dynamic> janusInfoToMap(JanusInfo janusInfo) {
  return {
    'plugins': janusInfo.plugins != null ? pluginsToMap(janusInfo.plugins!) : null,
    'transports': janusInfo.transports != null ? transportsToMap(janusInfo.transports!) : null,
    'version': janusInfo.version,
  };
}

Plugins pluginsFromMap(Map<String, dynamic> map) {
  return Plugins(sip: map['sip'] != null ? sipFromMap(map['sip']) : null);
}

Map<String, dynamic> pluginsToMap(Plugins plugins) {
  return {'sip': plugins.sip != null ? sipToMap(plugins.sip!) : null};
}

SipVersion sipFromMap(Map<String, dynamic> map) {
  return SipVersion(version: map['version']);
}

Map<String, dynamic> sipToMap(SipVersion sip) {
  return {'version': sip.version};
}

Transports transportsFromMap(Map<String, dynamic> map) {
  return Transports(websocket: map['websocket'] != null ? websocketFromMap(map['websocket']) : null);
}

Map<String, dynamic> transportsToMap(Transports transports) {
  return {'websocket': transports.websocket != null ? websocketToMap(transports.websocket!) : null};
}

Websocket websocketFromMap(Map<String, dynamic> map) {
  return Websocket(version: map['version']);
}

Map<String, dynamic> websocketToMap(Websocket websocket) {
  return {'version': websocket.version};
}

GorushInfo gorushInfoFromMap(Map<String, dynamic> map) {
  return GorushInfo(version: map['version']);
}

Map<String, dynamic> gorushInfoToMap(GorushInfo gorushInfo) {
  return {'version': gorushInfo.version};
}

AdapterInfo adapterInfoFromMap(Map<String, dynamic> map) {
  return AdapterInfo(
    name: map['name'],
    version: map['version'],
    supported: map['supported'] != null ? List<String>.from(map['supported']) : null,
    custom: map['custom'],
  );
}

Map<String, dynamic> adapterInfoToMap(AdapterInfo adapterInfo) {
  return {
    'name': adapterInfo.name,
    'version': adapterInfo.version,
    'supported': adapterInfo.supported,
    'custom': adapterInfo.custom,
  };
}
