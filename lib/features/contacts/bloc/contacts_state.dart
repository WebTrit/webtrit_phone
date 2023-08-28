part of 'contacts_bloc.dart';

@freezed
class ContactsState with _$ContactsState {
  const factory ContactsState({
    @Default('') String search,
    required ContactSourceType sourceType,
  }) = _ContactsState;
}
