import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import '../self_config.dart';

@RoutePage()
class SelfConfigScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SelfConfigScreenPage(this.url);

  final Uri url;

  @override
  Widget build(BuildContext context) {
    final appMetadataProvider = context.read<AppMetadataProvider>();

    return SelfConfigScreen(url, appMetadataProvider.userAgent);
  }
}
