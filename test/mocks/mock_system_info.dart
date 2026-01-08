import 'dart:convert';

class SystemInfoBuilder {
  final String coreVersion;
  final String adapterName;
  final String adapterVersion;
  final List<String> adapterSupported;
  final String postgresVersion;
  final String janusVersion;

  const SystemInfoBuilder({
    this.coreVersion = '0.15.3',
    this.adapterName = 'Demo DB which hosts multiple tenants',
    this.adapterVersion = '0.1.13',
    this.adapterSupported = const [
      'extensions',
      'userEvents',
      'internalMessaging',
      'signup',
      'autoProvision',
      'customMethods',
    ],
    this.postgresVersion = '15.0',
    this.janusVersion = '1.3.1',
  });

  SystemInfoBuilder copyWith({
    String? coreVersion,
    String? adapterName,
    String? adapterVersion,
    List<String>? adapterSupported,
    String? postgresVersion,
    String? janusVersion,
  }) {
    return SystemInfoBuilder(
      coreVersion: coreVersion ?? this.coreVersion,
      adapterName: adapterName ?? this.adapterName,
      adapterVersion: adapterVersion ?? this.adapterVersion,
      adapterSupported: adapterSupported ?? this.adapterSupported,
      postgresVersion: postgresVersion ?? this.postgresVersion,
      janusVersion: janusVersion ?? this.janusVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'core': {'version': coreVersion},
      'adapter': {'custom': {}, 'name': adapterName, 'supported': adapterSupported, 'version': adapterVersion},
      'postgres': {'version': postgresVersion},
      'janus': {
        'version': janusVersion,
        'plugins': {
          'sip': {'version': '0.0.9'},
        },
        'transports': {
          'websocket': {'version': '0.0.1'},
        },
      },
    };
  }

  String build() => jsonEncode(toMap());
}
