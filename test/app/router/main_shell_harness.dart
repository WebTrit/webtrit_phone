/// Everything needed to pump the real [MainShell] - the full authenticated
/// shell with its repository, service and bloc layers - inside a widget test.
///
/// The harness supplies from above what the composition root provides in
/// production: platform collaborators as fakes (call integration, signaling,
/// push messaging), an in-memory database, and a controllable [FeatureAccess]
/// stream so a test can replay the runtime configuration updates that reach
/// the shell in the field. Network access is inert: flutter_test's HTTP
/// override answers every request with 400, which the repositories treat as
/// an ordinary failed fetch.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart' show SignalingModule, SignalingModuleEvent;

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../helpers/feature_access_factories.dart';
import '../../mocks/fake_connectivity_service.dart';
import '../../mocks/feature_access_mocks.dart';
import '../../mocks/mock_app_preferences.dart';
import '../../mocks/mock_secure_storage.dart';

// --- blocs the shell reads from above -------------------------------------

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class MockNotificationsBloc extends MockBloc<NotificationsEvent, NotificationsState> implements NotificationsBloc {}

// --- platform collaborators -------------------------------------------------

/// Hand-rolled fakes instead of mocktail mocks: the option/handle types these
/// take have no cheap fallback values, and a [Fake] names any member the shell
/// starts using that the harness has not covered yet.
class FakeCallkeep extends Fake implements Callkeep {
  @override
  Future<void> setUp(CallkeepOptions options) async {}

  @override
  Future<void> tearDown() async {}

  @override
  void setDelegate(CallkeepDelegate? delegate) {}

  @override
  Future<bool> isSetUp() async => true;

  @override
  void setPushRegistryDelegate(PushRegistryDelegate? delegate) {}
}

class FakeCallkeepConnections extends Fake implements CallkeepConnections {}

class FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  @override
  Stream<String> get onTokenRefresh => const Stream.empty();

  @override
  Future<String?> getToken({String? vapidKey}) async => null;

  @override
  Future<String?> getAPNSToken() async => null;

  @override
  Future<void> deleteToken() async {}
}

/// A signaling connection that never leaves the process: no events, always
/// "connected enough" for the shell to build.
class FakeSignalingModule extends Fake implements SignalingModule {
  final _events = StreamController<SignalingModuleEvent>.broadcast();

  @override
  Stream<SignalingModuleEvent> get events => _events.stream;

  @override
  bool get isConnected => false;

  @override
  void connect() {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<void> dispose() async {
    await _events.close();
  }
}

class FakeSignalingServiceFactory extends SignalingServiceFactory {
  const FakeSignalingServiceFactory(this.module);

  final FakeSignalingModule module;

  @override
  SignalingModule create({required config, required mode}) => module;
}

// --- repositories and services --------------------------------------------

class MockSystemInfoRepository extends Mock implements SystemInfoRepository {}

class MockAppPermissions extends Mock implements AppPermissions {}

class MockAppLogger extends Mock implements AppLogger {}

class MockAppPath extends Mock implements AppPath {}

class MockAppCertificates extends Mock implements AppCertificates {}

class MockAppMetadataProvider extends Mock implements AppMetadataProvider {}

class MockPushEnvironment extends Mock implements PushEnvironment {}

class MockDiagnosticService extends Mock implements DiagnosticService {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockContactsAgreementStatusRepository extends Mock implements ContactsAgreementStatusRepository {}

class MockLogRecordsRepository extends Mock implements LogRecordsRepository {}

class MockRemoteConfigSnapshot extends Mock implements RemoteConfigSnapshot {}

/// Builds a real [WebtritSystemInfo] mock advertising exactly [supported]
/// adapter capabilities - the lever every scenario of the bug flips.
WebtritSystemInfo systemInfoWithSupported(List<String> supported) {
  final systemInfo = MockWebtritSystemInfo();
  final adapterInfo = MockAdapterInfo();
  when(() => adapterInfo.supported).thenReturn(supported);
  when(() => systemInfo.adapter).thenReturn(adapterInfo);
  when(() => systemInfo.core).thenReturn(CoreInfo(version: Version(0, 1, 0)));
  return systemInfo;
}

/// Builds a real [FeatureAccess] from the shared mock app config and the
/// given system info, the same way the production stream factory does.
FeatureAccess featureAccessFor(WebtritSystemInfo systemInfo) {
  final snapshot = MockRemoteConfigSnapshot();
  when(() => snapshot.getBool(any())).thenReturn(null);
  return FeatureAccess.create(
    createMockAppConfig(),
    [createMockTermsResource()],
    CoreSupportFactory.create(systemInfo),
    systemInfo,
    FeatureOverridesFactory.create(snapshot),
  );
}

/// Registers the mocktail fallback values the harness stubs rely on.
/// Call once from the test file's `setUpAll`.
void registerHarnessFallbacks() {
  registerFallbackValue(FetchPolicy.cacheFirst);
  registerFallbackValue(Permission.camera);
  registerFallbackValue(DiagnosticType.androidCallkeepOnly);
}

class MainShellHarness {
  MainShellHarness({required List<String> initialSupported}) {
    initialSystemInfo = systemInfoWithSupported(initialSupported);
    initialFeatureAccess = featureAccessFor(initialSystemInfo);

    when(() => notificationsBloc.state).thenReturn(const NotificationsState());
    when(
      () => sessionRepository.getCurrent(),
    ).thenReturn(const Session(coreUrl: 'http://127.0.0.1:1', token: 'test-token', userId: 'test-user'));
    when(() => sessionRepository.isRestored).thenReturn(true);
    when(() => sessionRepository.whenRestored).thenAnswer((_) async {});
    when(() => appBloc.state).thenReturn(
      AppState(
        status: AppLifecycleStatus.authenticated,
        session: const Session(coreUrl: 'http://127.0.0.1:1', token: 'test-token'),
        themeMode: ThemeMode.system,
        locale: const Locale('en'),
        userAgreementStatus: AgreementStatus.accepted,
        contactsAgreementStatus: AgreementStatus.accepted,
      ),
    );

    when(() => systemInfoRepository.getLocalSystemInfo()).thenReturn(initialSystemInfo);
    when(
      () => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')),
    ).thenAnswer((_) async => initialSystemInfo);
    when(() => systemInfoRepository.infoStream).thenAnswer((_) => systemInfoController.stream);

    when(() => appPermissions.isDenied).thenAnswer((_) async => false);
    when(() => appPermissions.isContactPermissionGranted()).thenAnswer((_) async => false);
    when(() => appPermissions.isPermissionGranted(any())).thenAnswer((_) async => false);

    when(() => appLogger.updateRemoteLabels()).thenReturn(null);
    when(() => appPath.nativeLogFilePath).thenReturn('/tmp/webtrit-test-native.log');
    when(() => appCertificates.trustedCertificates).thenReturn(TrustedCertificates.empty);
    when(() => appMetadataProvider.userAgent).thenReturn('webtrit-test');
    when(() => contactsAgreementStatusRepository.getContactsAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => diagnosticService.request(any(), extras: any(named: 'extras'))).thenAnswer((_) async {});
  }

  late final WebtritSystemInfo initialSystemInfo;
  late final FeatureAccess initialFeatureAccess;

  final appBloc = MockAppBloc();
  final notificationsBloc = MockNotificationsBloc();
  final callkeep = FakeCallkeep();
  final callkeepConnections = FakeCallkeepConnections();
  final firebaseMessaging = FakeFirebaseMessaging();
  final signalingModule = FakeSignalingModule();
  final connectivityService = FakeConnectivityService();
  final systemInfoRepository = MockSystemInfoRepository();
  final systemInfoController = StreamController<WebtritSystemInfo>.broadcast();
  final featureAccessController = StreamController<FeatureAccess>.broadcast();
  final appPermissions = MockAppPermissions();
  final appLogger = MockAppLogger();
  final appPath = MockAppPath();
  final appCertificates = MockAppCertificates();
  final appMetadataProvider = MockAppMetadataProvider();
  final pushEnvironment = MockPushEnvironment();
  final diagnosticService = MockDiagnosticService();

  final sessionRepository = MockSessionRepository();
  final contactsAgreementStatusRepository = MockContactsAgreementStatusRepository();
  final logRecordsRepository = MockLogRecordsRepository();

  /// Real prefs-backed repositories over an in-memory store, the same shapes
  /// the composition root builds - defaults included, nothing to stub.
  final appPreferences = MockAppPreferences();
  late final userLocalDatasource = UserLocalDatasourcePrefsImpl(appPreferences);
  late final registerStatusRepository = RegisterStatusRepositoryPrefsImpl(appPreferences);
  late final presenceSettingsRepository = PresenceSettingsRepositoryPrefsImpl(appPreferences, 'webtrit-test');
  late final queuedTerminationRequestsRepository = QueuedTerminationRequestsRepositoryPrefsImpl(appPreferences);
  late final activeMainTabRepository = ActiveMainTabRepositoryPrefsImpl(appPreferences);
  late final activeRecentsVisibilityFilterRepository = ActiveRecentsVisibilityFilterRepositoryPrefsImpl(appPreferences);
  late final activeContactSourceTypeRepository = ActiveContactSourceTypeRepositoryPrefsImpl(appPreferences);
  late final audioProcessingSettingsRepository = AudioProcessingSettingsRepositoryPrefsImpl(appPreferences);
  late final encodingPresetRepository = EncodingPresetRepositoryPrefsImpl(appPreferences);
  late final iceSettingsRepository = IceSettingsRepositoryPrefsImpl(appPreferences);
  late final incomingCallTypeRepository = IncomingCallTypeRepositoryPrefsImpl(appPreferences);
  late final peerConnectionSettingsRepository = PeerConnectionSettingsRepositoryPrefsImpl(appPreferences);
  late final videoCapturingSettingsRepository = VideoCapturingSettingsRepositoryPrefsImpl(appPreferences);
  late final encodingSettingsRepository = EncodingSettingsRepositoryPrefsImpl(appPreferences);
  final secureStorage = MockSecureStorage();
  final appDatabase = AppDatabase(NativeDatabase.memory());

  late final AppRouter appRouter = AppRouter(
    appBloc,
    appPermissions,
    systemInfoRepository,
    null,
    initialFeatureAccess.bottomMenuConfig,
    BottomMenuInitialTabResolver(config: initialFeatureAccess.bottomMenuConfig, repository: activeMainTabRepository),
    initialFeatureAccess.checker,
  );

  /// Replays a runtime configuration update: what the reactive FeatureAccess
  /// stream delivers when the backend's capabilities change mid-session.
  void pushFeatureAccess(FeatureAccess featureAccess) => featureAccessController.add(featureAccess);

  Widget build(AppTime appTime) {
    return MultiProvider(
      providers: [
        BlocProvider<AppBloc>.value(value: appBloc),
        BlocProvider<NotificationsBloc>.value(value: notificationsBloc),
        StreamProvider<FeatureAccess>(
          initialData: initialFeatureAccess,
          create: (_) => featureAccessController.stream,
          updateShouldNotify: (previous, next) => previous != next,
        ),
        Provider<Callkeep>.value(value: callkeep),
        Provider<CallkeepConnections>.value(value: callkeepConnections),
        Provider<SignalingServiceFactory>.value(value: FakeSignalingServiceFactory(signalingModule)),
        Provider<FirebaseMessaging>.value(value: firebaseMessaging),
        Provider<DiagnosticService>.value(value: diagnosticService),
        Provider<AppTime>.value(value: appTime),
        Provider<AppCertificates>.value(value: appCertificates),
        Provider<AppLogger>.value(value: appLogger),
        Provider<AppPath>.value(value: appPath),
        Provider<PackageInfo>.value(value: _TestPackageInfo()),
        Provider<AppPreferences>.value(value: appPreferences),
        Provider<SecureStorage>.value(value: secureStorage),
        Provider<AppPermissions>.value(value: appPermissions),
        Provider<AppMetadataProvider>.value(value: appMetadataProvider),
        Provider<PushEnvironment>.value(value: pushEnvironment),
        Provider<AppDatabase>.value(value: appDatabase),
        Provider<ConnectivityService>.value(value: connectivityService),
        RepositoryProvider<SystemInfoRepository>.value(value: systemInfoRepository),
        RepositoryProvider<UserLocalDatasource>.value(value: userLocalDatasource),
        RepositoryProvider<SessionRepository>.value(value: sessionRepository),
        RepositoryProvider<ContactsAgreementStatusRepository>.value(value: contactsAgreementStatusRepository),
        RepositoryProvider<RegisterStatusRepository>.value(value: registerStatusRepository),
        RepositoryProvider<PresenceSettingsRepository>.value(value: presenceSettingsRepository),
        RepositoryProvider<QueuedTerminationRequestsRepository>.value(value: queuedTerminationRequestsRepository),
        RepositoryProvider<ActiveMainTabRepository>.value(value: activeMainTabRepository),
        RepositoryProvider<ActiveRecentsVisibilityFilterRepository>.value(
          value: activeRecentsVisibilityFilterRepository,
        ),
        RepositoryProvider<ActiveContactSourceTypeRepository>.value(value: activeContactSourceTypeRepository),
        RepositoryProvider<AudioProcessingSettingsRepository>.value(value: audioProcessingSettingsRepository),
        RepositoryProvider<EncodingPresetRepository>.value(value: encodingPresetRepository),
        RepositoryProvider<IceSettingsRepository>.value(value: iceSettingsRepository),
        RepositoryProvider<IncomingCallTypeRepository>.value(value: incomingCallTypeRepository),
        RepositoryProvider<PeerConnectionSettingsRepository>.value(value: peerConnectionSettingsRepository),
        RepositoryProvider<VideoCapturingSettingsRepository>.value(value: videoCapturingSettingsRepository),
        RepositoryProvider<EncodingSettingsRepository>.value(value: encodingSettingsRepository),
        RepositoryProvider<LogRecordsRepository>.value(value: logRecordsRepository),
      ],
      child: ThemeProvider(
        settings: const ThemeSettings(),
        lightDynamic: null,
        darkDynamic: null,
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter.config(),
        ),
      ),
    );
  }

  Future<void> dispose() async {
    await systemInfoController.close();
    await featureAccessController.close();
    await appDatabase.close();
  }
}

class _TestPackageInfo implements PackageInfo {
  @override
  String get appName => 'WebTrit Test';

  @override
  String get packageName => 'com.webtrit.phone.test';

  @override
  String get version => '0.0.0';

  @override
  String get buildNumber => '0';
}
