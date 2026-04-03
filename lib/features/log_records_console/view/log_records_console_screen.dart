import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
                  LogRecordsConsoleStateSuccess(isSharing: false) => () {
                    context.read<LogRecordsConsoleCubit>().clear();
                  },
                  _ => null,
                },
              );
            },
          ),
          BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
            builder: (context, state) {
              final isSharing = state is LogRecordsConsoleStateSuccess && state.isSharing;
              return IconButton(
                icon: isSharing
                    ? SizedCircularProgressIndicator(
                        size: 20,
                        outerSize: 24,
                        color: colorScheme.onSurface,
                        strokeWidth: 2,
                      )
                    : const Icon(Icons.share),
                style: IconButton.styleFrom(foregroundColor: colorScheme.onSurface),
                onPressed: switch (state) {
                  LogRecordsConsoleStateSuccess(:final logRecords, isSharing: false) when logRecords.isNotEmpty => () {
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
              if (logRecords.isEmpty) return const SizedBox.shrink();
              return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        context.l10n.logRecordsConsole_Text_recordsCountHint(logRecords.length),
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    );
                  }
                  return Text(logRecords[index - 1], maxLines: 100);
                },
                separatorBuilder: (context, index) => index == 0 ? const SizedBox.shrink() : const Divider(),
                itemCount: logRecords.length + 1,
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
