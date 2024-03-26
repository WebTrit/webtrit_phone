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
    return Container(color:Color(0xff14284b),child: ListTile(
      title: Text(
        titleData,
        style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      tileColor: themeData.colorScheme.surface,
    ),);
  }
}
