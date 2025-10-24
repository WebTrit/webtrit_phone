import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webtrit_phone/utils/equatable_prop_to_string.dart';

import '../models/models.dart';

part 'notifications_bloc.freezed.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsSubmitted>(_onSubmitted, transformer: sequential());
    on<NotificationsCleared>(_onCleared, transformer: sequential());
  }

  void _onSubmitted(NotificationsSubmitted event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(lastNotification: event.notification));
  }

  void _onCleared(NotificationsCleared event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(lastNotification: null));
  }
}
