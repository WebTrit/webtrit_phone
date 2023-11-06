import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_phone/app/routes.dart';
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
    final scaffold = Scaffold(
      appBar: AppBar(
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
              context.pushNamed(MainRoute.settingsNetwork);
            },
          ),
          if (EnvironmentConfig.APP_HELP_URL.isNotEmpty) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(context.l10n.settings_ListViewTileTitle_help),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                context.pushNamed(MainRoute.settingsHelp);
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
              context.pushNamed(MainRoute.settingsLanguage);
            },
          ),
          if (EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL.isNotEmpty) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.book_outlined),
              title: Text(context.l10n.settings_ListViewTileTitle_termsConditions),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                final uri = Uri.parse(EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL);

                if (uri.path.endsWith('.pdf')) {
                  _launchUrlWithDefaultPlatformViewer(uri);
                } else {
                  context.pushNamed(
                    MainRoute.settingsTermsConditions,
                    queryParameters: {
                      TermsConditionsScreen.initialUriQueryParameterName: uri.toString(),
                    },
                  );
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
              context.pushNamed(MainRoute.settingsAbout);
            },
          ),
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.nights_stay_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_themeMode),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return Text(state.effectiveThemeMode.l10n(context));
                  },
                ),
                const Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              context.pushNamed(MainRoute.settingsThemeMode);
            },
          ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_toolbox,
          ),
          ListTile(
            leading: const Icon(Icons.aod_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.pushNamed(MainRoute.logRecordsConsole);
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

  void _launchUrlWithDefaultPlatformViewer(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
