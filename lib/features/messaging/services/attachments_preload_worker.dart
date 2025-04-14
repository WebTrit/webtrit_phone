import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/data/media_storage.dart';
import 'package:webtrit_phone/data/secure_storage.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('AttachmentsPreloadWorker');

class AttachmentsPreloadWorker {
  AttachmentsPreloadWorker(
    this._chatsRepository,
    this._smsRepository,
    this._appPreferences,
    this._secureStorage, {
    this.pullInterval = const Duration(seconds: 1),
    this.initDelay = const Duration(seconds: 5),
    this.noNetworkDelay = const Duration(seconds: 5),
    this.maxSize = 10 * 1024 * 1024,
  }) {
    _connectivitySub = Connectivity().onConnectivityChanged.listen(_handleConnectivity);
  }

  final ChatsRepository _chatsRepository;
  final SmsRepository _smsRepository;
  final AppPreferences _appPreferences;
  final SecureStorage _secureStorage;
  final Duration pullInterval;
  final Duration initDelay;
  final Duration noNetworkDelay;
  final int maxSize;

  bool _disposed = false;
  StreamSubscription? _connectivitySub;
  ConnectivityResult? _connectivityState;

  void _handleConnectivity(List<ConnectivityResult> results) {
    _connectivityState = results.firstWhere(
      (result) => result != ConnectivityResult.none,
      orElse: () => ConnectivityResult.none,
    );
  }

  void init() async {
    _logger.info('Initialising...');

    await Future.delayed(initDelay);

    Future.doWhile(() async {
      if (_disposed) return false;
      if (!_canPreload) return await Future.delayed(noNetworkDelay, () => true);

      await _preloadLastAttachments();

      return await Future.delayed(pullInterval, () => true);
    });
  }

  bool get _canPreload {
    final canPreloadOnWifi = _appPreferences.getAutoDownloadOnWifi();
    final canPreloadOnCellular = _appPreferences.getAutoDownloadOnCellular();
    if (_connectivityState == ConnectivityResult.wifi && canPreloadOnWifi) return true;
    if (_connectivityState == ConnectivityResult.mobile && canPreloadOnCellular) return true;

    return false;
  }

  Future<void> _preloadLastAttachments() async {
    Set<MessageAttachment> attachments = {};

    for (final id in await _chatsRepository.getChatIds()) {
      attachments.addAll(await _chatsRepository.getAttachmentsForLastMessages(id));
    }
    for (final id in await _smsRepository.getConversationIds()) {
      attachments.addAll(await _smsRepository.getAttachmentsForLastMessages(id));
    }

    try {
      final coreUrl = _secureStorage.readCoreUrl()!;
      for (final attachment in attachments) {
        _logger.info('Preloading started: ${attachment.filePath}');
        final url = coreUrl + attachment.filePath;
        await MediaStorage().preloadIf(url: url, maxSize: maxSize);
        _logger.info('Preloading done: ${attachment.filePath}');
      }
    } catch (e, s) {
      _logger.warning('Failed to preload attachments', e, s);
    }
  }

  dispose() {
    _logger.info('Disposing...');
    _disposed = true;
    _connectivitySub?.cancel();
  }
}
