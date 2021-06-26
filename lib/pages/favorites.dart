import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_outline,
              size: 80,
              color: themeData.textTheme.caption!.color,
            ),
            SizedBox(height: 10),
            Text(
              'There is no any favorite numbers',
              style: themeData.textTheme.subtitle1,
            ),
            SizedBox(height: 10),
            TextButton(
              child: Text('Add new favorite'.toUpperCase()),
              onPressed: () {
                context.showSnackBar('Sorry, not implemented yet');
              },
            )
          ],
        ),
      ),
    );
  }
}
