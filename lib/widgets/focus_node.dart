import 'package:flutter/widgets.dart';

// Hack (because of StackTrace analysis) way to prevent keyboard from showing
class PreventKeyboardFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevent keyboard from showing on focus
    return false;
  }

  @override
  bool get hasFocus {
    // prevent keyboard from showing on tap
    return super.hasFocus && !StackTrace.current.toString().contains('EditableTextState.requestKeyboard');
  }
}
