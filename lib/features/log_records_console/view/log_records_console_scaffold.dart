import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LogRecordsConsoleScaffold extends StatelessWidget {
  const LogRecordsConsoleScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: const Text('Log Console'),
        actions: [
          BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                return IconButton(
                  icon: const Icon(
                    Icons.share,
                  ),
                  onPressed: state.logRecords.isEmpty
                      ? null
                      : () async {
                          context.read<LogRecordsConsoleCubit>().share();
                        },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<LogRecordsConsoleCubit, LogRecordsConsoleState>(
        builder: (context, state) {
          switch (state.status) {
            case LogRecordsConsoleStatus.success:
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final logRecord = state.logRecords[index];
                      return Text(
                        context.read<LogRecordsConsoleCubit>().logRecordsFormatter.format(logRecord),
                        maxLines: 100,
                      );
                    },
                    itemCount: state.logRecords.length,
                  ),
                ),
              );
            case LogRecordsConsoleStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Ups error happened ☹️'),
                    OutlineButton(
                      onPressed: () => context.read<LogRecordsConsoleCubit>().load(),
                      child: const Text('Refresh'),
                    )
                  ],
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
