import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'log_records_console_state.dart';

class LogRecordsConsoleCubit extends Cubit<LogRecordsConsoleState> {
  LogRecordsConsoleCubit({
    required this.logRecordsRepository,
    this.logRecordsFormatter = const DefaultLogRecordFormatter(),
  }) : super(const LogRecordsConsoleState.initial());

  final LogRecordsRepository logRecordsRepository;
  final LogRecordFormatter logRecordsFormatter;

  void load() async {
    emit(const LogRecordsConsoleState.loading());
    try {
      final logRecords = await logRecordsRepository.getLogRecords();
      emit(LogRecordsConsoleState.success(logRecords));
    } catch (error) {
      emit(LogRecordsConsoleState.failure(error));
    }
  }

  void share() async {
    final logRecords = state.logRecords;

    if (logRecords.isEmpty) {
      return;
    }

    final sb = StringBuffer();
    for (final logRecord in logRecords) {
      logRecordsFormatter.formatToStringBuffer(logRecord, sb);
      sb.writeln();
    }

    await Share.share(sb.toString(), subject: '${PackageInfo().appName} Log Records ${logRecords[0].time}');
  }
}
