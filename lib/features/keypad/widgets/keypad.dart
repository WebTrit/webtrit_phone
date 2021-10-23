import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  const Keypad({
    Key? key,
    required this.onKeypadPressed,
  }) : super(key: key);

  final void Function(String) onKeypadPressed;

  @override
  Widget build(BuildContext context) {
    var keyButtons = [
      _buildKeyButton(context, '1', ''),
      _buildKeyButton(context, '2', 'A B C'),
      _buildKeyButton(context, '3', 'D E F'),
      _buildKeyButton(context, '4', 'G H I'),
      _buildKeyButton(context, '5', 'J K L'),
      _buildKeyButton(context, '6', 'M N O'),
      _buildKeyButton(context, '7', 'P Q R S'),
      _buildKeyButton(context, '8', 'T U V'),
      _buildKeyButton(context, '9', 'W X Y Z'),
      _buildKeyButton(context, '*', ''),
      _buildKeyButton(context, '0', '+'),
      _buildKeyButton(context, '#', ''),
    ];

    const keyButtonsInTableRowCount = 3;
    List<TableRow> tableRows = [];
    for (int r = 0; r < keyButtons.length / keyButtonsInTableRowCount; r++) {
      List<Widget> keyButtonsInTableRow = [];
      for (int i = 0; i < keyButtonsInTableRowCount; i++) {
        keyButtonsInTableRow.add(Center(
          child: keyButtons[r * keyButtonsInTableRowCount + i],
        ));
      }
      tableRows.add(TableRow(
        children: keyButtonsInTableRow,
      ));
    }

    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size.square(MediaQuery.of(context).size.width / 5),
          shape: const CircleBorder(),
        ),
      ),
      child: Table(
        children: tableRows,
      ),
    );
  }

  Widget _buildKeyButton(BuildContext context, String text, String subtext) {
    return TextButton(
      onPressed: () => onKeypadPressed(text),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            subtext,
          ),
        ],
      ),
    );
  }
}
