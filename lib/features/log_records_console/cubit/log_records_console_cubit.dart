import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../utils/utils.dart';

part 'log_records_console_state.dart';

class LogRecordsConsoleCubit extends Cubit<LogRecordsConsoleState> {
  LogRecordsConsoleCubit({
    required this.logRecordsRepository,
    required this.packageInfo,
    required this.appInfo,
    required this.dateFormat,
    required this.exportFilenamePrefix,
  }) : super(const LogRecordsConsoleStateInitial());

  final LogRecordsRepository logRecordsRepository;
  final PackageInfo packageInfo;
  final AppInfo appInfo;
  final DateFormat dateFormat;
  final String exportFilenamePrefix;

  void load() async {
    emit(const LogRecordsConsoleStateLoading());
    try {
      final logRecords = await logRecordsRepository.getLogRecords();
      emit(LogRecordsConsoleStateSuccess(logRecords));
    } catch (error) {
      emit(LogRecordsConsoleStateFailure(error));
    }
  }

  void clear() async {
    emit(const LogRecordsConsoleStateLoading());
    logRecordsRepository.clear();
    emit(const LogRecordsConsoleStateSuccess([]));
  }

  Future<void> share() async {
    final state = this.state as LogRecordsConsoleStateSuccess;

    final logRecords = state.logRecords;

    final time = DateTime.now();
    final name = '$exportFilenamePrefix(${dateFormat.format(time)}).log';

    await shareLogRecords(logRecords, name: name);
  }
}
