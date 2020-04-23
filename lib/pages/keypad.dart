import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';

class KeypadPage extends StatefulWidget {
  const KeypadPage({Key key}) : super(key: key);

  @override
  _KeypadPageState createState() => _KeypadPageState();
}

class _KeypadPageState extends State<KeypadPage> {
  final _keypadTextFieldKey = GlobalKey();
  final _focusNode = PreventKeyboardFocusNode();

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaledInset = MediaQuery.of(context).size.height > 800 ? 20.0 : 10.0;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: scaledInset),
                child: TextField(
                  key: _keypadTextFieldKey,
                  controller: _controller,
                  focusNode: _focusNode,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                  showCursor: true,
                ),
              ),
            ),
          ),
          _Keypad(
            onKeypadPressed: _onKeypadPressed,
            keyPadding: EdgeInsets.all(scaledInset),
          ),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (BuildContext context, TextEditingValue value, Widget child) {
              return _Actionpad(
                onCallPressed: _onCallPressed,
                onBackspacePressed: value.text.isNotEmpty ? _onBackspacePressed : null,
                onBackspaceLongPress: value.text.isNotEmpty ? _onBackspaceLongPress : null,
                actionPadding: EdgeInsets.all(scaledInset),
              );
            },
          ),
          SizedBox(
            height: scaledInset,
          ),
        ],
      ),
    );
  }

  void _onCallPressed() {
    _focusNode.unfocus();

    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Sorry, not implemented yet'),
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
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );

    _keypadTextFieldHideToolbar();
  }

  void _onBackspacePressed() {
    if (!_controller.selection.isValid) {
      _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
    }

    final textBefore = _controller.selection.textBefore(_controller.text);
    final textAfter = _controller.selection.textAfter(_controller.text);

    String newText;
    TextSelection newSelection;
    if (_controller.selection.isCollapsed) {
      if (textBefore.length > 0) {
        newText = textBefore.substring(0, textBefore.length - 1) + textAfter;
        newSelection = TextSelection.collapsed(offset: _controller.selection.start - 1);
      }
    } else {
      newText = textBefore + textAfter;
      newSelection = TextSelection.collapsed(offset: _controller.selection.start);
    }
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );

    _keypadTextFieldHideToolbar();
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
    _controller.value = _controller.value.copyWith(
      text: newText,
      selection: newSelection,
    );

    _keypadTextFieldHideToolbar();
  }

  void _keypadTextFieldHideToolbar() {
    final delegate = _keypadTextFieldKey.currentState as TextSelectionGestureDetectorBuilderDelegate;
    delegate.editableTextKey.currentState.hideToolbar();
  }
}

class _Key {
  const _Key(
    this.text,
    this.subtext,
  )   : assert(text != null),
        assert(subtext != null);

  final String text;
  final String subtext;
}

class _Keypad extends StatelessWidget {
  final void Function(String) onKeypadPressed;
  final EdgeInsetsGeometry keyPadding;

  const _Keypad({
    Key key,
    this.onKeypadPressed,
    this.keyPadding,
  }) : super(key: key);

  static const List<_Key> _keys = [
    _Key('1', ''),
    _Key('2', 'A B C'),
    _Key('3', 'D E F'),
    _Key('4', 'G H I'),
    _Key('5', 'J K L'),
    _Key('6', 'M N O'),
    _Key('7', 'P Q R S'),
    _Key('8', 'T U V'),
    _Key('9', 'W X Y Z'),
    _Key('*', ''),
    _Key('0', '+'),
    _Key('#', ''),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> keyButtons = [];
    for (int i = 0; i < _keys.length; i++) {
      final key = _keys[i];
      keyButtons.add(
        Center(
          child: FlatButton(
            onPressed: () {
              onKeypadPressed(key.text);
            },
            padding: keyPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  key.text,
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  key.subtext,
                ),
              ],
            ),
          ),
        ),
      );
    }

    const keyButtonsInTableRowCount = 3;
    List<TableRow> tableRows = [];
    for (int r = 0; r < keyButtons.length / keyButtonsInTableRowCount; r++) {
      List<Widget> keyButtonsInTableRow = [];
      for (int i = 0; i < keyButtonsInTableRowCount; i++) {
        keyButtonsInTableRow.add(keyButtons[r * keyButtonsInTableRowCount + i]);
      }
      tableRows.add(TableRow(
        children: keyButtonsInTableRow,
      ));
    }

    return ButtonTheme(
      shape: CircleBorder(),
      child: Table(
        children: tableRows,
      ),
    );
  }
}

class _Actionpad extends StatelessWidget {
  final VoidCallback onCallPressed;
  final VoidCallback onCallLongPress;
  final VoidCallback onBackspacePressed;
  final VoidCallback onBackspaceLongPress;
  final EdgeInsetsGeometry actionPadding;

  const _Actionpad({
    Key key,
    this.onCallPressed,
    this.onCallLongPress,
    this.onBackspacePressed,
    this.onBackspaceLongPress,
    this.actionPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: CircleBorder(),
      child: Table(
        children: [
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: FlatButton(
                    onPressed: onCallPressed,
                    onLongPress: onCallLongPress,
                    splashColor: Theme.of(context).primaryColor,
                    padding: actionPadding,
                    child: Icon(
                      Icons.phone,
                      size: Theme.of(context).textTheme.display3.fontSize,
                    ),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: FlatButton(
                    onPressed: onBackspacePressed,
                    onLongPress: onBackspaceLongPress,
                    padding: actionPadding,
                    child: Icon(
                      Icons.backspace,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
