import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class HelpTabScaffold extends StatefulWidget {
  const HelpTabScaffold({Key? key}) : super(key: key);

  @override
  _HelpTabScaffoldState createState() => _HelpTabScaffoldState();
}

class _HelpTabScaffoldState extends State<HelpTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_help),
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
