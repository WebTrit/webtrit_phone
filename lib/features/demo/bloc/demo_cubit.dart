import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/main/main.dart';

import '../models/models.dart';

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

  final _typeConvert = 'convert';

  void updateFlavorActions(MainFlavor? flavor) async {
    if (flavor != null) {
      _getFlavorActions(flavor);
    }

    emit(state.copyWith(mainFlavor: flavor));
  }

  void _getFlavorActions(MainFlavor flavor) async {
    final flavorActions = Map.of(state.actions);
    final userInfo = await _getUserInfo();

    if (flavorActions[flavor]?.isIncomplete ?? true) {
      try {
        final actions = await _getActions(flavor, userInfo);
        flavorActions[flavor] = DemoActions.complete(actions.actions);
      } catch (e) {
        flavorActions[flavor] = DemoActions.complete([]);
      }
    }

    emit(state.copyWith(actions: flavorActions, userInfo: userInfo));
  }

  Future<UserInfo> _getUserInfo() async {
    final account = state.userInfo ?? await _webtritApiClient.getUserInfo(_token);
    _logger.info('_getUserInfo: $account');
    return account;
  }

  Future<DemoCallToActionsResponse> _getActions(MainFlavor tab, UserInfo userInfo) async {
    final callToActionParam = DemoCallToActionsParam(
      email: userInfo.email!,
      tab: tab.name,
    );
    final actions = _webtritApiClient.getCallToActions(_token, callToActionParam);

    _logger.info('_getActions: $actions');

    return actions;
  }

  Future<DemoData> _prepareRequest(String type) async {
    final account = await _webtritApiClient.getUserInfo(_token);
    _logger.info('_prepareRequest: $account');

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
      final data = await _prepareRequest(_typeConvert);

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
