import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

import '../models/models.dart';

part 'demo_cubit_state.dart';

part 'demo_cubit.freezed.dart';

final _logger = Logger('DemoCubit');

class DemoCubit extends Cubit<DemoCubitState> {
  DemoCubit({
    required WebtritApiClient webtritApiClient,
    required String token,
    required Locale locale,
    required MainFlavor flavor,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        super(DemoCubitState(flavor: flavor, locale: locale));

  final WebtritApiClient _webtritApiClient;

  final String _token;

  bool get _isLoadActionForCurrentFlavor => state.actions[state.flavor]?.isIncomplete ?? true;

  void updateConfiguration({
    MainFlavor? flavor,
    bool? enable,
    Locale? locale,
  }) async {
    final newFlavor = flavor ?? state.flavor;
    final newAvailability = enable ?? state.enable;
    final newLocale = locale ?? state.locale;
    final newActions = locale != state.locale ? <MainFlavor, DemoActions>{} : state.actions;

    _logger.fine('Update configuration: flavor=$newFlavor, enable=$newAvailability, locale=$newLocale');

    emit(state.copyWith(
      flavor: newFlavor,
      enable: newAvailability,
      locale: newLocale,
      actions: newActions,
    ));
  }

  void getActions() async {
    if (!state.enable) return;

    final flavorActions = Map.of(state.actions);
    final flavor = state.flavor;

    final userInfo = await _getUserInfo();
    if (_isLoadActionForCurrentFlavor) {
      _logger.fine('Load actions for flavor: $flavor');
      try {
        final actions = await _getActions(flavor, userInfo);
        flavorActions[flavor] = DemoActions.complete(actions.actions);
      } catch (e) {
        flavorActions[flavor] = DemoActions.complete([]);
      }
    } else {
      _logger.fine('Actions for flavor $flavor already loaded');
    }

    emit(state.copyWith(
      actions: flavorActions,
      userInfo: userInfo,
    ));
  }

  Future<DemoCallToActionsResponse> _getActions(MainFlavor tab, UserInfo userInfo) async {
    _logger.fine('Get actions for tab: $tab');
    return _webtritApiClient.getCallToActions(
      _token,
      state.locale.toString(),
      DemoCallToActionsParam(
        email: userInfo.email!,
        tab: tab.name,
      ),
    );
  }

  Future<UserInfo> _getUserInfo() async {
    final account = state.userInfo ?? await _webtritApiClient.getUserInfo(_token);
    return account;
  }
}
