import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LogRecordsConsoleScreen extends StatelessWidget {
  const LogRecordsConsoleScreen({super.key});

  void _onMenuSelected(BuildContext context, _LogConsoleMenuAction action, LogRecordsConsoleStateSuccess state) {
    switch (action) {
      case _LogConsoleMenuAction.info:
        _showInfoDialog(context, state.logRecords.length);
      case _LogConsoleMenuAction.clear:
        context.read<LogRecordsConsoleCubit>().clear();
    }
  }

  void _showInfoDialog(BuildContext context, int count) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(context.l10n.logRecordsConsole_Text_recordsCountHint(count)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.l10n.logRecordsConsole_Button_infoClose),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.logRecordsConsole_AppBarTitle),
        actions: [
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
          BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
            builder: (context, state) {
              final canInteract = state is LogRecordsConsoleStateSuccess && !state.isSharing;
              final hasRecords = state is LogRecordsConsoleStateSuccess && state.logRecords.isNotEmpty;
              return PopupMenuButton<_LogConsoleMenuAction>(
                icon: const Icon(Icons.more_vert),
                iconColor: colorScheme.onSurface,
                position: PopupMenuPosition.under,
                enabled: canInteract,
                onSelected: (action) => _onMenuSelected(context, action, state as LogRecordsConsoleStateSuccess),
                itemBuilder: (context) => [
                  if (hasRecords)
                    PopupMenuItem(
                      value: _LogConsoleMenuAction.info,
                      child: Text(context.l10n.logRecordsConsole_PopupMenuItem_info),
                    ),
                  PopupMenuItem(
                    value: _LogConsoleMenuAction.clear,
                    child: Text(context.l10n.logRecordsConsole_PopupMenuItem_clear),
                  ),
                ],
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
                itemBuilder: (context, index) => Text(logRecords[index], maxLines: 100),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: logRecords.length,
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

enum _LogConsoleMenuAction { info, clear }
