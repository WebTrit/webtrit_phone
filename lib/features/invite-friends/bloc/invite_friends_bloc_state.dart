part of 'invite_friends_bloc_cubit.dart';

@freezed
class InviteFriendsBlocState with _$InviteFriendsBlocState {
  const factory InviteFriendsBlocState.initial() = Initial;

  const factory InviteFriendsBlocState.display({
    String? inviteUrl,
  }) = DisplayInviteFriendsDialog;
}
