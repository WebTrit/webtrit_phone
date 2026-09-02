import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('VoicemailUnreadCubit');

/// How many voicemails are waiting, for whoever needs the number without the
/// list.
///
/// Session-scoped and deliberately thin. It watches what the repository
/// already keeps locally and holds nothing else: no loading status, no error,
/// no selection - those belong to a screen, and a number on a settings row or
/// a navigation entry is not one.
///
/// Fetching is not its job. The repository is registered for polling, whose
/// leading cycle refreshes it at the start of the session and every interval
/// after, and for refresh on connectivity recovery. A counter that fetched too
/// would duplicate both and have to own their failures.
///
/// Where voicemail is not available for the session the repository is the
/// empty one, whose count stream is a constant zero, so this needs no gate of
/// its own.
class VoicemailUnreadCubit extends Cubit<int> {
  VoicemailUnreadCubit({required VoicemailRepository repository}) : _repository = repository, super(0);

  final VoicemailRepository _repository;

  StreamSubscription<int>? _subscription;

  void init() {
    _logger.fine('Initializing');
    _subscription = _repository.watchUnreadVoicemailsCount().listen((count) {
      if (isClosed || state == count) return;
      emit(count);
    });
  }

  @override
  Future<void> close() {
    _logger.fine('Closing');
    _subscription?.cancel();
    return super.close();
  }
}
