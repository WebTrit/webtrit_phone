part of 'demo_cubit.dart';

@freezed
class DemoCubitState with _$DemoCubitState {
  const DemoCubitState._();

  const factory DemoCubitState({
    required MainFlavor flavor,
    required Locale locale,
    UserInfo? userInfo,
    @Default(true) bool enable,
    @Default({}) Map<MainFlavor, DemoActions> actions,
  }) = _DemoCubitState;

  List<DemoCallToActionsResponseActions> get flavorActions => enable ? actions[flavor]?.action ?? [] : [];
}
