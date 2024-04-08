import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/models.dart';

part 'notifications_bloc.freezed.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsIssued>(_onErrorNotified, transformer: sequential());
    on<NotificationsMessaged>(_onMessageNotified, transformer: sequential());
    on<NotificationsCleared>(_onErrorCleared, transformer: sequential());
  }

  void _onErrorNotified(NotificationsIssued event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(lastNotification: event.notification));
  }

  void _onMessageNotified(NotificationsMessaged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(lastNotification: event.notification));
  }

  void _onErrorCleared(NotificationsCleared event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(lastNotification: null));
  }
}
