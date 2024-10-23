import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

import '../bloc/network_cubit.dart';

@RoutePage()
class NetworkScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NetworkScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = NetworkScreen();
    return BlocProvider(
      create: (context) => NetworkCubit(
        context.read<AppPreferences>(),
        CallkeepBackgroundService(),
      ),
      child: widget,
    );
  }
}
