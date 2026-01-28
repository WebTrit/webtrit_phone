import 'package:equatable/equatable.dart';

/// Configuration for the contact details screen, defining available actions for different UI elements.
class ContactDetailsConfig extends Equatable {
  const ContactDetailsConfig({
    this.appBarActions = const {},
    this.phoneTileActions = const {},
    this.emailTileActions = const {},
  });

  final Set<ContactAction> appBarActions;
  final Set<ContactAction> phoneTileActions;
  final Set<ContactAction> emailTileActions;

  @override
  List<Object?> get props => [appBarActions, phoneTileActions, emailTileActions];
}

enum ContactAction { chat, voiceCall, videoCall, sms, transfer, callLog, favorite, sendEmail }
