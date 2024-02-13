import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'main_bloc.freezed.dart';

part 'main_event.dart';

part 'main_state.dart';

final _logger = Logger('MainBloc');

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required this.infoRepository,
    this.storeInfoExtractor,
  }) : super(const MainState()) {
    on<MainStarted>(_onStarted, transformer: restartable());
    on<MainCompatibilityVerified>(_onCompatibilityVerified, transformer: sequential());
    on<MainAppUpdated>(_onAppUpdated, transformer: droppable());
  }

  final InfoRepository infoRepository;
  final StoreInfoExtractor? storeInfoExtractor;

  Timer? _repeatTimer;

  @override
  Future<void> close() async {
    _repeatTimer?.cancel();

    await super.close();
  }

  void _onStarted(MainStarted event, Emitter<MainState> emit) async {
    add(const MainCompatibilityVerified());
  }

  void _onCompatibilityVerified(MainCompatibilityVerified event, Emitter<MainState> emit) async {
    emit(state.copyWith(
      error: null,
      updateStoreViewUrl: null,
    ));
    try {
      final actualCoreVersion = await infoRepository.getCoreVersion();
      CoreVersion.supported().verify(actualCoreVersion);
    } on CoreVersionUnsupportedException catch (e) {
      final appPackageName = PackageInfo().packageName;
      final appVersion = Version.parse(PackageInfo().version);
      StoreInfo? storeInfo;
      try {
        storeInfo = await storeInfoExtractor?.getStoreInfo(appPackageName);
      } catch (e, stackTrace) {
        // this error can be ignored because, technically, this functionality is optional
        _logger.warning('storeInfoExtractor.getStoreInfo for $appPackageName error - ignore', e, stackTrace);
      }
      Uri? storeViewUrl;
      if (storeInfo != null && storeInfo.version > appVersion) {
        storeViewUrl = storeInfo.viewUrl;
      }
      emit(state.copyWith(
        error: e,
        updateStoreViewUrl: storeViewUrl,
      ));
    } catch (e, stackTrace) {
      const delay = kCompatibilityVerifyRepeatDelay;
      _logger.warning('_onCompatibilityVerified error - repeat in $delay', e, stackTrace);
      _repeatTimer?.cancel();
      _repeatTimer = Timer(delay, () {
        _logger.info('Timer callback - repeat after $delay');
        add(const MainCompatibilityVerified());
      });
    }
  }

  void _onAppUpdated(MainAppUpdated event, Emitter<MainState> emit) async {
    final storeViewUrl = event.storeViewUrl;
    if (await canLaunchUrl(storeViewUrl)) {
      await launchUrl(
        storeViewUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
