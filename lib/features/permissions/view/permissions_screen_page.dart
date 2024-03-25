import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class PermissionsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const PermissionsScreenPage();

  @override
  Widget build(BuildContext context) {
    const appTermsAndConditionsUrl = EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL;

    const widget = PermissionsScreen(appTermsAndConditionsUrl: appTermsAndConditionsUrl ?? '');
    final provider = BlocProvider(
      create: (context) => PermissionsCubit(
        appPermissions: context.read<AppPermissions>(),
        appPreferences: context.read<AppPreferences>(),
      ),
      child: widget,
    );
    return provider;
  }
}
