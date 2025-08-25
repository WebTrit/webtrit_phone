part of 'contact_bloc.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState({
    Contact? contact,
    @Default(false) bool deleted,
  }) = _ContactState;
}
