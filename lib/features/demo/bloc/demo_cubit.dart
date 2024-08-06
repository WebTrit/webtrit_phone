import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/features/main/main.dart';

import '../models/models.dart';

part 'demo_cubit_state.dart';

part 'demo_cubit.freezed.dart';

final _logger = Logger('DemoCubit');

class DemoCubit extends Cubit<DemoCubitState> {
  DemoCubit({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        super(const DemoCubitState());

  final WebtritApiClient _webtritApiClient;

  final String _token;

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
}
