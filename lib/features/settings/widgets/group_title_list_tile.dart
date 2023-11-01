import 'package:flutter/material.dart';

class GroupTitleListTile extends StatelessWidget {
  const GroupTitleListTile({
    super.key,
    required this.titleData,
  });

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
