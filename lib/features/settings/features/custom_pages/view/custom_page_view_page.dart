import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import '../custom_pages.dart';

@RoutePage()
class CustomPageViewPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomPageViewPage(this.url, this.title);
  final Uri url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomPageView(url, title);
  }
}
