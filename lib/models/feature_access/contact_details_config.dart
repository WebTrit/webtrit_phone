class ContactDetailsConfig {
  final Set<ContactAction> appBarActions;
  final Set<ContactAction> phoneTileActions;
  final Set<ContactAction> emailTileActions;

  const ContactDetailsConfig({
    this.appBarActions = const {},
    this.phoneTileActions = const {},
    this.emailTileActions = const {},
  });
}

enum ContactAction { chat, voiceCall, videoCall, sms, transfer, callLog, favorite, sendEmail }
