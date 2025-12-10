import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/contact.dart';
import 'package:webtrit_phone/models/contact_phone.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';

import 'contact_phone_tile.dart';

/// Callback for when the favorite status of a contact phone is changed.
typedef OnFavoriteChangedCallback = void Function(bool isFavorite);

/// Callback for when a call is initiated from a specific number.
typedef OnCallFromCallback = void Function(String fromNumber);

class ContactPhoneTileAdapter extends StatelessWidget {
  const ContactPhoneTileAdapter({
    super.key,
    required this.contactPhone,
    required this.contact,
    required this.enableTileFavorite,
    required this.enableTileVoiceCall,
    required this.enableTileVideoCall,
    required this.enableTileSms,
    required this.enableTileChat,
    required this.enableTileTransfer,
    required this.enableTileCallLog,
    required this.contactSmsNumbers,
    required this.contactSourceId,
    required this.userSmsNumbers,
    required this.hasActiveCall,
    required this.isBlingTransferInitiated,
    required this.callRoutingState,
    required this.onFavoriteChanged,
    required this.onAudioPressed,
    required this.onVideoPressed,
    required this.onTransferPressed,
    required this.onSendSmsPressed,
    required this.onCallLogPressed,
    required this.onNavigateToChatConversation,
    required this.onCallFromPressed,
  });

  final ContactPhone contactPhone;
  final Contact contact;
  final bool enableTileFavorite;
  final bool enableTileVoiceCall;
  final bool enableTileVideoCall;
  final bool enableTileSms;
  final bool enableTileChat;
  final bool enableTileTransfer;
  final bool enableTileCallLog;
  final List<String> contactSmsNumbers;
  final String? contactSourceId;
  final List<String> userSmsNumbers;
  final bool hasActiveCall;
  final bool isBlingTransferInitiated;
  final CallRoutingState? callRoutingState;

  // Handler methods passed from the parent State
  final void Function(bool, ContactPhone) onFavoriteChanged;
  final void Function(ContactPhone, Contact) onAudioPressed;
  final void Function(ContactPhone, Contact) onVideoPressed;
  final void Function(ContactPhone) onTransferPressed;
  final void Function(ContactPhone, String?, List<String>) onSendSmsPressed;
  final void Function(String) onCallLogPressed;
  final void Function(Contact) onNavigateToChatConversation;
  final void Function(ContactPhone, Contact, String) onCallFromPressed;

  @override
  Widget build(BuildContext context) {
    /// Checks if the current phone number is configured for SMS/text messaging.
    final isSmsEnabled = enableTileSms && contactSmsNumbers.contains(contactPhone.number);

    /// Callback executed when the favorite status of the phone number is toggled.
    /// It is only enabled if [enableTileFavorite] is true.
    final OnFavoriteChangedCallback? favoriteCallback =
        enableTileFavorite //
        ? (isFavorite) => onFavoriteChanged(isFavorite, contactPhone)
        : null;

    /// Callback executed to initiate a standard voice call.
    /// It is only enabled if [enableTileVoiceCall] is true.
    final VoidCallback? audioCallback = enableTileVoiceCall ? () => onAudioPressed(contactPhone, contact) : null;

    /// Callback executed to initiate a video call.
    /// It is only enabled if [enableTileVideoCall] is true.
    final VoidCallback? videoCallback = enableTileVideoCall ? () => onVideoPressed(contactPhone, contact) : null;

    /// Callback executed to transfer an active call to this number.
    /// It is only enabled if [enableTileTransfer] is true AND there is an active call.
    final VoidCallback? transferCallback = enableTileTransfer && hasActiveCall
        ? () => onTransferPressed(contactPhone)
        : null;

    /// Callback executed to complete a blind transfer initiated by the user to this number.
    /// It is only enabled if [enableTileTransfer] is true AND a blind transfer has been initiated.
    final VoidCallback? initiatedTransferCallback = enableTileTransfer && isBlingTransferInitiated
        ? () => onTransferPressed(contactPhone)
        : null;

    /// Callback executed to navigate to the SMS conversation screen.
    /// It is only enabled if [enableTileSms] is true AND the contact's number is configured for SMS.
    final VoidCallback? smsCallback = isSmsEnabled
        ? () => onSendSmsPressed(contactPhone, contactSourceId, userSmsNumbers)
        : null;

    /// Callback executed to navigate to the in-app chat conversation screen.
    /// It is only enabled if [enableTileChat] is true AND the contact can receive messages (based on internal logic).
    final VoidCallback? messageCallback = enableTileChat && contact.canMessage
        ? () => onNavigateToChatConversation(contact)
        : null;

    /// Callback executed to navigate to the call history/log screen for this specific number.
    /// It is only enabled if [enableTileCallLog] is true.
    final VoidCallback? callLogCallback = enableTileCallLog ? () => onCallLogPressed(contactPhone.number) : null;

    /// Callback used by the "Call From" menu to initiate a call, specifying a particular "From" number.
    /// This callback is always defined, as its availability is managed by the nested widget's UI logic.
    void callFromCallback(String fromNumber) => onCallFromPressed(contactPhone, contact, fromNumber);

    return SizedBox(
      key: ValueKey(contactPhone),
      child: ContactPhoneTile(
        key: contactPhoneTileKey,
        number: contactPhone.number,
        label: contactPhone.label,
        favorite: contactPhone.favorite,
        callNumbers: callRoutingState?.allNumbers ?? [],
        onFavoriteChanged: favoriteCallback,
        onAudioPressed: audioCallback,
        onVideoPressed: videoCallback,
        onTransferPressed: transferCallback,
        onInitiatedTransferPressed: initiatedTransferCallback,
        onSendSmsPressed: smsCallback,
        onMessagePressed: messageCallback,
        onCallLogPressed: callLogCallback,
        onCallFrom: callFromCallback,
      ),
    );
  }
}
