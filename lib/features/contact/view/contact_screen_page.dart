import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class ContactScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactScreenPage(@pathParam this.contactId);

  final int contactId;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final contactsConfig = featureAccess.contactsFeature.detailsConfig;
    final callConfig = featureAccess.callFeature.callConfig;
    final messagingFeature = featureAccess.messagingFeature;
    final bottomMenuFeature = featureAccess.bottomMenuFeature;

    final canChat = messagingFeature.chatsPresent;
    final canSms = messagingFeature.smsPresent;
    final canVideoCall = callConfig.isVideoCallEnabled;
    final canTransfer = callConfig.isBlindTransferEnabled;
    final favoritesEnabled = bottomMenuFeature.getTabEnabled<FavoritesBottomMenuTab>() != null;
    final useCdrsForHistory = bottomMenuFeature.getTabEnabled<RecentsBottomMenuTab>()?.useCdrs ?? false;

    bool isTileEnabled(ContactAction action, [bool capability = true]) {
      return contactsConfig.phoneTileActions.contains(action) && capability;
    }

    bool isAppBarEnabled(ContactAction action, [bool capability = true]) {
      return contactsConfig.appBarActions.contains(action) && capability;
    }

    final widget = ContactScreen(
      enableAppBarChat: isAppBarEnabled(ContactAction.chat, canChat),
      enableTileFavorite: isTileEnabled(ContactAction.favorite, favoritesEnabled),
      enableTileVoiceCall: isTileEnabled(ContactAction.voiceCall),
      enableTileVideoCall: isTileEnabled(ContactAction.videoCall, canVideoCall),
      enableTileSms: isTileEnabled(ContactAction.sms, canSms),
      enableTileChat: isTileEnabled(ContactAction.chat, canChat),
      enableTileTransfer: isTileEnabled(ContactAction.transfer, canTransfer),
      enableTileCallLog: isTileEnabled(ContactAction.callLog),
      enableTileEmail: contactsConfig.emailTileActions.contains(ContactAction.sendEmail),
      useCdrsForHistory: useCdrsForHistory,
    );

    return BlocProvider(
      create: (context) {
        return ContactBloc(contactId, contactsRepository: context.read<ContactsRepository>())
          ..add(const ContactStarted());
      },
      child: widget,
    );
  }
}
