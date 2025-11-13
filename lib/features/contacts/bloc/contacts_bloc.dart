import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/active_contact_source_type/active_contact_source_type_repository.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'contacts_bloc.freezed.dart';

part 'contacts_event.dart';

part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({required this.activeContactSourceTypeRepository})
    : super(ContactsState(sourceType: activeContactSourceTypeRepository.getActiveContactSourceType())) {
    on<ContactsSourceTypeChanged>(_onSourceTypeChanged, transformer: debounce());
    on<ContactsSearchChanged>(_onSearchChanged, transformer: debounce());
    on<ContactsSearchSubmitted>(_onSearchSubmitted, transformer: sequential());
  }

  final ActiveContactSourceTypeRepository activeContactSourceTypeRepository;

  Future<void> _onSourceTypeChanged(ContactsSourceTypeChanged event, Emitter<ContactsState> emit) async {
    await activeContactSourceTypeRepository.setActiveContactSourceType(event.sourceType);

    emit(state.copyWith(sourceType: event.sourceType));
  }

  Future<void> _onSearchChanged(ContactsSearchChanged event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(search: event.search));
  }

  Future<void> _onSearchSubmitted(ContactsSearchSubmitted event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(search: event.search));
  }
}
