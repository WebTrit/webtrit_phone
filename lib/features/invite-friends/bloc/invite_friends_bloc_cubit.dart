import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import '../../../data/app_info.dart';
import '../../../data/platform_info.dart';

part 'invite_friends_bloc_state.dart';

part 'invite_friends_bloc_cubit.freezed.dart';

class InviteFriendsBlocCubit extends Cubit<InviteFriendsBlocState> {
  InviteFriendsBlocCubit({
    required this.tenantId,
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        super(const InviteFriendsBlocState.initial()) {
    _initializeDialogCountdown(_startupDurationToInvite);
  }

  final Duration _startupDurationToInvite = const Duration(seconds: 15);
  final Duration _durationDurationToInvite = const Duration(seconds: 60);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  Timer? _timer;
  final String tenantId;

  void postponeDialogCountdown() {
    _initializeDialogCountdown(_durationDurationToInvite);
  }

  void stopDialogCountdown() {
    _timer?.cancel();
  }

  Future<String> _generateInviteUrl() async {
    final account = await _webtritApiClient.accountInfo(_token);
    final result = await _webtritApiClient.createUserInviteUrl(UserInviteCredential(
      type: PlatformInfo().appType,
      identifier: AppInfo().identifier,
      email: account.email!,
      tenantId: tenantId,
      action: 'invite',
    ));

    return result.inviteFriendsUrl;
  }

  void _initializeDialogCountdown(Duration duration) async {
    _timer?.cancel();
    emit(const InviteFriendsBlocState.initial());
    _timer = Timer.periodic(duration, (timer) async {
      final url = await _generateInviteUrl();
      emit(InviteFriendsBlocState.display(inviteUrl: url));
      _timer?.cancel();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
