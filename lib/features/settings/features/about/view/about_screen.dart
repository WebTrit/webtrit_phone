import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarTitle = Text(context.l10n.settings_ListViewTileTitle_about);

    final appName = PackageInfo().appName;
    final packageName = PackageInfo().packageName;
    final version = PackageInfo().version;
    final buildNumber = PackageInfo().buildNumber;
    final coreUrl = context.read<AppBloc>().state.coreUrl!;
    if (EnvironmentConfig.APP_ABOUT_URL.isNotEmpty) {
      return WebViewScaffold(
        title: appBarTitle,
        initialUri: Uri.parse(EnvironmentConfig.APP_ABOUT_URL).replace(queryParameters: {
          'appName': appName,
          'packageName': packageName,
          'version': version,
          'buildNumber': buildNumber,
          'coreUrl': coreUrl,
        }),
      );
    } else {
      final themeData = Theme.of(context);
      return Scaffold(
        appBar: AppBar(
          title: appBarTitle,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.logo.svg(
                height: themeData.textTheme.displayLarge!.fontSize! * 1.5,
              ),
              Text(
                appName,
                style: themeData.textTheme.displaySmall,
              ),
              Text(packageName),
              SizedBox(
                height: themeData.textTheme.titleLarge!.fontSize!,
              ),
              Text(
                '$version-$buildNumber',
                style: themeData.textTheme.titleLarge,
              ),
              SizedBox(
                height: themeData.textTheme.titleLarge!.fontSize!,
              ),
              Text(coreUrl),
            ],
          ),
        ),
      );
    }
  }
}
