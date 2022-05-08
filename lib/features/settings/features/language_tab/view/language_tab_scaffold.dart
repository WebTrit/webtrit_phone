import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LanguageTabScaffold extends StatefulWidget {
  const LanguageTabScaffold({Key? key}) : super(key: key);

  @override
  _LanguageTabScaffoldState createState() => _LanguageTabScaffoldState();
}

class _LanguageTabScaffoldState extends State<LanguageTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_language),
        leading: const ExtBackButton(),
      ),
      body: Text(context.l10n.underDevelopment),
    );
  }
}
