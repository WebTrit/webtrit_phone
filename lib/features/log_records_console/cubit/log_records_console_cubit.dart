import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../utils/utils.dart';

part 'log_records_console_cubit.freezed.dart';

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

  String get _namePrefix => '${PackageInfo().appName}_${AppInfo().identifier}_';

  String _timeSlug(DateTime time) =>
      '${time.year.toString()}${time.month.toString().padLeft(2, '0')}${time.day.toString().padLeft(2, '0')}'
      '${time.hour.toString()}${time.minute.toString().padLeft(2, '0')}${time.second.toString().padLeft(2, '0')}';

  Future<void> share() async {
    final state = this.state as LogRecordsConsoleStateSuccess;

    final logRecords = state.logRecords;

    final time = logRecords[0].time;
    final name = '$_namePrefix${_timeSlug(time)}.log';

    await shareLogRecords(
      logRecords,
      logRecordsFormatter: logRecordsFormatter,
      name: name,
    );
  }
}
