import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('UserSessionCleanupResolver');

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
    required this.queuedTerminationRequestsRepository,
    required this.activeMainFlavorRepository,
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
    required this.userLocalDatasource,
    required this.appDatabase,
  });

  final SystemInfoRepository systemInfoRepository;
  final RegisterStatusRepository registerStatusRepository;
  final PresenceSettingsRepository presenceSettingsRepository;
  final QueuedTerminationRequestsRepository queuedTerminationRequestsRepository;
  final ActiveMainFlavorRepository activeMainFlavorRepository;
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
  final UserLocalDatasource userLocalDatasource;
  final AppDatabase appDatabase;

  @override
  Future<void> resolve() async {
    // Orchestrate parallel cleanup across all repositories using a "Best Effort" strategy.
    // The .suppressError() extension ensures that a failure in a single repository
    // does not abort the collective cleanup, maintaining maximum state consistency
    // during the teardown sequence.
    await Future.wait([
      systemInfoRepository.clear().suppressError('systemInfoRepository'),
      registerStatusRepository.clear().suppressError('registerStatusRepository'),
      presenceSettingsRepository.clear().suppressError('presenceSettingsRepository'),
      queuedTerminationRequestsRepository.clear().suppressError('queuedTerminationRequestsRepository'),
      activeMainFlavorRepository.clear().suppressError('activeMainFlavorRepository'),
      activeRecentsVisibilityFilterRepository.clear().suppressError('activeRecentsVisibilityFilterRepository'),
      activeContactSourceTypeRepository.clear().suppressError('activeContactSourceTypeRepository'),
      audioProcessingSettingsRepository.clear().suppressError('audioProcessingSettingsRepository'),
      encodingPresetRepository.clear().suppressError('encodingPresetRepository'),
      iceSettingsRepository.clear().suppressError('iceSettingsRepository'),
      incomingCallTypeRepository.clear().suppressError('incomingCallTypeRepository'),
      peerConnectionSettingsRepository.clear().suppressError('peerConnectionSettingsRepository'),
      videoCapturingSettingsRepository.clear().suppressError('videoCapturingSettingsRepository'),
      encodingSettingsRepository.clear().suppressError('encodingSettingsRepository'),
      userLocalDatasource.clear().suppressError('userRepository'),
      localeRepository.clear().suppressError('localeRepository'),
      themeModeRepository.clear().suppressError('themeModeRepository'),
    ]);

    // Finalize the teardown by decommissioning the local database.
    // Wrapped in a try-catch block to ensure the logout sequence completes
    // regardless of potential storage corruption or file access issues.
    try {
      await appDatabase.deleteEverything();
    } catch (e, st) {
      _logger.severe('Failed to clear AppDatabase', e, st);
    }
  }
}

/// Extension to handle errors gracefully for cleanup tasks, ensuring
/// the "Best Effort" strategy for the teardown process.
extension _SafeFuture on Future<void> {
  Future<void> suppressError(String name) async {
    try {
      await this;
    } catch (e, st) {
      _logger.warning('Failed to clear $name', e, st);
    }
  }
}
