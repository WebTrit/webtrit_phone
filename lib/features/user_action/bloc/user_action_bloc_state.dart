part of 'user_action_bloc_cubit.dart';

enum UiAction {
  showInviteDialog,
  showConvertedButton,
  showConvertWeb,
}

@freezed
class UserActionBlocState with _$UserActionBlocState {
  const factory UserActionBlocState({
    UiAction? uiAction,
    String? inviteUrl,
    String? convertPbxUrl,
  }) = _UserActionBlocState;
}
//   const factory UserActionBlocState.initial({
//     String? inviteUrl,
//     String? convertPbxUrl,
//   }) = Initial;
//
//   const factory UserActionBlocState.displayInviteDialog({
//     String? inviteUrl,
//     String? convertPbxUrl,
//   }) = DisplayInviteFriendsDialog;
//
//   const factory UserActionBlocState.displayConvertPbxUrlButton({
//     String? inviteUrl,
//     String? convertPbxUrl,
//   }) = DisplayConvertPbxButton;
//
//   const factory UserActionBlocState.openConvertPbxWeb({
//     String? inviteUrl,
//     String? convertPbxUrl,
//   }) = OpenConvertPbxWeb;
// }
