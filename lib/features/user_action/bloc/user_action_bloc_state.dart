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
