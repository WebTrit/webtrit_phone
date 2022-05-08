import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../../blocs/app/app_bloc.dart';
import '../../../data/secure_storage.dart';
import '../../../styles/app_colors.dart';
import '../bloc/settings_bloc.dart';

class SettingsScaffold extends StatefulWidget {
  const SettingsScaffold({Key? key}) : super(key: key);

  @override
  _SettingsScaffoldState createState() => _SettingsScaffoldState();
}

class _SettingsScaffoldState extends State<SettingsScaffold> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    bool _dndSelected = false;
    bool _registeredSelected = false;
    bool _darkModeSelected = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                final info = state.info;
                if (info != null) {
                  return LeadingAvatar(
                    username: '${info.firstname} ${info.lastname}',
                    radius: 50,
                  );
                } else {
                  return const SizedBox(
                    width: 10,
                    height: 10,
                  );
                }
              },
            ),
            title: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                final info = state.info;
                if (info != null) {
                  return Text(
                    '${info.firstname} ${info.lastname}',
                    style: themeData.textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 10,
                    height: 10,
                  );
                }
              },
            ),
            subtitle: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                final info = state.info;
                if (info != null) {
                  return Text(
                    '${info.balance.toStringAsFixed(2)} ${info.currency}',
                    style: themeData.textTheme.button!.copyWith(
                      color: themeData.textTheme.caption!.color,
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: 10,
                    height: 10,
                  );
                }
              },
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: null, // TODO implement edit account page
                ),
              ],
            ),
            isThreeLine: true,
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
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
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
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
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.l10n.settings_ListViewTileTitle_logout),
            onTap: () async {
              if (await _confirmUnregister(context) == true) {
                // TODO: move logout logic to some bloc
                final token = await SecureStorage().readToken();
                if (token != null) {
                  await SecureStorage().deleteToken();
                  final webtritApiClient = context.read<WebtritApiClient>();
                  await webtritApiClient.sessionLogout(token);
                }
                context.read<AppBloc>().add(const AppUnregistered());
              }
            },
          ),
          ListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_settings, style: themeData.textTheme.bodyText2),
            tileColor: AppColors.backgroundLight,
          ),
          ListTile(
            leading: const Icon(Icons.network_check),
            title: Text(context.l10n.settings_ListViewTileTitle_networkSettings),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed('network-settings-tab');
            },
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(context.l10n.settings_ListViewTileTitle_help),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed('help-tab');
            },
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
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
              context.goNamed('language-tab');
            },
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_termsAndConditions),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed('terms-conditions-tab');
            },
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: Text(context.l10n.settings_ListViewTileTitle_aboutApplication),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed('about-app-tab');
            },
          ),
          const Divider(
            color: AppColors.lightGrey,
            indent: 15,
            endIndent: 15,
          ),
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
          ListTile(
            title: Text(context.l10n.settings_ListViewTileTitle_toolbox, style: themeData.textTheme.bodyText2),
            tileColor: AppColors.backgroundLight,
          ),
          ListTile(
            leading: const Icon(Icons.aod_outlined),
            title: Text(context.l10n.settings_ListViewTileTitle_logRecordsConsole),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              context.goNamed('log-records-console');
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmUnregister(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm unregister"),
          content: const Text("Are you sure you want to unregister?"),
          actions: [
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
