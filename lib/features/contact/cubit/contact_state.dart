part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState({
    required this.contact,
  });

  final Contact contact;

  @override
  List<Object> get props => [
        contact,
      ];
}

class ContactInitial extends ContactState {
  const ContactInitial({
    required Contact contact,
  }) : super(contact: contact);
}

class ContactSuccess extends ContactState {
  const ContactSuccess({
    required Contact contact,
    required this.phones,
  }) : super(contact: contact);

  final List<ContactPhone> phones;

  @override
  List<Object> get props => [
        ...super.props,
        phones,
      ];
}
