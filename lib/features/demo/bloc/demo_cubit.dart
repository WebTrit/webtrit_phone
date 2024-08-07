import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/features/main/main.dart';

import '../models/models.dart';

part 'demo_cubit_state.dart';

part 'demo_cubit.freezed.dart';

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

  void updateConfiguration({
    MainFlavor? flavor,
    bool? enable,
    Locale? locale,
  }) async {
    final newFlavor = flavor ?? state.flavor;
    final newAvailability = enable ?? state.enable;
    final newLocale = locale ?? state.locale;
    final newActions = locale != state.locale ? <MainFlavor, DemoActions>{} : state.actions;

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

    if (flavorActions[flavor]?.isIncomplete ?? true) {
      try {
        final actions = await _getActions(flavor, userInfo);
        flavorActions[flavor] = DemoActions.complete(actions.actions);
      } catch (e) {
        flavorActions[flavor] = DemoActions.complete([]);
      }
    }

    emit(state.copyWith(
      actions: flavorActions,
      userInfo: userInfo,
    ));
  }

  Future<DemoCallToActionsResponse> _getActions(MainFlavor tab, UserInfo userInfo) async {
    final callToActionParam = DemoCallToActionsParam(
      email: userInfo.email!,
      tab: tab.name,
    );

    final actions = _webtritApiClient.getCallToActions(
      _token,
      state.locale.toString(),
      callToActionParam,
    );

    return actions;
  }

  Future<UserInfo> _getUserInfo() async {
    final account = state.userInfo ?? await _webtritApiClient.getUserInfo(_token);
    return account;
  }
}
