import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'main_event.dart';

part 'main_state.dart';

// TODO: maybe split the bloc into two separate blocs: SystemInfoSyncBloc and (CoreCompatibilityBloc or MainScreenBloc)
// coz the the system info sync not binded to MainScreen lifecycle, but url launch logic is

final _logger = Logger('MainBloc');

class MainBloc extends Bloc<MainBlocEvent, MainBlocState> {
  MainBloc(
    this.systemInfoRepository,
    this.customPrivateGatewayRepository,
    this.coreVersionConstraint,
    this.packageInfo, {
    this.storeInfoExtractor,
  }) : super(MainBlocState.initial()) {
    on<MainBlocInit>(_onInit, transformer: restartable());
    on<MainBlocSystemInfoArrived>(_onSystemInfoArrived, transformer: droppable());
    on<MainBlocAppUpdatePressed>(_onAppUpdatePressed, transformer: droppable());
  }

  final SystemInfoRepository systemInfoRepository;
  final PrivateGatewayRepository customPrivateGatewayRepository;
  final String coreVersionConstraint;
  final StoreInfoExtractor? storeInfoExtractor;
  final PackageInfo packageInfo;

  String get appPackageName => packageInfo.packageName;

  Version get appVersion => Version.parse(packageInfo.version);

  StreamSubscription<WebtritSystemInfo>? _systemInfoSubscription;

  @override
  Future<void> close() async {
    _systemInfoSubscription?.cancel();
    await super.close();
  }

  /// Handles the [MainBlocInit] event.
  ///
  /// Initialize local system info and keeps it in sync with the remote one.
  /// To use it in core version compatibility verification, it emits the [MainBlocSystemInfoArrived] event.
  void _onInit(MainBlocInit event, Emitter<MainBlocState> emit) async {
    // First, process the current system info if it's available
    var currentSystemInfo = await systemInfoRepository.getSystemInfo();
    if (currentSystemInfo != null) {
      add(MainBlocSystemInfoArrived(currentSystemInfo));
    }

    // Then, subscribe to the stream for future updates
    _systemInfoSubscription?.cancel();
    _systemInfoSubscription = systemInfoRepository.infoStream.listen((systemInfoUpdate) {
      add(MainBlocSystemInfoArrived(systemInfoUpdate));
    });
  }

  /// Handles the [WebtritSystemInfo] arrival event.
  /// Verifies the compatibility of the core version with the app.
  /// If the core version is not supported, it shows the compatibility issue dialog.
  ///
  /// Also chacks if the app is up to date and can be a reason for the incompatibility.
  /// in this case, it shows the dialog with the app update button.
  void _onSystemInfoArrived(MainBlocSystemInfoArrived event, Emitter<MainBlocState> emit) async {
    final coreInfo = event.systemInfo.core;
    final constraint = VersionConstraint.parse(coreVersionConstraint);
    final isCoreSupported = coreInfo.verifyVersionStr(coreVersionConstraint);

    if (isCoreSupported) {
      emit(state.copyWith(coreVersionState: Compatible()));
    } else {
      Uri? maybeStoreUrl;

      StoreInfo? storeInfo;

      try {
        storeInfo = await storeInfoExtractor?.getStoreInfo(appPackageName);
      } catch (e, stackTrace) {
        _logger.warning('storeInfoExtractor.getStoreInfo for $appPackageName error - ignore', e, stackTrace);
      }

      if (storeInfo != null && storeInfo.version > appVersion) {
        maybeStoreUrl = storeInfo.viewUrl;
      }

      var coreVersionState = Incompatible(coreInfo.version, constraint, updateStoreUrl: maybeStoreUrl);
      emit(state.copyWith(coreVersionState: coreVersionState));
    }
  }

  void _onAppUpdatePressed(MainBlocAppUpdatePressed event, Emitter<MainBlocState> emit) async {
    if (await canLaunchUrl(event.storeUrl)) {
      await launchUrl(event.storeUrl, mode: LaunchMode.externalApplication);
    }
  }
}
