import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class MediaSettingsScreenScreenshot extends StatelessWidget {
  const MediaSettingsScreenScreenshot({
    super.key,
    this.initialOpenSection = 1,
  });

  final int initialOpenSection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediaSettingsCubit>(
      create: (context) => MockMediaSettingsCubit.settingsScreen(),
      child: MediaSettingsScreen(
        initialOpenSection: initialOpenSection,
      ),
    );
  }
}
