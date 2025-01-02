import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView(this.url, this.title, {super.key});
  final Uri url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewScaffold(
        title: Text(title),
        initialUri: url,
      ),
    );
  }
}
