import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import '../encoding.dart';

@RoutePage()
class EncodingSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EncodingSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EncodingSettingsCubit(context.read<AppPreferences>()),
      child: const EncodingSettingsScreen(),
    );
  }
}
