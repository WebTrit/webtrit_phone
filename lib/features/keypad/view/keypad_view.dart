import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

class KeypadView extends StatefulWidget {
  const KeypadView({super.key});

  @override
  KeypadViewState createState() => KeypadViewState();
}

class KeypadViewState extends State<KeypadView> {
  final _keypadTextFieldKey = GlobalKey();

  EditableTextState? get _keypadTextFieldEditableTextState =>
      (_keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
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
    final themeData = Theme.of(context);
    final InputDecorations? inputDecorations = themeData.extension<InputDecorations>();
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
                decoration: inputDecorations?.keypad,
                keyboardType: TextInputType.none,
                style: themeData.textTheme.headlineLarge,
                textAlign: TextAlign.center,
                showCursor: true,
              ),
            ),
          ),
        ),
        Keypad(
          onKeypadPressed: _onKeypadPressed,
        ),
        SizedBox(
          height: scaledInset,
        ),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (BuildContext context, TextEditingValue value, Widget? child) {
            return BlocBuilder<KeypadCubit, KeypadState>(
              builder: (context, state) {
                return BlocBuilder<CallBloc, CallState>(
                  buildWhen: (previous, current) =>
                      previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
                  builder: (context, callState) {
                    return Actionpad(
                      video: state.video,
                      transfer: callState.isBlingTransferInitiated,
                      onCallPressed: value.text.isEmpty ? null : () => _onCallPressed(state.video),
                      onCallLongPress: _onCallLongPress,
                      onTransferPressed: _onTransferPressed,
                      onBackspacePressed: value.text.isEmpty ? null : _onBackspacePressed,
                      onBackspaceLongPress: value.text.isEmpty ? null : _onBackspaceLongPress,
                    );
                  },
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

  String _popNumber() {
    final number = _controller.text;
    _controller.clear();
    return number;
  }

  void _onCallPressed(bool video) {
    _focusNode.unfocus();

    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(
      number: _popNumber(),
      video: video,
    ));
  }

  void _onCallLongPress() {
    context.read<KeypadCubit>().callTypeSwitch();
  }

  void _onTransferPressed() {
    _focusNode.unfocus();

    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.blindTransferred(
      number: _popNumber(),
    ));
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
      if (textBefore.isNotEmpty) {
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
      newSelection = const TextSelection.collapsed(offset: 0);
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
