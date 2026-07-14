import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../cubit/transcription_settings_cubit.dart';
import 'transcription_settings_screen.dart';

@RoutePage()
class TranscriptionSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TranscriptionSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranscriptionSettingsCubit(
        // The voicemail repository owns the voicemail transcription model.
        modelRepository: context.read<VoicemailRepository>(),
        transcriptionConfig: context.read<FeatureAccess>().transcriptionConfig,
      ),
      child: const TranscriptionSettingsScreen(),
    );
  }
}
