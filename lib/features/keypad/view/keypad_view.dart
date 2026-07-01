import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/debounce.dart';

import '../cubit/keypad_cubit.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'keypad_screen_style.dart';

// NOTES:
// - do not use ValueListenableBuilder to watch number change because of huge perfomance impact on low-end devices

class KeypadView extends StatefulWidget {
  const KeypadView({super.key, required this.videoEnabled, required this.transferEnabled, required this.style});

  final bool videoEnabled;
  final bool transferEnabled;
  final KeypadScreenStyle? style;

  @override
  KeypadViewState createState() => KeypadViewState();
}

class KeypadViewState extends State<KeypadView> {
  late final _callController = CallControllerScope.of(context);
  late final _keypadCubit = context.read<KeypadCubit>();
  // Seed the field from the cubit's initial value so the displayed number stays derivable from
  // state (empty in production; lets screenshot mocks and tests pre-fill a dialed number).
  late final _textController = TextEditingController(text: _keypadCubit.state.value ?? '');
  late final _focusNode = FocusNode();
  late final _setValueDebounce = Debounce(Duration(milliseconds: 128));

  final _keypadTextFieldKey = GlobalKey();
  EditableTextState? get _keypadTextFieldEditableTextState {
    // Guard the cast: currentState is null while the field is detached/rebuilt under the key
    // (e.g. a theme swap reparenting the subtree in the same frame). A hard cast would throw a
    // _TypeError there; return null instead so `?.showToolbar()` skips gracefully.
    final delegate = _keypadTextFieldKey.currentState;
    if (delegate is! TextSelectionGestureDetectorBuilderDelegate) return null;
    // The `is` guard covers both null and wrong-type; promotion does not apply here because the
    // delegate mixin is not a subtype of State, so an explicit (now safe) cast is still needed.
    return (delegate as TextSelectionGestureDetectorBuilderDelegate).editableTextKey.currentState;
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      // deffer value set, let app concentrate on gesture handling on low-end devices
      _setValueDebounce.schedule(() {
        if (mounted) _keypadCubit.setValue(_textController.text);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
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
          // The input is intentionally invisible (blends with the background), so its own hit
          // target is a tiny box in the center. Catch long-presses across the whole upper region
          // and surface the input's context menu (paste/copy) from anywhere on the background.
          // Translucent (not opaque) so pointers still reach the field's own gesture handlers
          // instead of being fully absorbed by this background detector.
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onLongPress: _showInputContextMenu,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: scaledInset),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    key: _keypadTextFieldKey,
                    controller: _textController,
                    focusNode: _focusNode,
                    decoration: inputField?.decoration ?? baseInputDecorations?.keypad,
                    style: inputField?.textStyle ?? themeData.textTheme.headlineLarge,
                    textAlign: inputField?.textAlign ?? TextAlign.center,
                    showCursor: inputField?.showCursor ?? true,
                    keyboardType: inputField?.keyboardType ?? TextInputType.none,
                    cursorColor: inputField?.cursorColor,
                    inputFormatters: [PhoneNormalizingFormatter()],
                  ),
                  RepaintBoundary(
                    child: BlocBuilder<KeypadCubit, KeypadState>(
                      buildWhen: (p, c) {
                        final pName = p.contact?.maybeName ?? '';
                        final cName = c.contact?.maybeName ?? '';
                        return pName != cName;
                      },
                      builder: (context, state) => Text(
                        state.contact?.maybeName ?? '',
                        style: contactField?.textStyle ?? themeData.textTheme.bodyMedium,
                        textAlign: contactField?.textAlign ?? TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        RepaintBoundary(
          child: Keypad(onKeypadPressed: _addChar, style: widget.style?.keypadStyle),
        ),
        SizedBox(height: scaledInset),
        RepaintBoundary(
          child: BlocBuilder<KeypadCubit, KeypadState>(
            buildWhen: (p, c) {
              return p.noValue != c.noValue;
            },
            builder: (context, keypadState) {
              return BlocBuilder<CallBloc, CallState>(
                buildWhen: (p, c) =>
                    p.isBlingTransferInitiated != c.isBlingTransferInitiated || p.activeCalls != c.activeCalls,
                builder: (context, callState) {
                  final activeCalls = callState.activeCalls;
                  final transferInitiated = callState.isBlingTransferInitiated;

                  return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                    builder: (context, callRoutingState) {
                      bool canCall = keypadState.noValue == false;

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
                        onCallFrom: (number) =>
                            _callController.createCall(destination: _popNumber(), fromNumber: number),
                        style: actionpadStyle,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: scaledInset),
      ],
    );
  }

  Future<void> _showInputContextMenu() async {
    // Decide whether there is anything to show BEFORE taking focus. The keypad input is
    // paste-oriented: an empty field has nothing selected to copy, so the toolbar is only
    // meaningful when the clipboard holds text. Guarding first also avoids focusing the hidden
    // input on a long-press that would surface nothing (which would leave a stray blinking
    // cursor and shift caret/toolbar timing for later key presses).
    final hasSelection = !_textController.selection.isCollapsed;
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final hasPasteableText = (clipboard?.text ?? '').isNotEmpty;
    if (!mounted || (!hasSelection && !hasPasteableText)) return;

    _focusNode.requestFocus();
    // Defer so the just-requested focus / input connection is established before showToolbar(),
    // which is a no-op on an unfocused/unconnected field.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_textController.selection.isValid) {
        _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
      }
      _keypadTextFieldEditableTextState?.showToolbar();
    });
  }

  String _popNumber() {
    final number = PhoneNormalizingFormatter.sanitize(_textController.text);
    _textController.clear();
    _keypadCubit.setValue('');
    return number;
  }

  void _transferCall() {
    _focusNode.unfocus();
    _callController.submitTransfer(_popNumber());
  }

  void _addChar(String keyText) {
    if (!_textController.selection.isValid) {
      _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
    }

    final textBefore = _textController.selection.textBefore(_textController.text);
    final textAfter = _textController.selection.textAfter(_textController.text);

    final newText = textBefore + keyText + textAfter;
    final newSelection = TextSelection.collapsed(offset: _textController.selection.start + 1);
    final value = _textController.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _removeLastChar() {
    if (!_textController.selection.isValid) {
      _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
    }

    final textBefore = _textController.selection.textBefore(_textController.text);
    final textAfter = _textController.selection.textAfter(_textController.text);

    String? newText;
    TextSelection? newSelection;
    if (_textController.selection.isCollapsed) {
      if (textBefore.isNotEmpty) {
        newText = textBefore.substring(0, textBefore.length - 1) + textAfter;
        newSelection = TextSelection.collapsed(offset: _textController.selection.start - 1);
      }
    } else {
      newText = textBefore + textAfter;
      newSelection = TextSelection.collapsed(offset: _textController.selection.start);
    }
    final value = _textController.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }

  void _cleanInput() {
    if (!_textController.selection.isValid) {
      _textController.selection = TextSelection.collapsed(offset: _textController.text.length);
    }

    final textBefore = _textController.selection.textBefore(_textController.text);
    final textAfter = _textController.selection.textAfter(_textController.text);

    String newText;
    TextSelection newSelection;
    if (_textController.selection.isCollapsed) {
      newText = textAfter;
      newSelection = const TextSelection.collapsed(offset: 0);
    } else {
      newText = textBefore + textAfter;
      newSelection = TextSelection.collapsed(offset: _textController.selection.start);
    }
    final value = _textController.value.copyWith(text: newText, selection: newSelection);
    _keypadTextFieldEditableTextState?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    _keypadTextFieldEditableTextState?.hideToolbar();
  }
}
