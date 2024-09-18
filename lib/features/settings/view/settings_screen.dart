import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/feature_access/exports.dart';
import 'package:webtrit_phone/models/settings_flavor.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
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
    final scaffold = Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              context.read<SettingsBloc>().add(const SettingsRefreshed());
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              return BlocBuilder<CallBloc, CallState>(
                builder: (context, callState) {
                  return UserInfoListTile(
                    callStatus: callState.status,
                    info: settingsState.info,
                  );
                },
              );
            },
          ),
          const ListTileSeparator(),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return SwitchListTile(
                title: Text(context.l10n.settings_ListViewTileTitle_registered),
                value: state.registerStatus,
                onChanged: (value) {
                  context.read<SettingsBloc>().add(SettingsRegisterStatusChanged(value));
                },
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
            children: sections.map((section) {
              return Column(
                children: [
                  GroupTitleListTile(
                    titleData: context.parseL10n(section.titleL10n),
                  ),
                  Column(
                    children: section.items.map((item) {
                      return Column(children: [
                        ListTile(
                          leading: Icon(item.icon),
                          title: Text(context.parseL10n(item.titleL10n)),
                          onTap: () => _handleNavigation(context, item),
                        ),
                        const ListTileSeparator()
                      ]);
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.progress) {
          ProgressOverlay.insert(context, context.read<SettingsBloc>().stream.firstWhere((state) => !state.progress));
        }
      },
      child: scaffold,
    );
  }

  void _handleNavigation(BuildContext context, SettingItem item) {
    switch (item.flavor) {
      case SettingsFlavor.network:
        context.router.navigate(const NetworkScreenPageRoute());
      case SettingsFlavor.language:
        context.router.navigate(const LanguageScreenPageRoute());
      case SettingsFlavor.help:
        context.router.navigate(HelpScreenPageRoute(initialUriQueryParam: item.data!.url.toString()));
      case SettingsFlavor.terms:
        context.router.navigate(TermsConditionsScreenPageRoute(initialUriQueryParam: item.data!.url.toString()));
      case SettingsFlavor.about:
        context.router.navigate(const AboutScreenPageRoute());
      case SettingsFlavor.log:
        context.router.navigate(const LogRecordsConsoleScreenPageRoute());
      case SettingsFlavor.deleteAccount:
        _deleteAccount(context);
      case SettingsFlavor.embedded:
        context.router.pushWidget(
          WebViewScaffold(
            initialUri: item.data!.url,
          ),
        );
    }
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
