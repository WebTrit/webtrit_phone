import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Contract for resolving the cleanup of the user session.
abstract interface class UserSessionCleanupResolver {
  Future<void> resolve();
}

/// Implementation of [UserSessionCleanupResolver] that delegates cleanup logic
/// to specific repositories and the application database.
class RepositoryUserSessionCleanupResolver implements UserSessionCleanupResolver {
  const RepositoryUserSessionCleanupResolver({
    required this.systemInfoRepository,
    required this.registerStatusRepository,
    required this.presenceSettingsRepository,
    required this.activeMainFlavorRepository,
    required this.callerIdSettingsRepository,
    required this.activeRecentsVisibilityFilterRepository,
    required this.activeContactSourceTypeRepository,
    required this.audioProcessingSettingsRepository,
    required this.encodingPresetRepository,
    required this.iceSettingsRepository,
    required this.incomingCallTypeRepository,
    required this.peerConnectionSettingsRepository,
    required this.videoCapturingSettingsRepository,
    required this.encodingSettingsRepository,
    required this.localeRepository,
    required this.themeModeRepository,
    required this.appDatabase,
  });

  final SystemInfoRepository systemInfoRepository;
  final RegisterStatusRepository registerStatusRepository;
  final PresenceSettingsRepository presenceSettingsRepository;
  final ActiveMainFlavorRepository activeMainFlavorRepository;
  final CallerIdSettingsRepository callerIdSettingsRepository;
  final ActiveRecentsVisibilityFilterRepository activeRecentsVisibilityFilterRepository;
  final ActiveContactSourceTypeRepository activeContactSourceTypeRepository;
  final AudioProcessingSettingsRepository audioProcessingSettingsRepository;
  final EncodingPresetRepository encodingPresetRepository;
  final IceSettingsRepository iceSettingsRepository;
  final IncomingCallTypeRepository incomingCallTypeRepository;
  final PeerConnectionSettingsRepository peerConnectionSettingsRepository;
  final VideoCapturingSettingsRepository videoCapturingSettingsRepository;
  final EncodingSettingsRepository encodingSettingsRepository;
  final LocaleRepository localeRepository;
  final ThemeModeRepository themeModeRepository;
  final AppDatabase appDatabase;

  @override
  Future<void> resolve() async {
    await Future.wait([
      systemInfoRepository.clear(),
      registerStatusRepository.clear(),
      presenceSettingsRepository.clear(),
      activeMainFlavorRepository.clear(),
      callerIdSettingsRepository.clear(),
      activeRecentsVisibilityFilterRepository.clear(),
      activeContactSourceTypeRepository.clear(),
      audioProcessingSettingsRepository.clear(),
      encodingPresetRepository.clear(),
      iceSettingsRepository.clear(),
      incomingCallTypeRepository.clear(),
      peerConnectionSettingsRepository.clear(),
      videoCapturingSettingsRepository.clear(),
      encodingSettingsRepository.clear(),
      localeRepository.clear(),
      themeModeRepository.clear(),
    ]);

    await appDatabase.deleteEverything();
  }
}
