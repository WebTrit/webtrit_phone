import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

part 'demo_cubit_state.dart';

part 'demo_cubit.freezed.dart';

final _logger = Logger('DemoCubit');

class DemoCubit extends Cubit<DemoCubitState> {
  DemoCubit({
    required WebtritApiClient webtritApiClient,
    required PlatformInfo platformInfo,
    required AppInfo appInfo,
    required String tenantId,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _platformInfo = platformInfo,
        _appInfo = appInfo,
        _tenantId = tenantId,
        _token = token,
        super(const DemoCubitState()) {
    _initializeConvertPbxUrl();
  }

  final WebtritApiClient _webtritApiClient;
  final PlatformInfo _platformInfo;
  final AppInfo _appInfo;

  final String _token;
  final String _tenantId;

  final _actionConvert = 'convert';

  Future<DemoData> _generateAction(String type) async {
    final account = await _webtritApiClient.getUserInfo(_token);
    _logger.info('_generateAction: $account');

    return _webtritApiClient.createDemoData(DemoCredential(
      type: _platformInfo.appType,
      identifier: _appInfo.identifier,
      email: account.email!,
      tenantId: _tenantId,
      action: type,
    ));
  }

  void _initializeConvertPbxUrl() async {
    try {
      final data = await _generateAction(_actionConvert);

      _logger.info('_initializeConvertPbxUrl: $data');

      emit(state.copyWith(
        convertPbxUrl: data.convertPbxUrl,
      ));
    } catch (e) {
      _logger.warning('_initializeConvertPbxUrl: $e');
    }
  }

  void changeVisibleConvertedButton(bool visible) async {
    emit(state.copyWith(showConvertedButton: visible));
  }

  void openDemoWebScreen() async {
    emit(state.copyWith(openDemoWebScreen: true));
    emit(state.copyWith(openDemoWebScreen: false));
  }
}
