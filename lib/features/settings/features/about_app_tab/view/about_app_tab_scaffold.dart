import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class AboutAppTabScaffold extends StatefulWidget {
  const AboutAppTabScaffold({Key? key}) : super(key: key);

  @override
  _AboutAppTabScaffoldState createState() => _AboutAppTabScaffoldState();
}

class _AboutAppTabScaffoldState extends State<AboutAppTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_aboutApplication),
        leading: const ExtBackButton(),
      ),
      body: Text(context.l10n.underDevelopment),
    );
  }
}
