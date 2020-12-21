import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/app_bar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Icon(
          Icons.star_outline,
          size: 120,
        ),
      ),
    );
  }
}
