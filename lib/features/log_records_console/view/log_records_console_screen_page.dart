import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class LogRecordsConsoleScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LogRecordsConsoleScreenPage();

  @override
  Widget build(BuildContext context) {
    final appTime = context.read<AppTime>();
    final appMetadataProvider = context.read<AppMetadataProvider>();

    final provider = BlocProvider(
      create: (context) => LogRecordsConsoleCubit(
        logRecordsRepository: context.read<LogRecordsRepository>(),
        packageInfo: context.read<PackageInfo>(),
        appInfo: context.read<AppInfo>(),
        dateFormat: appTime.fileNameDateFormat,
        exportFilenamePrefix: appMetadataProvider.exportFilenamePrefix,
      )..load(),
      child: LogRecordsConsoleScreen(),
    );
    return provider;
  }
}
