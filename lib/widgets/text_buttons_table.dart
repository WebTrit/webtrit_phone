import 'package:flutter/material.dart';

import 'text_buttons_table_style.dart';
import 'text_buttons_table_styles.dart';

export 'text_buttons_table_style.dart';
export 'text_buttons_table_styles.dart';

class TextButtonsTable extends StatelessWidget {
  const TextButtonsTable({
    super.key,
    this.minimumSize,
    this.keyButtonsInTableRowCount = 3,
    this.style,
    required this.children,
    this.defaultVerticalAlignment = TableCellVerticalAlignment.top,
  }) : assert(children.length % keyButtonsInTableRowCount == 0);

  /// The list of widgets to display as buttons in the table.
  final List<Widget> children;

  /// The minimum size of the buttons in the table.
  /// This parameter is deprecated, use [style.minimumSize] instead.
  @Deprecated('Use style.minimumSize instead')
  final Size? minimumSize;

  /// The number of buttons to display in each row of the table.
  final int keyButtonsInTableRowCount;

  /// The default vertical alignment of the table cells.
  final TableCellVerticalAlignment defaultVerticalAlignment;

  /// The style to apply to the text buttons table.
  final TextButtonsTableStyle? style;

  @override
  Widget build(BuildContext context) {
    final themed = Theme.of(context).extension<TextButtonsTableStyles>()?.primary;
    final merged = TextButtonsTableStyle.merge(themed, style);

    final tableRows = <TableRow>[];
    for (int r = 0; r < children.length / keyButtonsInTableRowCount; r++) {
      final rowChildren = <Widget>[];
      for (int i = 0; i < keyButtonsInTableRowCount; i++) {
        rowChildren.add(
          Center(
            child: Padding(
              padding: merged.spacing ?? EdgeInsets.zero,
              child: children[r * keyButtonsInTableRowCount + i],
            ),
          ),
        );
      }
      tableRows.add(TableRow(children: rowChildren));
    }

    final textButtonThemeData = TextButtonTheme.of(context);
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          // ignore: deprecated_member_use_from_same_package
          minimumSize: minimumSize ?? merged.minimumSize,
        ).merge(merged.buttonStyle).merge(textButtonThemeData.style),
      ),
      child: Table(children: tableRows, defaultVerticalAlignment: defaultVerticalAlignment),
    );
  }
}
