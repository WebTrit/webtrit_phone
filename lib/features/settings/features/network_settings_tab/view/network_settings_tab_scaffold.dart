import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class NetworkSettingsTabScaffold extends StatefulWidget {
  const NetworkSettingsTabScaffold({Key? key}) : super(key: key);

  @override
  NetworkSettingsTabScaffoldState createState() => NetworkSettingsTabScaffoldState();
}

class NetworkSettingsTabScaffoldState extends State<NetworkSettingsTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_networkSettings),
        leading: const ExtBackButton(),
      ),
      body: Text(context.l10n.underDevelopment),
    );
  }
}
