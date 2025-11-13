import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../media_settings/media_settings.dart';

@RoutePage()
class MediaSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MediaSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    final defaultPeerConnectionSettings = context.read<FeatureAccess>().callFeature.peerConnection;
    return BlocProvider(
      create: (context) => MediaSettingsCubit(
        context.read<AppPreferences>(),
        defaultPeerConnectionSettings,
        context.read<AudioProcessingSettingsRepository>(),
        context.read<EncodingPresetRepository>(),
        context.read<IceSettingsRepository>(),
        context.read<PeerConnectionSettingsRepository>(),
        context.read<VideoCapturingSettingsRepository>(),
        context.read<EncodingSettingsRepository>(),
      ),
      child: const MediaSettingsScreen(),
    );
  }
}
