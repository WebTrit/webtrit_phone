import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CallHistoryRecorder');

class CallHistoryRecorder {
  CallHistoryRecorder({required CallLogsRepository repository}) : _repository = repository;

  final CallLogsRepository _repository;

  void record(NewCall call) {
    _logger.info(
      '[Recents:store] '
      'direction=${call.direction.name} '
      'number.hash=${call.number.hashCode} '
      'username.hash=${call.username?.hashCode} '
      'numberEqualsUsername=${call.number == call.username} '
      'usernameIsNull=${call.username == null}',
    );
    unawaited(_repository.add(call).catchError((e, s) => _logger.severe('Failed to record call history', e, s)));
  }
}
