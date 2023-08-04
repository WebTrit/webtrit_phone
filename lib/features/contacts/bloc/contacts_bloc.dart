import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

part 'contacts_bloc.freezed.dart';

part 'contacts_event.dart';

part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({
    required this.appPreferences,
  }) : super(ContactsState(sourceType: appPreferences.getActiveContactsSourceType())) {
    on<ContactsSourceTypeChanged>(_onSourceTypeChanged, transformer: debounceRestartable(debounceSearchDuration));
    on<ContactsSearchChanged>(_onSearchChanged, transformer: debounceRestartable(debounceSearchDuration));
    on<ContactsSearchSubmitted>(_onSearchSubmitted, transformer: sequential());
  }

  static const debounceSearchDuration = Duration(milliseconds: 275);

  final AppPreferences appPreferences;

  EventTransformer<ContactsSearchChanged> debounceRestartable<ContactsSearchChanged>(Duration duration) {
    return (events, mapper) => restartable<ContactsSearchChanged>().call(events.debounceTime(duration), mapper);
  }

  Future<void> _onSourceTypeChanged(ContactsSourceTypeChanged event, Emitter<ContactsState> emit) async {
    await appPreferences.setActiveContactsSourceType(event.sourceType);

    emit(state.copyWith(sourceType: event.sourceType));
  }

  Future<void> _onSearchChanged(ContactsSearchChanged event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(search: event.search));
  }

  Future<void> _onSearchSubmitted(ContactsSearchSubmitted event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(search: event.search));
  }
}
