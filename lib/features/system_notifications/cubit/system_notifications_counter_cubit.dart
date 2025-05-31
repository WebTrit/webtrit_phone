import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';

class SystemNotificationsCounterCubit extends Cubit<int> {
  SystemNotificationsCounterCubit(this._localRepository) : super(0) {
    _countSub = _localRepository.unseenCount().listen(emit);
  }

  final SystemNotificationsLocalRepository _localRepository;
  late final StreamSubscription _countSub;

  @override
  Future<void> close() {
    _countSub.cancel();
    return super.close();
  }
}
