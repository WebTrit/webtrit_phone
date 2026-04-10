/// Determines the visual presentation mode of the call interface.
///
/// Derived from the presence of active calls and the current minimization state.
enum CallDisplay {
  /// The call interface is hidden.
  none,

  /// The call interface is visible but displays an empty state.
  ///
  /// This occurs when the user navigates to the call screen while there are
  /// no active calls.
  noneScreen,

  /// The call interface is visible in full-screen mode with active calls.
  screen,

  /// The call interface is minimized as a floating overlay.
  overlay,
}
