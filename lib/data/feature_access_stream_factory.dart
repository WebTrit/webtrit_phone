import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

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

  Stream<FeatureAccess> create() async* {
    final initialSystemInfo = await systemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly);

    yield FeatureAccess.create(
      appThemes.appConfig,
      appThemes.embeddedResources,
      initialSystemInfo,
      remoteConfigService.snapshot,
    );

    yield* StreamUtils.combineLatest2(systemInfoRepository.infoStream, remoteConfigService.onConfigUpdated, (
      systemInfo,
      remoteConfigSnapshot,
    ) {
      final actualSystemInfo = systemInfo ?? initialSystemInfo;
      final actualSnapshot = remoteConfigSnapshot ?? remoteConfigService.snapshot;

      _logger.info('Updating FeatureAccess from reactive stream');

      return FeatureAccess.create(appThemes.appConfig, appThemes.embeddedResources, actualSystemInfo, actualSnapshot);
    });
  }
}
