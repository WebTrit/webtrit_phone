import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

part 'user_action_bloc_state.dart';

part 'user_action_bloc_cubit.freezed.dart';

class UserActionBlocCubit extends Cubit<UserActionBlocState> {
  UserActionBlocCubit({
    required this.tenantId,
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        super(const UserActionBlocState());

  final Duration _startupDurationToInvite = const Duration(seconds: 15);
  final Duration _durationDurationToInvite = const Duration(seconds: 60);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  final actionInvite = 'invite';
  final actionConvert = 'convert';

  Timer? _timer;
  final String tenantId;

  void enableInviteFriendFlow() => _initializeInviteCountdownDialog(_startupDurationToInvite);

  void enableConnectVoIP() => _initializeConvertPbxUrl();

  void postponeDialogCountdown() {
    _initializeInviteCountdownDialog(_durationDurationToInvite);
  }

  void stopDialogCountdown() {
    _timer?.cancel();
  }

  void openConvertBbxUrl() {
    emit(state.copyWith(uiAction: UiAction.showConvertWeb));
    emit(state.copyWith(uiAction: null));
  }

  Future<UserActionData> _generateAction(String type) async {
    final account = await _webtritApiClient.getUserInfo(_token);
    final result = await _webtritApiClient.createUserActionRequest(UserActionCredential(
      type: PlatformInfo().appType,
      identifier: AppInfo().identifier,
      email: account.email!,
      tenantId: tenantId,
      action: type,
    ));

    return result;
  }

  void _initializeInviteCountdownDialog(Duration duration) async {
    _timer?.cancel();
    _timer = Timer.periodic(duration, (timer) async {
      final data = await _generateAction(actionInvite);

      emit(state.copyWith(
        uiAction: UiAction.showInviteDialog,
        inviteUrl: data.inviteFriendsUrl,
        convertPbxUrl: state.convertPbxUrl,
      ));
      emit(state.copyWith(uiAction: null));

      _timer?.cancel();
    });
  }

  void _initializeConvertPbxUrl() async {
    final data = await _generateAction(actionConvert);

    emit(state.copyWith(
      uiAction: UiAction.showConvertedButton,
      inviteUrl: state.inviteUrl,
      convertPbxUrl: data.convertPbxUrl,
    ));
    emit(state.copyWith(uiAction: null));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
