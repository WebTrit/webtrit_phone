import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/mocks/mocks.dart';

class SettingScreenScreenshot extends StatefulWidget {
  const SettingScreenScreenshot({
    super.key,
  });

  @override
  State<SettingScreenScreenshot> createState() => _SettingScreenScreenshotState();
}

class _SettingScreenScreenshotState extends State<SettingScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (Duration timeStamp) {
        if (!mounted) {
          return;
        }

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<CallBloc>(
                    create: (context) => MockCallBloc.settingsScreen(),
                  ),
                  BlocProvider<SettingsBloc>(
                    create: (context) => MockSettingsBloc.settingsScreen(),
                  ),
                ],
                child: SettingsScreen(
                  sections: [
                    SettingsSection(
                      titleL10n: 'settings_section_title_general',
                      items: [
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_network',
                          icon: Icons.network_check,
                          flavor: SettingsFlavor.network,
                        ),
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_language',
                          icon: Icons.language,
                          flavor: SettingsFlavor.language,
                        ),
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_termsConditions',
                          icon: Icons.book_outlined,
                          flavor: SettingsFlavor.terms,
                        ),
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_about',
                          icon: Icons.card_travel,
                          flavor: SettingsFlavor.about,
                        ),
                      ],
                    ),
                    SettingsSection(
                      titleL10n: 'settings_ListViewTileTitle_toolbox',
                      items: [
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_logRecordsConsole',
                          icon: Icons.aod_outlined,
                          flavor: SettingsFlavor.log,
                        ),
                        SettingItem(
                          titleL10n: 'settings_ListViewTileTitle_accountDelete',
                          icon: Icons.delete_outline,
                          flavor: SettingsFlavor.deleteAccount,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            fullscreenDialog: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
