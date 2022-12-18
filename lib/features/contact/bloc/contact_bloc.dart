import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'contact_bloc.freezed.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(
    this.contactId, {
    required this.contactsRepository,
  }) : super(const ContactState()) {
    on<ContactStarted>(_onStarted, transformer: restartable());
    on<ContactAddedByToFavorites>(_onAddedByToFavorites);
    on<ContactRemovedFromFavorites>(_onRemovedFromFavorites);
    on<ContactEmailSend>(_onEmailSend);
  }

  final ContactId contactId;
  final ContactsRepository contactsRepository;

  FutureOr<void> _onStarted(ContactStarted event, Emitter<ContactState> emit) async {
    final watchContactForEachFuture = emit.forEach(
      contactsRepository.watchContact(contactId),
      onData: (contact) => state.copyWith(
        contact: contact,
      ),
    );

    final watchContactPhonesForEachFuture = emit.forEach(
      contactsRepository.watchContactPhones(contactId),
      onData: (contactPhones) => state.copyWith(
        contactPhones: contactPhones,
      ),
    );

    final watchContactEmailsForEachFuture = emit.forEach(
      contactsRepository.watchContactEmails(contactId),
      onData: (contactEmails) => state.copyWith(
        contactEmails: contactEmails,
      ),
    );

    await Future.wait([
      watchContactForEachFuture,
      watchContactPhonesForEachFuture,
      watchContactEmailsForEachFuture,
    ]);
  }

  FutureOr<void> _onAddedByToFavorites(ContactAddedByToFavorites event, Emitter<ContactState> emit) async {
    await contactsRepository.addContactPhoneToFavorites(event.contactPhone);
  }

  FutureOr<void> _onRemovedFromFavorites(ContactRemovedFromFavorites event, Emitter<ContactState> emit) async {
    await contactsRepository.removeContactPhoneFromFavorites(event.contactPhone);
  }

  FutureOr<void> _onEmailSend(ContactEmailSend event, Emitter<ContactState> emit) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: event.contactEmail.address,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }
}
