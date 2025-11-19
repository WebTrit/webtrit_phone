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
    final appMetadataProvider = context.read<AppMetadataProvider>();

    if (appAboutUrl != null) {
      final widget = WebAboutScreen(
        baseAppAboutUrl: Uri.parse(appAboutUrl),
        userAgent: appMetadataProvider.userAgent,
        packageInfo: context.read<PackageInfo>(),
        infoRepository: context.read<SystemInfoRemoteRepository>(),
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
            infoRepository: context.read<SystemInfoRemoteRepository>(),
            appMetadataProvider: appMetadataProvider,
          )..add(const AboutStarted());
        },
        child: widget,
      );
      return provider;
    }
  }
}
