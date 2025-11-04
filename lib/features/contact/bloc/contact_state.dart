part of 'contact_bloc.dart';

@freezed
class ContactState with _$ContactState {
  const ContactState({this.contact, this.deleted = false, this.presenceInfo = const []});

  @override
  final Contact? contact;

  @override
  final bool deleted;

  @override
  final List<PresenceInfo> presenceInfo;
}
