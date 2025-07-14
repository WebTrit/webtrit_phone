import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
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
    required SecureStorage secureStorage,
    required EmbeddedFeature embeddedFeature,
    required this.infoRepository,
  }) : super(AboutState(
          appName: packageInfo.appName,
          packageName: packageInfo.packageName,
          storeBuildVersion: packageInfo.version,
          storeBuildNumber: packageInfo.buildNumber,
          appVersion: appInfo.version,
          appIdentifier: appInfo.identifier,
          fcmPushToken: secureStorage.readFCMPushToken(),
          embeddedLinks: embeddedFeature.embeddedResources.map((e) => e.uri.toString()).toList(),
          coreUrl: infoRepository.coreUrl,
        )) {
    on<AboutStarted>(_onStarted, transformer: restartable());
  }

  final NotificationsBloc notificationsBloc;
  final SystemInfoRepository infoRepository;

  void _onStarted(AboutStarted event, Emitter<AboutState> emit) async {
    emit(state.copyWith(progress: true));
    try {
      final systemInfo = await infoRepository.getInfo();
      final coreVersion = systemInfo.core.version;

      if (emit.isDone) return;

      emit(state.copyWith(progress: false, coreVersion: coreVersion));
    } catch (e, stackTrace) {
      _logger.warning('_onStarted', e, stackTrace);

      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      if (emit.isDone) return;

      emit(state.copyWith(
        progress: false,
      ));
    }
  }
}
