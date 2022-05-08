import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class NetworkSettingsTabScaffold extends StatefulWidget {
  const NetworkSettingsTabScaffold({Key? key}) : super(key: key);

  @override
  _NetworkSettingsTabScaffoldState createState() => _NetworkSettingsTabScaffoldState();
}

class _NetworkSettingsTabScaffoldState extends State<NetworkSettingsTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_networkSettings),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Text(context.l10n.underDevelopment),
    );
  }
}
