import 'package:equatable/equatable.dart';

/// Configuration for the contact details screen, defining available actions for different UI elements.
class ContactDetailsConfig extends Equatable {
  ContactDetailsConfig({
    Set<ContactAction> appBarActions = const {},
    Set<ContactAction> phoneTileActions = const {},
    Set<ContactAction> emailTileActions = const {},
  }) : _appBarActions = Set.unmodifiable(appBarActions),
       _phoneTileActions = Set.unmodifiable(phoneTileActions),
       _emailTileActions = Set.unmodifiable(emailTileActions);

  final Set<ContactAction> _appBarActions;

  /// Actions to be displayed in the app bar.
  Set<ContactAction> get appBarActions => _appBarActions;

  final Set<ContactAction> _phoneTileActions;

  /// Actions to be displayed in the phone number tile.
  Set<ContactAction> get phoneTileActions => _phoneTileActions;

  final Set<ContactAction> _emailTileActions;

  /// Actions to be displayed in the email address tile.
  Set<ContactAction> get emailTileActions => _emailTileActions;

  @override
  List<Object?> get props => [_appBarActions, _phoneTileActions, _emailTileActions];
}

enum ContactAction { chat, voiceCall, videoCall, sms, transfer, callLog, favorite, sendEmail }
