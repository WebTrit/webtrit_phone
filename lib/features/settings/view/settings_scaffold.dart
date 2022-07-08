import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../settings.dart';
import '../widgets/widgets.dart';

class SettingsScaffold extends StatefulWidget {
  const SettingsScaffold({Key? key}) : super(key: key);

  @override
  SettingsScaffoldState createState() => SettingsScaffoldState();
}

class SettingsScaffoldState extends State<SettingsScaffold> {
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
            builder: (context, state) {
              return AccountInfoListTile(
                info: state.info,
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
              final logout = await ConfirmDialog.show(
                context,
                title: context.l10n.settings_LogoutConfirmDialog_title,
                content: context.l10n.settings_LogoutConfirmDialog_content,
              );
              if (logout == true) {
                if (!mounted) return;
                context.read<SettingsBloc>().add(const SettingsLogouted());
              }
            },
          ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_settings,
          ),
          ListTile(
            leading: const Icon(Icons.network_check),
            title: Text(context.l10n.settings_ListViewTileTitle_network),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.settingsNetwork);
            },
          ),
          if (EnvironmentConfig.APP_HELP_URL.isNotEmpty) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: Text(context.l10n.settings_ListViewTileTitle_help),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                context.goNamed(MainRoute.settingsHelp);
              },
            ),
          ],
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.settings_ListViewTileTitle_language),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text('English'), // TODO implement language selection
                Icon(Icons.navigate_next),
              ],
            ),
            onTap: () {
              context.goNamed(MainRoute.settingsLanguage);
            },
          ),
          if (EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL.isNotEmpty) ...[
            const ListTileSeparator(),
            ListTile(
              leading: const Icon(Icons.book_outlined),
              title: Text(context.l10n.settings_ListViewTileTitle_termsConditions),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                context.goNamed(MainRoute.settingsTermsConditions);
              },
            ),
          ],
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: Text(context.l10n.settings_ListViewTileTitle_about),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.settingsAbout);
            },
          ),
          const ListTileSeparator(),
          SwitchListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_darkMode),
            value: false,
            onChanged: null, // TODO: implement Dark Theme
            secondary: const Icon(Icons.nights_stay_outlined),
          ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_toolbox,
          ),
          ListTile(
            leading: const Icon(Icons.aod_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.logRecordsConsole);
            },
          ),
          const ListTileSeparator(),
        ],
      ),
    );

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.progress) {
          ProgressOverlay.insert(context, context.read<SettingsBloc>().stream.firstWhere((state) => !state.progress));
        }

        final error = state.error;
        if (error != null) {
          context.showErrorSnackBar(error.toString());
          context.read<SettingsBloc>().add(const SettingsErrorDismissed());
        }
      },
      child: scaffold,
    );
  }
}
