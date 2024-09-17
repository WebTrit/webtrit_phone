import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/feature_access/exports.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../settings.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.accountFeature,
  });

  final AccountFeature accountFeature;

  @override
  Widget build(BuildContext context) {
    const appHelpUrl = EnvironmentConfig.APP_HELP_URL;
    const appTermsAndConditionsUrl = EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL;

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
            children: accountFeature.sections.map((section) {
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
                          onTap: () => _handleNavigation(context, item.type, item.data),
                        ),
                        const ListTileSeparator()
                      ]);
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),

          // // TODO(SERDUN): Uncomment when dark mode is implemented
          // // const ListTileSeparator(),
          // // ListTile(
          // //   leading: const Icon(Icons.nights_stay_outlined),
          // //   title: Text(context.l10n.settings_ListViewTileTitle_themeMode),
          // //   trailing: Row(
          // //     mainAxisSize: MainAxisSize.min,
          // //     children: [
          // //       BlocBuilder<AppBloc, AppState>(
          // //         builder: (context, state) {
          // //           return Text(state.effectiveThemeMode.l10n(context));
          // //         },
          // //       ),
          // //       const Icon(Icons.navigate_next),
          // //     ],
          // //   ),
          // //   onTap: () {
          // //     context.router.navigate(const ThemeModeScreenPageRoute());
          // //   },
          // // ),
          //

          //
          // GroupTitleListTile(
          //   titleData: context.l10n.settings_ListViewTileTitle_toolbox,
          // ),
          // ListTile(
          //   leading: const Icon(Icons.aod_outlined),
          //   title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     context.router.navigate(const LogRecordsConsoleScreenPageRoute());
          //   },
          // ),

          // const ListTileSeparator(),
          // ListTile(
          //   leading: const Icon(Icons.delete_outline),
          //   title: Text(context.l10n.settings_ListViewTileTitle_accountDelete),
          //   onTap: () async {
          //     await _deleteAccount(context);
          //   },
          // ),
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

  void _handleNavigation(BuildContext context, String type, AccountItemData? data) {
    if (type == "network") {
      context.router.navigate(const NetworkScreenPageRoute());
    } else if (type == "language") {
      context.router.navigate(const LanguageScreenPageRoute());
    } else if (type == "terms") {
      context.router.navigate(TermsConditionsScreenPageRoute(initialUriQueryParam: ""));
    } else if (type == "about") {
      context.router.navigate(const AboutScreenPageRoute());
    } else if (type == "log") {
      context.router.navigate(const LogRecordsConsoleScreenPageRoute());
    } else if (type == "delete_account") {
      _deleteAccount(context);
    } else if (type == "embedded") {
      context.router.pushWidget(
        WebViewScaffold(
          initialUri: Uri.parse(data!.url),
        ),
      );
    }
  }
}
