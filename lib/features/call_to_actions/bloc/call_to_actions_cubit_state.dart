part of 'call_to_actions_cubit.dart';

@freezed
class CallToActionsCubitState with _$CallToActionsCubitState {
  const CallToActionsCubitState._();

  const factory CallToActionsCubitState({
    required Locale locale,
    @Default({}) Map<MainFlavor, List<CallToAction>> actions,
    @Default(true) bool visible,
    MainFlavor? flavor,
  }) = _CallToActionsCubitState;

  // Returns the first action associated with the current flavor.
  CallToAction? get action => actions[flavor]?.firstOrNull;

  // Determines if the call-to-action should be visible.
  // Call-to-actions are allowed when:
  // - The current screen is a root screen.
  // - `_hasAllowedAction` is true, indicating the flavor has actions or none are explicitly defined.
  bool get isActionVisible => visible && _hasAllowedAction;

  // Checks if the flavor has allowed actions:
  // - If `flavor` is null, no data was received from the server.
  // - If the actions list for the flavor is empty, it indicates the server returned an empty list.
  // In both cases, no call-to-action should be shown.
  bool get _hasAllowedAction {
    final flavorActions = actions[flavor];
    return flavorActions == null || flavorActions.isNotEmpty;
  }
}
