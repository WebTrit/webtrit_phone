import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'contact_bloc.freezed.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(
    this.contactId, {
    required this.callBloc,
    required this.contactsRepository,
  }) : super(ContactState(transfer: callBloc.state.hasTransfer)) {
    on<ContactStarted>(_onStarted, transformer: restartable());
    on<ContactAddedToFavorites>(_onAddedToFavorites);
    on<ContactRemovedFromFavorites>(_onRemovedFromFavorites);
    on<ContactEmailSend>(_onEmailSend);
    on<ManageContactTransfer>(_onManageTransfer);

    callBlocStreamSubscription = callBloc.stream.listen((state) {
      if (callBloc.state.hasTransfer) {
        add(const ManageContactTransfer(true));
      } else {
        add(const ManageContactTransfer(false));
      }
    });
  }

  final ContactId contactId;
  final ContactsRepository contactsRepository;

  final CallBloc callBloc;
  StreamSubscription? callBlocStreamSubscription;

  @override
  Future<void> close() async {
    await callBlocStreamSubscription?.cancel();

    await super.close();
  }

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

  FutureOr<void> _onAddedToFavorites(ContactAddedToFavorites event, Emitter<ContactState> emit) async {
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

  FutureOr<void> _onManageTransfer(ManageContactTransfer event, Emitter<ContactState> emit) async {
    emit(state.copyWith(transfer: event.enabled));
  }
}
