part of 'contacts_bloc.dart';

@freezed
abstract class ContactsState with _$ContactsState {
  const factory ContactsState({
    @Default('') String search,
    required ContactSourceType sourceType,
  }) = _ContactsState;
}
