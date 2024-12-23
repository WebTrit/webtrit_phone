import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/embedded/exports.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/self_config/self_config.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/models/self_config.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../settings.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.sections,
  });

  final List<SettingsSection> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              context.read<RegisterStatusCubit>().fetchStatus();
            },
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.progress != current.progress,
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                children: [
                  const SizedBox(height: 16),
                  BlocBuilder<UserInfoCubit, UserInfoState>(
                    builder: (context, state) {
                      return UserInfoListTile(info: state.userInfo);
                    },
                  ),
                  BlocBuilder<SessionStatusCubit, SessionStatusState>(
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, callState) {
                      return SessionStatusListTile(
                        status: callState.status,
                        onTap: () => context.router.navigate(const DiagnosticScreenPageRoute()),
                      );
                    },
                  ),
                  const ListTileSeparator(),
                  BlocBuilder<RegisterStatusCubit, RegisterStatus>(
                    builder: (context, state) {
                      return SwitchListTile(
                        title: Text(context.l10n.settings_ListViewTileTitle_registered),
                        value: state,
                        onChanged: (value) => context.read<RegisterStatusCubit>().setStatus(value),
                        secondary: const Icon(Icons.account_circle_outlined),
                      );
                    },
                  ),
                  const ListTileSeparator(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text(context.l10n.settings_ListViewTileTitle_logout),
                    onTap: () async {
                      final settingsBloc = context.read<SettingsBloc>();
                      final logout = await ConfirmDialog.show(
                        context,
                        title: context.l10n.settings_LogoutConfirmDialog_title,
                        content: context.l10n.settings_LogoutConfirmDialog_content,
                      );
                      if (logout == true) {
                        settingsBloc.add(const SettingsLogouted());
                      }
                    },
                  ),
                  Column(
                    children: [
                      for (var section in sections)
                        Column(
                          children: [
                            GroupTitleListTile(
                              titleData: context.parseL10n(section.titleL10n),
                            ),
                            ...[
                              for (var item in section.items)
                                if (item.flavor == SettingsFlavor.network)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(const NetworkScreenPageRoute()),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.language)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(const LanguageScreenPageRoute()),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.help)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(
                                          HelpScreenPageRoute(initialUriQueryParam: item.data!.resource.toString())),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.terms)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(TermsConditionsScreenPageRoute(
                                          initialUriQueryParam: item.data!.resource.toString())),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.about)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(const AboutScreenPageRoute()),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.log)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(const LogRecordsConsoleScreenPageRoute()),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.deleteAccount)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => _deleteAccount(context),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.embedded)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(EmbeddedScreenPage.route(item.data!)),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.callCodecs)
                                  Column(children: [
                                    ListTile(
                                      leading: Icon(item.icon),
                                      title: Text(context.parseL10n(item.titleL10n)),
                                      onTap: () => context.router.navigate(const CallCodecsScreenPageRoute()),
                                    ),
                                    const ListTileSeparator(),
                                  ])
                                else if (item.flavor == SettingsFlavor.selfConfig)
                                  BlocBuilder<SelfConfigCubit, SelfConfigState>(
                                    builder: (context, state) {
                                      final selfConfig = state.selfConfig;
                                      if (selfConfig is SelfConfigSupported) {
                                        return Column(children: [
                                          ListTile(
                                            leading: Icon(item.icon),
                                            title: Text(context.parseL10n(item.titleL10n)),
                                            onTap: () => context.router.navigate(
                                              SelfConfigScreenPageRoute(url: selfConfig.url),
                                            ),
                                          ),
                                          const ListTileSeparator(),
                                        ]);
                                      }

                                      return const SizedBox.shrink();
                                    },
                                  )
                            ],
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              if (state.progress)
                const AbsorbPointer(
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          );
        },
      ),
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final settingsBloc = context.read<SettingsBloc>();
    final deleteAccount = await ConfirmDialog.show(
      context,
      title: context.l10n.settings_AccountDeleteConfirmDialog_title,
      content: context.l10n.settings_AccountDeleteConfirmDialog_content,
    );
    if (deleteAccount == true) {
      settingsBloc.add(const SettingsAccountDeleted());
    }
  }
}
