import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/mappers/signaling/signaling.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('PresenceSyncService');

abstract interface class PresenceSyncService {
  const factory PresenceSyncService.disabled() = _DisabledPresenceSyncService;

  void start();
  void stop();
  Future<void> sync();
}

final class _DisabledPresenceSyncService implements PresenceSyncService {
  const _DisabledPresenceSyncService();

  @override
  void start() {}

  @override
  void stop() {}

  @override
  Future<void> sync() async {}
}

final class LivePresenceSyncService implements PresenceSyncService {
  LivePresenceSyncService({
    required PresenceSettingsRepository settingsRepository,
    required WebtritSignalingClient? Function() signalingClientProvider,
    required bool Function() isReady,
  }) : _settingsRepository = settingsRepository,
       _signalingClientProvider = signalingClientProvider,
       _isReady = isReady;

  final PresenceSettingsRepository _settingsRepository;
  final WebtritSignalingClient? Function() _signalingClientProvider;
  final bool Function() _isReady;

  Timer? _timer;

  @override
  void start() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => sync());
  }

  @override
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> sync() async {
    final now = DateTime.now();
    final lastSync = _settingsRepository.lastSettingsSync;
    final presenceSettings = _settingsRepository.presenceSettings;

    final canUpdate = _isReady();
    bool shouldUpdate = false;
    if (lastSync == null) {
      shouldUpdate = true;
    } else if (presenceSettings.timestamp.difference(lastSync).inSeconds > 0) {
      shouldUpdate = true;
    } else if (now.difference(lastSync).inMinutes >= 30) {
      shouldUpdate = true;
    }

    if (shouldUpdate && canUpdate) {
      _logger.fine('sync: updating presence settings');
      try {
        await _signalingClientProvider()?.execute(
          PresenceSettingsUpdateRequest(
            transaction: clock.now().millisecondsSinceEpoch.toString(),
            settings: SignalingPresenceSettingsMapper.toSignaling(presenceSettings),
          ),
        );
        _settingsRepository.updateLastSettingsSync(now);
        _logger.fine('Presence settings updated at $now');
      } on Exception catch (e, s) {
        _logger.warning('Failed to update presence settings', e, s);
      }
    }
  }
}
