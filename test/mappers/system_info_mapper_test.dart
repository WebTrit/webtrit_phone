import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class _Mapper with SystemInfoApiMapper, SystemInfoJsonMapper {}

void main() {
  final mapper = _Mapper();

  api.SystemInfo apiInfo({String? minSupportedAppVersion, String? bundleVersion}) {
    return api.SystemInfo(
      core: api.CoreInfo(version: Version(1, 0, 0)),
      postgres: api.PostgresInfo(version: '15.0'),
      minSupportedAppVersion: minSupportedAppVersion,
      bundleVersion: bundleVersion,
    );
  }

  WebtritSystemInfo domainInfo({Version? minSupportedAppVersion, String? bundleVersion}) {
    return WebtritSystemInfo(
      core: CoreInfo(version: Version(1, 0, 0)),
      postgres: PostgresInfo(version: '15.0'),
      minSupportedAppVersion: minSupportedAppVersion,
      bundleVersion: bundleVersion,
    );
  }

  group('SystemInfoApiMapper.systemInfoFromApi minSupportedAppVersion', () {
    test('parses a valid semver string into a Version', () {
      expect(
        mapper.systemInfoFromApi(apiInfo(minSupportedAppVersion: '1.5.0')).minSupportedAppVersion,
        Version(1, 5, 0),
      );
    });

    test('maps null to null', () {
      expect(mapper.systemInfoFromApi(apiInfo(minSupportedAppVersion: null)).minSupportedAppVersion, isNull);
    });

    test('maps a malformed string to null instead of throwing', () {
      expect(mapper.systemInfoFromApi(apiInfo(minSupportedAppVersion: '1.x')).minSupportedAppVersion, isNull);
    });
  });

  group('SystemInfoJsonMapper minSupportedAppVersion round-trip', () {
    test('round-trips a non-null version through to/from map', () {
      final map = mapper.systemInfoToMap(domainInfo(minSupportedAppVersion: Version(1, 5, 0)));
      expect(map['min_supported_app_version'], '1.5.0');
      expect(mapper.systemInfoFromMap(map).minSupportedAppVersion, Version(1, 5, 0));
    });

    test('round-trips null', () {
      final map = mapper.systemInfoToMap(domainInfo(minSupportedAppVersion: null));
      expect(map['min_supported_app_version'], isNull);
      expect(mapper.systemInfoFromMap(map).minSupportedAppVersion, isNull);
    });

    test('reads a malformed cached value as null instead of throwing', () {
      final map = mapper.systemInfoToMap(domainInfo())..['min_supported_app_version'] = 'garbage';
      expect(mapper.systemInfoFromMap(map).minSupportedAppVersion, isNull);
    });
  });

  group('SystemInfoApiMapper.systemInfoFromApi bundleVersion', () {
    test('passes the raw string through', () {
      expect(mapper.systemInfoFromApi(apiInfo(bundleVersion: '0.14.7')).bundleVersion, '0.14.7');
    });

    test('maps null to null', () {
      expect(mapper.systemInfoFromApi(apiInfo(bundleVersion: null)).bundleVersion, isNull);
    });
  });

  group('SystemInfoJsonMapper bundleVersion round-trip', () {
    test('round-trips a non-null value through to/from map', () {
      final map = mapper.systemInfoToMap(domainInfo(bundleVersion: '0.14.7'));
      expect(map['bundle_version'], '0.14.7');
      expect(mapper.systemInfoFromMap(map).bundleVersion, '0.14.7');
    });

    test('round-trips null', () {
      final map = mapper.systemInfoToMap(domainInfo(bundleVersion: null));
      expect(map['bundle_version'], isNull);
      expect(mapper.systemInfoFromMap(map).bundleVersion, isNull);
    });

    test('reads a cached map without the key as null', () {
      final map = mapper.systemInfoToMap(domainInfo())..remove('bundle_version');
      expect(mapper.systemInfoFromMap(map).bundleVersion, isNull);
    });
  });
}
