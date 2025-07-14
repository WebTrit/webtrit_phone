import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class AboutScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AboutScreenPage();

  @override
  Widget build(BuildContext context) {
    const appAboutUrl = EnvironmentConfig.APP_ABOUT_URL;
    if (appAboutUrl != null) {
      final widget = WebAboutScreen(
        baseAppAboutUrl: Uri.parse(appAboutUrl),
        packageInfo: context.read<PackageInfo>(),
        infoRepository: context.read<SystemInfoRepository>(),
      );
      return widget;
    } else {
      const widget = AboutScreen();
      final provider = BlocProvider(
        create: (context) {
          return AboutBloc(
            notificationsBloc: context.read<NotificationsBloc>(),
            appInfo: AppInfo(),
            packageInfo: context.read<PackageInfo>(),
            secureStorage: context.read<SecureStorage>(),
            embeddedFeature: context.read<FeatureAccess>().embeddedFeature,
            infoRepository: context.read<SystemInfoRepository>(),
          )..add(const AboutStarted());
        },
        child: widget,
      );
      return provider;
    }
  }
}
