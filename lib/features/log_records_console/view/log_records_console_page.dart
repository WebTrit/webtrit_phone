import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import './log_records_console_scaffold.dart';

import '../log_records_console.dart';

class LogRecordsConsolePage extends StatelessWidget {
  const LogRecordsConsolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogRecordsConsoleCubit(
        logRecordsRepository: context.read<LogRecordsRepository>(),
      )..load(),
      child: const LogRecordsConsoleScaffold(),
    );
  }
}
