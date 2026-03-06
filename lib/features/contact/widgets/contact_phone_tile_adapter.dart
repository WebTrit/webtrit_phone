import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/keys.dart';

import 'contact_phone_tile.dart';

class ContactPhoneTileAdapter extends StatelessWidget {
  const ContactPhoneTileAdapter({
    super.key,
    required this.number,
    required this.displayLabel,
    required this.favorite,
    required this.callNumbers,
    required this.isSmsEnabled,
    required this.isMessageEnabled,
    required this.enableTileFavorite,
    required this.enableTileVoiceCall,
    required this.enableTileVideoCall,
    required this.enableTileTransfer,
    required this.enableTileCallLog,
    required this.hasActiveCall,
    required this.isBlingTransferInitiated,
    required this.onFavoriteChanged,
    required this.onAudioPressed,
    required this.onVideoPressed,
    required this.onTransferPressed,
    required this.onSmsPressed,
    required this.onCallLogPressed,
    required this.onMessagePressed,
    required this.onCallFromPressed,
  });

  final String number;

  /// Label shown in the tile; may be a merged string (e.g. "number / sms")
  /// when multiple phones share the same number.
  final String displayLabel;

  final bool favorite;
  final List<String> callNumbers;

  /// Whether this number is eligible for SMS (pre-computed by the caller).
  final bool isSmsEnabled;

  /// Whether the contact supports in-app messaging (pre-computed by the caller).
  final bool isMessageEnabled;

  final bool enableTileFavorite;
  final bool enableTileVoiceCall;
  final bool enableTileVideoCall;
  final bool enableTileTransfer;
  final bool enableTileCallLog;
  final bool hasActiveCall;
  final bool isBlingTransferInitiated;

  final void Function(bool) onFavoriteChanged;
  final VoidCallback onAudioPressed;
  final VoidCallback onVideoPressed;
  final VoidCallback onTransferPressed;
  final VoidCallback onSmsPressed;
  final VoidCallback onCallLogPressed;
  final VoidCallback onMessagePressed;
  final void Function(String fromNumber) onCallFromPressed;

  @override
  Widget build(BuildContext context) {
    final favoriteCallback = enableTileFavorite ? onFavoriteChanged : null;
    final audioCallback = enableTileVoiceCall ? onAudioPressed : null;
    final videoCallback = enableTileVideoCall ? onVideoPressed : null;
    final transferCallback = enableTileTransfer && hasActiveCall ? onTransferPressed : null;
    final initiatedTransferCallback = enableTileTransfer && isBlingTransferInitiated ? onTransferPressed : null;
    final smsCallback = isSmsEnabled ? onSmsPressed : null;
    final messageCallback = isMessageEnabled ? onMessagePressed : null;
    final callLogCallback = enableTileCallLog ? onCallLogPressed : null;

    return SizedBox(
      key: ValueKey(number),
      child: ContactPhoneTile(
        key: contactPhoneTileKey,
        number: number,
        label: displayLabel,
        favorite: favorite,
        callNumbers: callNumbers,
        onFavoriteChanged: favoriteCallback,
        onAudioPressed: audioCallback,
        onVideoPressed: videoCallback,
        onTransferPressed: transferCallback,
        onInitiatedTransferPressed: initiatedTransferCallback,
        onSendSmsPressed: smsCallback,
        onMessagePressed: messageCallback,
        onCallLogPressed: callLogCallback,
        onCallFrom: onCallFromPressed,
      ),
    );
  }
}
