import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

// TODO: l10n

class KeypadView extends StatefulWidget {
  const KeypadView({
    super.key,
    required this.videoEnabled,
    required this.transferEnabled,
  });

  final bool videoEnabled;
  final bool transferEnabled;

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
    _controller = TextEditingController()
      ..addListener(() {
        context.read<KeypadCubit>().getContactByPhoneNumber(_controller.text);
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
    final InputDecorations? inputDecorations = themeData.extension<InputDecorations>();
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
                    decoration: inputDecorations?.keypad,
                    keyboardType: TextInputType.none,
                    style: themeData.textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                    showCursor: true,
                  ),
                  BlocBuilder<KeypadCubit, KeypadState>(
                    builder: (context, state) => Text(
                      state.contact?.maybeName ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Keypad(onKeypadPressed: _addChar),
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
                      onAudioCallPressed: () => _createCall(),
                      onVideoCallPressed: widget.videoEnabled ? () => _createCall(video: true) : null,
                      onTransferPressed: widget.transferEnabled && activeCalls.isNotEmpty ? _transferCall : null,
                      onInitiatedTransferPressed: widget.transferEnabled && transferInitiated ? _transferCall : null,
                      callNumbers: callRoutingState?.allNumbers ?? [],
                      onCallFrom: (number) => _createCall(from: number),
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

  void _createCall({bool video = false, String? from}) {
    _focusNode.unfocus();

    final displayName = context.read<KeypadCubit>().state.contact?.maybeName;
    final callRoutingState = context.read<CallRoutingCubit>().state;
    final callBloc = context.read<CallBloc>();

    if (callRoutingState?.additionalNumbers.contains(from) ?? false) {
      callBloc.add(CallControlEvent.started(
        number: _popNumber(),
        video: video,
        displayName: displayName,
        fromNumber: from,
      ));
    } else {
      callBloc.add(CallControlEvent.started(
        number: _popNumber(),
        video: video,
        displayName: displayName,
      ));
    }
  }

  void _transferCall() {
    _focusNode.unfocus();

    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.blindTransferSubmitted(
      number: _popNumber(),
    ));
  }

  void _addChar(keyText) {
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
    final value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );
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
    final value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }
}
