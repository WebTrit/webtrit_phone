part of 'demo_cubit.dart';

@freezed
class DemoCubitState with _$DemoCubitState {
  const factory DemoCubitState({
    MainFlavor? mainFlavor,
    UserInfo? userInfo,
    @Default({}) Map<MainFlavor, DemoActions> actions,
    @Default(false) bool showConvertedButton,
    @Default(false) bool openDemoWebScreen,
    String? convertPbxUrl,
  }) = _DemoCubitState;
}
