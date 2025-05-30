import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';

abstract class SystemNotificationsCounterCubit extends Cubit<int> {
  SystemNotificationsCounterCubit(super.initialState);
}

class SystemNotificationsCounterCubitRecordsBasedImpl extends SystemNotificationsCounterCubit {
  SystemNotificationsCounterCubitRecordsBasedImpl(this._localRepository) : super(0) {
    _countSub = _localRepository.unseenCountByRecords().listen(emit);
  }

  final SystemNotificationsLocalRepository _localRepository;
  late final StreamSubscription _countSub;

  @override
  Future<void> close() {
    _countSub.cancel();
    return super.close();
  }
}

class SystemNotificationsCounterCubitRemoteBasedImpl extends SystemNotificationsCounterCubit {
  SystemNotificationsCounterCubitRemoteBasedImpl(this._localRepository) : super(0);

  final SystemNotificationsLocalRepository _localRepository;
  late final StreamSubscription _eventsSub;
  Set<int> _pendingSeenIDs = {};

  Future<void> init() async {
    final seenOutoxEntries = await _localRepository.getOutboxNotifications(SnOutboxActionType.seen);
    _pendingSeenIDs = seenOutoxEntries.map((entry) => entry.notificationId).toSet();
    _eventsSub = _localRepository.eventBus.listen(_onEvent);
    _updateCounter();
  }

  void _onEvent(SystemNotificationEvent event) {
    if (event is SystemNotificationOutboxUpdate) {
      _pendingSeenIDs.add(event.id);
      _updateCounter();
    }
    if (event is SystemNotificationOutboxRemove) {
      _pendingSeenIDs.remove(event.id);
      _updateCounter();
    }
    if (event is SystemNotificationUnseenCountUpdate) {
      _updateCounter();
    }
  }

  _updateCounter() {
    final unseenCount = _localRepository.unseenCount ?? 0;
    final pendingSeenCount = _pendingSeenIDs.length;
    emit((unseenCount - pendingSeenCount).clamp(0, 1337));
  }

  @override
  Future<void> close() {
    _eventsSub.cancel();
    return super.close();
  }
}
