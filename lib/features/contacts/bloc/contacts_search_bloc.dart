import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class ContactsSearchBloc extends Bloc<ContactsSearchEvent, String> {
  ContactsSearchBloc() : super('') {
    on<ContactsSearchChanged>((event, emit) {
      emit(event.value);
    }, transformer: debounceRestartable(debounceSearchDuration));
    on<ContactsSearchSubmitted>((event, emit) {
      emit(event.value);
    }, transformer: sequential());
  }

  static const debounceSearchDuration = Duration(milliseconds: 275);

  EventTransformer<ContactsSearchChanged> debounceRestartable<ContactsSearchChanged>(Duration duration) {
    return (events, mapper) => restartable<ContactsSearchChanged>().call(events.debounceTime(duration), mapper);
  }
}

@immutable
abstract class ContactsSearchEvent extends Equatable {
  const ContactsSearchEvent(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ContactsSearchChanged extends ContactsSearchEvent {
  const ContactsSearchChanged(String value) : super(value);
}

class ContactsSearchSubmitted extends ContactsSearchEvent {
  const ContactsSearchSubmitted(String value) : super(value);
}
