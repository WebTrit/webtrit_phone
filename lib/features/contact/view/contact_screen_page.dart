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

    final widget = ContactScreen(
      favoriteVisible: featureAccess.bottomMenuFeature.isTabEnabled(MainFlavor.favorites),
      transferVisible: featureAccess.callFeature.callConfig.isBlindTransferEnabled,
      videoVisible: featureAccess.callFeature.callConfig.isVideoCallEnabled,
      chatsEnabled: featureAccess.messagingFeature.chatsPresent,
    );
    final provider = BlocProvider(
      create: (context) {
        return ContactBloc(
          contactId,
          contactsRepository: context.read<ContactsRepository>(),
        )..add(const ContactStarted());
      },
      child: widget,
    );
    return provider;
  }
}
