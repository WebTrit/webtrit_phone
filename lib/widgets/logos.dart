import 'package:flutter/material.dart';

class WebTritPhoneTextLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          'WebTrit',
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Phone',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
