part of 'demo_cubit.dart';

@freezed
class DemoCubitState with _$DemoCubitState {
  const factory DemoCubitState({
    @Default(false) bool showConvertedButton,
    @Default(false) bool openDemoWebScreen,
    String? convertPbxUrl,
  }) = _DemoCubitState;
}
