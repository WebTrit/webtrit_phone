import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/core_support.dart';

final _logger = Logger('FeatureAccessStreamFactory');

class FeatureAccessStreamFactory {
  final AppThemes appThemes;
  final SystemInfoRepository systemInfoRepository;
  final RemoteConfigService remoteConfigService;

  FeatureAccessStreamFactory({
    required this.appThemes,
    required this.systemInfoRepository,
    required this.remoteConfigService,
  });

  Future<FeatureAccess> getInitialSnapshot() async {
    final systemInfo = await systemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly);
    return _build(systemInfo, remoteConfigService.snapshot);
  }

  Stream<FeatureAccess> create() async* {
    final initialSystemInfo = await systemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly);
    final initialConfig = remoteConfigService.snapshot;

    yield* CombineLatestStream.combine2<WebtritSystemInfo?, RemoteConfigSnapshot, FeatureAccess>(
      systemInfoRepository.infoStream.cast<WebtritSystemInfo?>().startWith(initialSystemInfo),
      remoteConfigService.onConfigUpdated.startWith(initialConfig),
      (systemInfo, remoteConfig) {
        _logger.info('Updating FeatureAccess from reactive stream');
        return _build(systemInfo, remoteConfig);
      },
    );
  }

  FeatureAccess _build(WebtritSystemInfo? systemInfo, RemoteConfigSnapshot remoteConfig) {
    final coreSupport = CoreSupportFactory.create(systemInfo);
    final overrides = FeatureOverridesFactory.create(remoteConfig);

    return FeatureAccess.create(appThemes.appConfig, appThemes.embeddedResources, coreSupport, overrides);
  }
}
