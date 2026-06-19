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
    required this.appCompatibilityResolver,
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
  final AppCompatibilityResolver appCompatibilityResolver;

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

  /// Handles the [WebtritSystemInfo] arrival event: resolves the app/core
  /// compatibility state and emits it as the [CoreVersionState] the UI gates on.
  void _onSystemInfoArrived(MainBlocSystemInfoArrived event, Emitter<MainBlocState> emit) async {
    final coreVersionState = _resolveCoreVersionState(event.systemInfo);
    // The store link is async and best-effort, so it is attached after the pure
    // state resolution rather than computed inside it.
    emit(state.copyWith(coreVersionState: await _withStoreUpdateUrl(coreVersionState)));
  }

  /// Maps the shared [AppCompatibility] domain decision to the [CoreVersionState]
  /// the main UI gates on. The version rules and their priority live in
  /// [AppCompatibility.resolve], shared with the login gate.
  CoreVersionState _resolveCoreVersionState(WebtritSystemInfo systemInfo) {
    final compatibility = appCompatibilityResolver.resolve(
      systemInfo: systemInfo,
      appVersion: appVersion,
      coreVersionConstraint: coreVersionConstraint,
    );
    return switch (compatibility) {
      AppVersionTooOld(:final appVersion, :final minSupportedVersion) => AppVersionUnsupported(
        appVersion,
        minSupportedVersion,
      ),
      CoreVersionUnsupported(:final coreVersion, :final constraint) => Incompatible(coreVersion, constraint),
      AppCompatible() => Compatible(),
    };
  }

  /// Attaches the best-effort store update URL to the "needs update" states;
  /// the others pass through unchanged.
  Future<CoreVersionState> _withStoreUpdateUrl(CoreVersionState coreVersionState) async {
    switch (coreVersionState) {
      case AppVersionUnsupported():
        return AppVersionUnsupported(
          coreVersionState.currentVersion,
          coreVersionState.minSupportedVersion,
          updateStoreUrl: await _resolveStoreUpdateUrl(),
        );
      case Incompatible():
        return Incompatible(
          coreVersionState.currentVersion,
          coreVersionState.supportedConstraint,
          updateStoreUrl: await _resolveStoreUpdateUrl(),
        );
      case Compatible():
      case Unknown():
        return coreVersionState;
    }
  }

  /// Resolves the store URL to offer as the "Update" action, but only when the
  /// store actually hosts a build newer than the running one. Failures are
  /// swallowed (the prompt simply omits the Update button).
  Future<Uri?> _resolveStoreUpdateUrl() async {
    StoreInfo? storeInfo;

    try {
      storeInfo = await storeInfoExtractor?.getStoreInfo(appPackageName);
    } catch (e, stackTrace) {
      _logger.warning('storeInfoExtractor.getStoreInfo for $appPackageName error - ignore', e, stackTrace);
    }

    if (storeInfo != null && storeInfo.version > appVersion) {
      return storeInfo.viewUrl;
    }
    return null;
  }

  void _onAppUpdatePressed(MainBlocAppUpdatePressed event, Emitter<MainBlocState> emit) async {
    if (await canLaunchUrl(event.storeUrl)) {
      await launchUrl(event.storeUrl, mode: LaunchMode.externalApplication);
    }
  }
}
