import 'package:flutter/material.dart';

class TextButtonsTable extends StatelessWidget {
  const TextButtonsTable({
    Key? key,
    this.minimumSize,
    this.keyButtonsInTableRowCount = 3,
    required this.children,
  })  : assert(children.length % keyButtonsInTableRowCount == 0),
        super(key: key);

  final List<Widget> children;
  final Size? minimumSize;
  final int keyButtonsInTableRowCount;

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];
    for (int r = 0; r < children.length / keyButtonsInTableRowCount; r++) {
      List<Widget> keyButtonsInTableRow = [];
      for (int i = 0; i < keyButtonsInTableRowCount; i++) {
        keyButtonsInTableRow.add(Center(
          child: children[r * keyButtonsInTableRowCount + i],
        ));
      }
      tableRows.add(TableRow(
        children: keyButtonsInTableRow,
      ));
    }

    final textButtonThemeData = TextButtonTheme.of(context);
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: minimumSize,
        ).merge(textButtonThemeData.style),
      ),
      child: Table(
        children: tableRows,
      ),
    );
  }
}
