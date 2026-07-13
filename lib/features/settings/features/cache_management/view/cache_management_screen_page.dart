import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';

import 'cache_management_screen.dart';

@RoutePage()
class CacheManagementScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CacheManagementScreenPage();

  @override
  Widget build(BuildContext context) {
    return CacheManagementScreen(sections: context.read<AppCacheManager>().sections);
  }
}
