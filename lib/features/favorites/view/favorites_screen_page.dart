import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/feature_access/bottom_menu_feature.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class FavoritesScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FavoritesScreenPage();

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final cdrsEnabled = featureAccess.bottomMenuFeature.getTabEnabled<RecentsBottomMenuTab>()?.useCdrs;

    final widget = FavoritesScreen(
      title: const Text(EnvironmentConfig.APP_NAME),
      transferEnabled: featureAccess.callFeature.callConfig.isBlindTransferEnabled,
      videoEnabled: featureAccess.callFeature.callConfig.isVideoCallEnabled,
      chatsEnabled: featureAccess.messagingFeature.chatsPresent,
      smssEnabled: featureAccess.messagingFeature.smsPresent,
      cdrsEnabled: cdrsEnabled ?? false,
    );
    final provider = BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: context.read<FavoritesRepository>(),
      )..add(const FavoritesStarted()),
      child: widget,
    );
    return provider;
  }
}
