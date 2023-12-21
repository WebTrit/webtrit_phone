part of 'contact_bloc.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState({
    Contact? contact,
    List<ContactPhone>? contactPhones,
    List<ContactEmail>? contactEmails,
    @Default(false) bool transfer,
  }) = _ContactState;
}
