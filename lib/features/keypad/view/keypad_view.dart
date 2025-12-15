import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

class KeypadView extends StatefulWidget {
  const KeypadView({super.key, required this.videoEnabled, required this.transferEnabled, required this.style});

  final bool videoEnabled;
  final bool transferEnabled;
  final KeypadScreenStyle? style;

  @override
  KeypadViewState createState() => KeypadViewState();
}

class KeypadViewState extends State<KeypadView> {
  final _keypadTextFieldKey = GlobalKey();

  // TODO(Serdun): Think about moving this to a controller or bloc.
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );
  late TextEditingController _controller;
  late FocusNode _focusNode;

  EditableTextState? get _keypadTextFieldEditableTextState =>
      (_keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        if (_controller.text.isNotEmpty) context.read<KeypadCubit>().getContactByPhoneNumber(_controller.text);
      });
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

    final InputDecorations? baseInputDecorations = themeData.extension<InputDecorations>();

    final inputField = widget.style?.inputField;
    final contactField = widget.style?.contactNameField;
    final actionpadStyle = widget.style?.actionpadStyle;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: scaledInset),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    key: _keypadTextFieldKey,
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: inputField?.decoration ?? baseInputDecorations?.keypad,
                    style: inputField?.textStyle ?? themeData.textTheme.headlineLarge,
                    textAlign: inputField?.textAlign ?? TextAlign.center,
                    showCursor: inputField?.showCursor ?? true,
                    keyboardType: inputField?.keyboardType ?? TextInputType.none,
                    cursorColor: inputField?.cursorColor,
                  ),
                  BlocBuilder<KeypadCubit, KeypadState>(
                    builder: (context, state) => Text(
                      state.contact?.maybeName ?? '',
                      style: contactField?.textStyle ?? themeData.textTheme.bodyMedium,
                      textAlign: contactField?.textAlign ?? TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Keypad(onKeypadPressed: _addChar, style: widget.style?.keypadStyle),
        SizedBox(height: scaledInset),
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (BuildContext context, TextEditingValue value, Widget? child) {
            return BlocBuilder<CallBloc, CallState>(
              buildWhen: (previous, current) =>
                  previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
                  previous.activeCalls != current.activeCalls,
              builder: (context, callState) {
                final activeCalls = callState.activeCalls;
                final transferInitiated = callState.isBlingTransferInitiated;

                return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                  builder: (context, callRoutingState) {
                    bool canCall = value.text.isNotEmpty;

                    return Actionpad(
                      actionsEnabled: canCall,
                      onBackspacePressed: _removeLastChar,
                      onBackspaceLongPress: _cleanInput,
                      onAudioCallPressed: () => _callController.createCall(destination: _popNumber()),
                      onVideoCallPressed: widget.videoEnabled
                          ? () => _callController.createCall(destination: _popNumber(), video: true)
                          : null,
                      onTransferPressed: widget.transferEnabled && activeCalls.isNotEmpty ? _transferCall : null,
                      onInitiatedTransferPressed: widget.transferEnabled && transferInitiated ? _transferCall : null,
                      callNumbers: callRoutingState?.allNumbers ?? [],
                      onCallFrom: (number) => _callController.createCall(destination: _popNumber(), fromNumber: number),
                      style: actionpadStyle,
                    );
                  },
                );
              },
            );
          },
        ),
        SizedBox(height: scaledInset),
      ],
    );
  }

  String _popNumber() {
    final number = _controller.text;
    _controller.clear();
    return number;
  }

  void _transferCall() {
    _focusNode.unfocus();
    _callController.submitTransfer(_popNumber());
  }

  void _addChar(String keyText) {
    if (!_controller.selection.isValid) {
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }

    final textBefore = _controller.selection.textBefore(_controller.text);
    final textAfter = _controller.selection.textAfter(_controller.text);

    final newText = textBefore + keyText + textAfter;
    final newSelection = TextSelection.collapsed(offset: _controller.selection.start + 1);
    final value = _controller.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _removeLastChar() {
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
    final value = _controller.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _cleanInput() {
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
    final value = _controller.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }
}
