import 'package:flutter/material.dart';

class GroupTitleListTile extends StatelessWidget {
  const GroupTitleListTile({
    Key? key,
    required this.titleData,
  }) : super(key: key);

  final String titleData;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      title: Text(
        titleData,
        style: themeData.textTheme.bodyMedium,
      ),
      tileColor: themeData.colorScheme.surface,
    );
  }
}
