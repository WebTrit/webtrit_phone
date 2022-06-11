import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/widgets.dart';

class SettingsScaffold extends StatefulWidget {
  const SettingsScaffold({Key? key}) : super(key: key);

  @override
  SettingsScaffoldState createState() => SettingsScaffoldState();
}

class SettingsScaffoldState extends State<SettingsScaffold> {
  bool _dndSelected = false;
  bool _registeredSelected = false;
  bool _darkModeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
      ),
      body: ListView(
        children: [
          const AccountInfoListTile(),
          const ListTileSeparator(),
          SwitchListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_doNotDisturb),
            value: _dndSelected,
            onChanged: (bool value) {
              setState(() {
                _dndSelected = value;
              });
            },
            secondary: const Icon(Icons.block), // TODO implement Do not Disturb functionality
          ),
          const ListTileSeparator(),
          SwitchListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_registered),
            value: _registeredSelected,
            onChanged: (bool value) {
              setState(() {
                _registeredSelected = value;
              });
            },
            secondary:
                const Icon(Icons.account_circle_outlined), // TODO implement Registered/Unregistered functionality
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
                context.read<AppBloc>().add(const AppLogouted());
              }
            },
          ),
          GroupTitleListTile(
            titleData: context.l10n.settings_ListViewTileTitle_settings,
          ),
          ListTile(
            leading: const Icon(Icons.network_check),
            title: Text(context.l10n.settings_ListViewTileTitle_networkSettings),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.networkSettingsTab);
            },
          ),
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(context.l10n.settings_ListViewTileTitle_help),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.helpTab);
            },
          ),
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
              context.goNamed(MainRoute.languageTab);
            },
          ),
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_termsAndConditions),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.termsConditionsTab);
            },
          ),
          const ListTileSeparator(),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: Text(context.l10n.settings_ListViewTileTitle_aboutApplication),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed(MainRoute.aboutAppTab);
            },
          ),
          const ListTileSeparator(),
          SwitchListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_darkMode),
            value: _darkModeSelected,
            onChanged: (bool value) {
              setState(() {
                _darkModeSelected = value;
              });
            },
            secondary: const Icon(Icons.nights_stay_outlined), // TODO implement Dark Theme
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
  }
}
