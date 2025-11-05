import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'contact_bloc.freezed.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(this.contactId, {required this.contactsRepository}) : super(const ContactState()) {
    on<ContactStarted>(_onStarted, transformer: restartable());
    on<ContactAddedToFavorites>(_onAddedToFavorites);
    on<ContactRemovedFromFavorites>(_onRemovedFromFavorites);
    on<ContactEmailSend>(_onEmailSend);
  }

  final ContactId contactId;
  final ContactsRepository contactsRepository;

  /// Handles the [ContactStarted] event by subscribing to the contact stream
  /// from the [ContactsRepository] for the given [contactId].
  ///
  /// Each time the repository emits:
  /// - A non-null [Contact], the state is updated with the latest contact data.
  /// - `null`, it signals that the contact has been deleted externally, so the
  ///   state is updated with `deleted: true`.
  ///
  /// This ensures the UI stays in sync with live updates and can react properly
  /// to contact removal.
  FutureOr<void> _onStarted(ContactStarted event, Emitter<ContactState> emit) async {
    await emit.forEach(
      contactsRepository.watchContact(contactId),
      onData: (contact) => state.copyWith(contact: contact, deleted: contact == null),
    );
  }

  FutureOr<void> _onAddedToFavorites(ContactAddedToFavorites event, Emitter<ContactState> emit) async {
    await contactsRepository.addContactPhoneToFavorites(event.contactPhone);
  }

  FutureOr<void> _onRemovedFromFavorites(ContactRemovedFromFavorites event, Emitter<ContactState> emit) async {
    await contactsRepository.removeContactPhoneFromFavorites(event.contactPhone);
  }

  FutureOr<void> _onEmailSend(ContactEmailSend event, Emitter<ContactState> emit) async {
    final emailLaunchUri = Uri(scheme: 'mailto', path: event.contactEmail.address);
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }
}
