import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/services/services.dart';

import '../cubit/transcription_settings_cubit.dart';
import 'transcription_settings_screen.dart';

@RoutePage()
class TranscriptionSettingsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TranscriptionSettingsScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranscriptionSettingsCubit(modelService: context.read<TranscriptionModelService>()),
      child: const TranscriptionSettingsScreen(),
    );
  }
}
