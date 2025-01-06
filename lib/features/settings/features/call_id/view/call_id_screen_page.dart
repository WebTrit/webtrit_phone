import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/account/user_repository.dart';

import '../call_id.dart';

@RoutePage()
class CallIdScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallIdScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallIdCubit(
        context.read<UserRepository>(),
        context.read<AppPreferences>(),
      ),
      child: const CallIdScreen(),
    );
  }
}
