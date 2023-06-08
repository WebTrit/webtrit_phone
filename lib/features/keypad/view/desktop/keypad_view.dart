import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../../keypad.dart';

class KeypadView extends StatefulWidget {
  const KeypadView({Key? key}) : super(key: key);

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
    final themeData = Theme.of(context);

    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: TextField(
                      key: _keypadTextFieldKey,
                      controller: _controller,
                      showCursor: false,
                      decoration: InputDecoration(
                        labelText: context.l10n.keypad_Label_phoneNumber,
                        fillColor: Colors.transparent,
                        border: const UnderlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        isDense: true,
                        filled: true,
                      ),
                      maxLength: 64,
                    )),
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                          onPressed: _onAudioCallPressed,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(40, 40),
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            backgroundColor: themeData.colorScheme.tertiary,
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: _onVideoCallPressed,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(40, 40),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            backgroundColor: themeData.colorScheme.tertiary,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 32,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Expanded(
                      child: Keypad(
                        onKeypadPressed: _onKeypadPressed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 16),
          ),
        )
      ],
    );
  }

  void _onAudioCallPressed() {
    _focusNode.unfocus();
    context.read<KeypadCubit>().callTypeAudio();
  }

  void _onVideoCallPressed() {
    _focusNode.unfocus();
    context.read<KeypadCubit>().callTypeVideo();
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
}
