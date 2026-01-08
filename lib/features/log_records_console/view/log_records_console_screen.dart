import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class LogRecordsConsoleScreen extends StatelessWidget {
  const LogRecordsConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.logRecordsConsole_AppBarTitle),
        actions: [
          BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.delete_outline),
                style: IconButton.styleFrom(foregroundColor: colorScheme.onSurface),
                onPressed: switch (state) {
                  LogRecordsConsoleStateSuccess() => () {
                    context.read<LogRecordsConsoleCubit>().clear();
                  },
                  _ => null,
                },
              );
            },
          ),
          BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.share),
                style: IconButton.styleFrom(foregroundColor: colorScheme.onSurface),
                onPressed: switch (state) {
                  LogRecordsConsoleStateSuccess(:final logRecords) when logRecords.isNotEmpty => () {
                    context.read<LogRecordsConsoleCubit>().share();
                  },
                  _ => null,
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
        builder: (context, state) {
          switch (state) {
            case LogRecordsConsoleStateSuccess(:final logRecords):
              return ListView.separated(
                itemBuilder: (context, index) {
                  final logRecord = logRecords[index];
                  return Text(logRecord, maxLines: 100);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.logRecords.length,
              );
            case LogRecordsConsoleStateFailure():
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.l10n.logRecordsConsole_Text_failure),
                    OutlinedButton(
                      onPressed: () {
                        context.read<LogRecordsConsoleCubit>().load();
                      },
                      child: Text(context.l10n.logRecordsConsole_Button_failureRefresh),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
