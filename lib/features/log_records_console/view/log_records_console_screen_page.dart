import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class LogRecordsConsoleScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LogRecordsConsoleScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = LogRecordsConsoleScreen();
    final provider = BlocProvider(
      create: (context) => LogRecordsConsoleCubit(
        logRecordsRepository: context.read<LogRecordsRepository>(),
      )..load(),
      child: widget,
    );
    return provider;
  }
}
