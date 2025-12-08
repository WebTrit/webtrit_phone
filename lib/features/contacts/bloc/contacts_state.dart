part of 'contacts_bloc.dart';

@freezed
class ContactsState with _$ContactsState {
  const ContactsState({this.search = '', required this.sourceType});

  @override
  final String search;

  @override
  final ContactSourceType sourceType;
}
