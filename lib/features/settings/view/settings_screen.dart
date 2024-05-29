import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../settings.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

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
            onLongPress: () async {
              final settingsBloc = context.read<SettingsBloc>();
              final logout = await ConfirmDialog.show(
                context,
                title: context.l10n.settings_ForceLogoutConfirmDialog_title,
                content: context.l10n.settings_ForceLogoutConfirmDialog_content,
              );
              if (logout == true) {
                settingsBloc.add(const SettingsLogouted(force: true));
              }
            },
          ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_settings,
          ),
          ListTile(
            enabled: false,
            leading: const Icon(Icons.network_check),
            title: Text(context.l10n.settings_ListViewTileTitle_network),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.router.navigate(const NetworkScreenPageRoute());
            },
          ),
          if (appHelpUrl != null) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(context.l10n.settings_ListViewTileTitle_help),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                context.router.navigate(HelpScreenPageRoute(initialUriQueryParam: appHelpUrl));
              },
            ),
          ],
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.settings_ListViewTileTitle_language),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return Text(state.locale.l10n(context));
                  },
                ),
                const Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              context.router.navigate(const LanguageScreenPageRoute());
            },
          ),
          if (appTermsAndConditionsUrl != null) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.book_outlined),
              title: Text(context.l10n.settings_ListViewTileTitle_termsConditions),
              trailing: const Icon(Icons.navigate_next),
              onTap: () async {
                final uri = Uri.parse(appTermsAndConditionsUrl);
                if (uri.path.endsWith('.pdf')) {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                } else {
                  context.router.navigate(TermsConditionsScreenPageRoute(initialUriQueryParam: uri.toString()));
                }
              },
            ),
          ],
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: Text(context.l10n.settings_ListViewTileTitle_about),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.router.navigate(const AboutScreenPageRoute());
            },
          ),
          // TODO(SERDUN): Uncomment when dark mode is implemented
          // const ListTileSeparator(),
          // ListTile(
          //   leading: const Icon(Icons.nights_stay_outlined),
          //   title: Text(context.l10n.settings_ListViewTileTitle_themeMode),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       BlocBuilder<AppBloc, AppState>(
          //         builder: (context, state) {
          //           return Text(state.effectiveThemeMode.l10n(context));
          //         },
          //       ),
          //       const Icon(Icons.navigate_next),
          //     ],
          //   ),
          //   onTap: () {
          //     context.router.navigate(const ThemeModeScreenPageRoute());
          //   },
          // ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_toolbox,
          ),
          ListTile(
            leading: const Icon(Icons.aod_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.router.navigate(const LogRecordsConsoleScreenPageRoute());
            },
          ),
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(context.l10n.settings_ListViewTileTitle_accountDelete),
            onTap: () async {
              final settingsBloc = context.read<SettingsBloc>();
              final deleteAccount = await ConfirmDialog.show(
                context,
                title: context.l10n.settings_AccountDeleteConfirmDialog_title,
                content: context.l10n.settings_AccountDeleteConfirmDialog_content,
              );
              if (deleteAccount == true) {
                settingsBloc.add(const SettingsAccountDeleted());
              }
            },
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
}
