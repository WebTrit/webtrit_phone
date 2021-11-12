import 'dart:io';

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

  void clear() async {
    emit(const LogRecordsConsoleState.loading());
    logRecordsRepository.clear();
    emit(const LogRecordsConsoleState.success([]));
  }

  void share() async {
    final logRecords = state.logRecords;

    final time = logRecords[0].time;
    final timeSlug =
        '${time.year.toString()}${time.month.toString().padLeft(2, '0')}${time.day.toString().padLeft(2, '0')}'
        '${time.hour.toString()}${time.minute.toString().padLeft(2, '0')}${time.second.toString().padLeft(2, '0')}';
    final name = '${PackageInfo().appName}_${DeviceInfo().identifierForVendor}_$timeSlug';

    final logRecordsPath = AppPath().logRecordsPath(name);
    final logRecordsFile = File(logRecordsPath);
    final logRecordsSink = logRecordsFile.openWrite();
    for (final logRecord in logRecords) {
      logRecordsSink.writeln(logRecordsFormatter.format(logRecord));
    }
    await logRecordsSink.close();

    await Share.shareFiles([logRecordsPath]);

    await logRecordsFile.delete();
  }
}
