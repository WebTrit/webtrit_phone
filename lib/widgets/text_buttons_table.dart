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
  }) : assert(children.length % keyButtonsInTableRowCount == 0);

  final List<Widget> children;

  @Deprecated('Use style.minimumSize instead')
  final Size? minimumSize;

  final int keyButtonsInTableRowCount;

  final TextButtonsTableStyle? style;

  @override
  Widget build(BuildContext context) {
    final themed = Theme.of(context).extension<TextButtonsTableStyles>()?.primary;
    final merged = TextButtonsTableStyle.merge(themed, style);

    final tableRows = <TableRow>[];
    for (int r = 0; r < children.length / keyButtonsInTableRowCount; r++) {
      final rowChildren = <Widget>[];
      for (int i = 0; i < keyButtonsInTableRowCount; i++) {
        rowChildren.add(Center(
          child: Padding(
            padding: merged.spacing ?? EdgeInsets.zero,
            child: children[r * keyButtonsInTableRowCount + i],
          ),
        ));
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
      child: Table(children: tableRows),
    );
  }
}
