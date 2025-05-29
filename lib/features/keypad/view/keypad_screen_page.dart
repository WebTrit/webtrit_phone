import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class KeypadScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const KeypadScreenPage();

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = KeypadScreen(
      title: const Text(EnvironmentConfig.APP_NAME),
      videoVisible: featureAccess.callFeature.callConfig.isVideoCallEnabled,
    );
    final provider = BlocProvider(
      create: (context) => KeypadCubit(
        context.read<ContactsRepository>(),
      ),
      child: widget,
    );
    return provider;
  }
}
