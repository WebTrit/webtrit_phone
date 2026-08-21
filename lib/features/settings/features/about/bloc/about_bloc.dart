import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'about_bloc.freezed.dart';

part 'about_event.dart';

part 'about_state.dart';

final _logger = Logger('AboutBloc');

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc({
    required this.notificationsBloc,
    required AppInfo appInfo,
    required PackageInfo packageInfo,
    required AppMetadataProvider appMetadataProvider,
    required SecureStorage secureStorage,
    required EmbeddedConfig embeddedConfig,
    required this.infoRepository,
  }) : super(
         AboutState(
           packageName: packageInfo.packageName,
           appIdentifier: appInfo.identifier,
           fcmPushToken: secureStorage.readFCMPushToken(),
           embeddedResources: embeddedConfig.embeddedResources,
           // The API client is resolved asynchronously, so the URL arrives with
           // the first refresh instead of being read while the screen is built.
           coreUrl: Uri(),
           userAgent: appMetadataProvider.userAgent,
           appInfo: appMetadataProvider.appInfo,
           deviceInfo: appMetadataProvider.deviceInfo,
           callkeepVersion: appInfo.callkeepVersion,
         ),
       ) {
    on<AboutStarted>(_onStarted, transformer: restartable());
  }

  final NotificationsBloc notificationsBloc;
  final SystemInfoRepository infoRepository;

  void _onStarted(AboutStarted event, Emitter<AboutState> emit) async {
    emit(state.copyWith(progress: true));

    // The Core URL is emitted on its own: this screen exists to answer which
    // backend the build is talking to, so it has to stay filled in even when
    // the system info request below fails (no network, unreachable core).
    try {
      final coreUrl = await infoRepository.getCoreUrl();

      if (emit.isDone) return;

      emit(state.copyWith(coreUrl: coreUrl));
    } catch (e, stackTrace) {
      _logger.warning('_onStarted: core url', e, stackTrace);
    }

    try {
      final systemInfo = await infoRepository.getSystemInfo();
      final coreVersion = systemInfo?.core.version;
      final bundleVersion = systemInfo?.bundleVersion;

      if (emit.isDone) return;

      emit(state.copyWith(progress: false, coreVersion: coreVersion, bundleVersion: bundleVersion));
    } catch (e, stackTrace) {
      _logger.warning('_onStarted', e, stackTrace);

      if (emit.isDone) return;

      emit(state.copyWith(progress: false));
    }
  }
}
