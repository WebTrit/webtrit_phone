part of 'demo_cubit.dart';

enum DemoAction {
  showInviteDialog,
  showConvertedButton,
  showConvertWeb,
}

@freezed
class DemoCubitState with _$DemoCubitState {
  const factory DemoCubitState({
    DemoAction? uiAction,
    String? inviteUrl,
    String? convertPbxUrl,
  }) = _DemoCubitState;
}
