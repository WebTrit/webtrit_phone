import 'dart:async';

import 'package:webtrit_phone/models/call_pull_dialog.dart';

abstract class CallPullDialogRepository {
  CallPullDialogRepository();

  List<CallPullDialog> get dialogs;
  Stream<List<CallPullDialog>> get dialogsStream;
  Stream<List<CallPullDialog>> get dialogsStreamWithValue;

  void setDialogs(List<CallPullDialog> dialogs);
}

class CallPullDialogRepositoryMemoryImpl implements CallPullDialogRepository {
  CallPullDialogRepositoryMemoryImpl();
  final _dialogs = <CallPullDialog>[];
  final _dialogsController = StreamController<List<CallPullDialog>>.broadcast();

  @override
  List<CallPullDialog> get dialogs => _dialogs;
  @override
  Stream<List<CallPullDialog>> get dialogsStream => _dialogsController.stream;
  @override
  Stream<List<CallPullDialog>> get dialogsStreamWithValue async* {
    yield _dialogs;
    yield* dialogsStream;
  }

  @override
  void setDialogs(List<CallPullDialog> dialogs) {
    _dialogs.clear();
    _dialogs.addAll(dialogs);
    _dialogsController.add(_dialogs);
  }
}
