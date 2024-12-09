import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import '../call_codecs.dart';

@RoutePage()
class CallCodecsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallCodecsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallCodecsCubit(context.read<AppPreferences>()),
      child: const CallCodecsScreen(),
    );
  }
}
