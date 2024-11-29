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

  void getActions({
    MainFlavor? flavor,
    bool? enable,
    Locale? locale,
  }) async {
    final newFlavor = flavor ?? state.flavor;
    final oldFlavor = state.flavor;
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

    if (newAvailability && newFlavor != oldFlavor) {
      final flavorActions = Map.of(newActions);
      final flavorToFetch = newFlavor;

      final userInfo = await _getUserInfo();
      if (_isLoadActionForCurrentFlavor) {
        _logger.fine('Load actions for flavor: $flavorToFetch');
        try {
          final actions = await _getActions(flavorToFetch, userInfo);
          flavorActions[flavorToFetch] = DemoActions.complete(actions.actions);
        } catch (e) {
          flavorActions[flavorToFetch] = DemoActions.complete([]);
        }
      } else {
        _logger.fine('Actions for flavor $flavorToFetch already loaded');
      }

      emit(state.copyWith(
        actions: flavorActions,
        userInfo: userInfo,
      ));
    }
  }

  Future<DemoCallToActionsResponse> _getActions(MainFlavor tab, UserInfo userInfo) async {
    _logger.fine('Get actions for tab: $tab');
    final param = DemoCallToActionsParam(
      email: userInfo.email!,
      tab: tab.name,
    );

    return _webtritApiClient.getCallToActions(
      _token,
      state.locale.toString(),
      param,
      options: RequestOptions.withNoRetries(),
    );
  }

  Future<UserInfo> _getUserInfo() async {
    final account = state.userInfo ?? await _webtritApiClient.getUserInfo(_token);
    return account;
  }
}
