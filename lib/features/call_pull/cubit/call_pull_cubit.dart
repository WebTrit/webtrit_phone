import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class CallPullCubit extends Cubit<List<PullableCall>> {
  CallPullCubit(this._callPullRepository) : super([]) {
    _dialogsSub = _callPullRepository.pullableCallsStreamWithValue.listen(handleDialogs);
  }

  void handleDialogs(dialogs) {
    emit(List.unmodifiable(dialogs));
  }

  final CallPullRepository _callPullRepository;
  late final StreamSubscription _dialogsSub;

  @override
  Future<void> close() {
    _dialogsSub.cancel();
    return super.close();
  }
}
