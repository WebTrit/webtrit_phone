import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import '../keypad.dart';

class KeypadView extends StatefulWidget {
  const KeypadView({Key? key}) : super(key: key);

  @override
  _KeypadViewState createState() => _KeypadViewState();
}

class _KeypadViewState extends State<KeypadView> {
  final _keypadTextFieldKey = GlobalKey();

  EditableTextState? get _keypadTextFieldEditableTextState =>
      (_keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = _PreventKeyboardFocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaledInset = MediaQuery.of(context).size.height > 800 ? 16.0 : 8.0;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: scaledInset),
              child: TextField(
                key: _keypadTextFieldKey,
                controller: _controller,
                focusNode: _focusNode,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
                showCursor: true,
              ),
            ),
          ),
        ),
        Keypad(
          onKeypadPressed: _onKeypadPressed,
        ),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (BuildContext context, TextEditingValue value, Widget? child) {
            return BlocBuilder<KeypadCubit, KeypadState>(
              builder: (context, state) {
                return Actionpad(
                  video: state.video,
                  onCallPressed: _onCallPressed,
                  onCallLongPress: _onCallLongPress,
                  onBackspacePressed: value.text.isEmpty ? null : _onBackspacePressed,
                  onBackspaceLongPress: value.text.isEmpty ? null : _onBackspaceLongPress,
                );
              },
            );
          },
        ),
        SizedBox(
          height: scaledInset,
        ),
      ],
    );
  }

  void _onCallPressed() {
    _focusNode.unfocus();

    context.read<KeypadCubit>().call(_controller.text);
  }

  void _onCallLongPress() {
    context.read<KeypadCubit>().callTypeSiwtch();
  }

  void _onKeypadPressed(keyText) {
    if (!_controller.selection.isValid) {
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }

    final textBefore = _controller.selection.textBefore(_controller.text);
    final textAfter = _controller.selection.textAfter(_controller.text);

    final newText = textBefore + keyText + textAfter;
    final newSelection = TextSelection.collapsed(offset: _controller.selection.start + 1);
    final value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _onBackspacePressed() {
    if (!_controller.selection.isValid) {
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }

    final textBefore = _controller.selection.textBefore(_controller.text);
    final textAfter = _controller.selection.textAfter(_controller.text);

    String? newText;
    TextSelection? newSelection;
    if (_controller.selection.isCollapsed) {
      if (textBefore.length > 0) {
        newText = textBefore.substring(0, textBefore.length - 1) + textAfter;
        newSelection = TextSelection.collapsed(offset: _controller.selection.start - 1);
      }
    } else {
      newText = textBefore + textAfter;
      newSelection = TextSelection.collapsed(offset: _controller.selection.start);
    }
    final value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _onBackspaceLongPress() {
    if (!_controller.selection.isValid) {
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }

    final textBefore = _controller.selection.textBefore(_controller.text);
    final textAfter = _controller.selection.textAfter(_controller.text);

    String newText;
    TextSelection newSelection;
    if (_controller.selection.isCollapsed) {
      newText = textAfter;
      newSelection = TextSelection.collapsed(offset: 0);
    } else {
      newText = textBefore + textAfter;
      newSelection = TextSelection.collapsed(offset: _controller.selection.start);
    }
    final value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }
}

// Hack (because of StackTrace analysis) way to prevent keyboard from showing
class _PreventKeyboardFocusNode extends FocusNode {
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
