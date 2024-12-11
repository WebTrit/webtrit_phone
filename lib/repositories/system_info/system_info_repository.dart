import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('SystemInfoRepository');

class SystemInfoRepository with SystemInfoApiMapper {
  SystemInfoRepository(
    this.webtritApiClient, {
    this.polling = true,
    this.pollPeriod = const Duration(minutes: 5),
  }) {
    _updatesController = StreamController<WebtritSystemInfo>.broadcast(
      onListen: _onListen,
      onCancel: _onCancel,
    );
  }
  final WebtritApiClient webtritApiClient;
  final bool polling;
  final Duration pollPeriod;
  late final StreamController<WebtritSystemInfo> _updatesController;

  Timer? _pullTimer;
  WebtritSystemInfo? _lastInfo;

  /// Pay attention, this callback calling only on first listener
  /// read [StreamController.broadcast]
  void _onListen() async {
    if (polling) {
      _pullTimer = Timer.periodic(pollPeriod, (_) => _gatherUserInfo().ignore());
    }
  }

  void _onCancel() {
    _pullTimer?.cancel();
    _pullTimer = null;
  }

  Future<WebtritSystemInfo> _gatherUserInfo() async {
    try {
      final apiSystemInfo = await webtritApiClient.getSystemInfo();
      final newInfo = systemInfoFromApi(apiSystemInfo);

      if (newInfo != _lastInfo) _updatesController.add(newInfo);
      _lastInfo = newInfo;
      return newInfo;
    } catch (e, stackTrace) {
      _logger.warning('_gatherSystemInfo', e, stackTrace);
      _updatesController.addError(e, stackTrace);
      rethrow;
    }
  }

  Future<WebtritSystemInfo> getInfo([bool force = false]) {
    if (force == false && _lastInfo != null) {
      return Future.value(_lastInfo);
    } else {
      return _gatherUserInfo();
    }
  }

  Stream<WebtritSystemInfo> get infoUpdates => _updatesController.stream;

  Uri get coreUrl => webtritApiClient.tenantUrl;
}
