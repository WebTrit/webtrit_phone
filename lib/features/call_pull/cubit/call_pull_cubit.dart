import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/call_pull_dialog_repository.dart';

class CallPullCubit extends Cubit<List<CallPullDialog>> {
  CallPullCubit(this._callPullDialogRepository) : super([]) {
    _dialogsSub = _callPullDialogRepository.dialogsStreamWithValue.listen(handleDialogs);
  }

  void handleDialogs(dialogs) {
    emit(List.unmodifiable(dialogs));
  }

  final CallPullDialogRepository _callPullDialogRepository;
  late final StreamSubscription _dialogsSub;

  @override
  Future<void> close() {
    _dialogsSub.cancel();
    return super.close();
  }
}
