import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import '../../../../../widgets/app_bar.dart';

class AboutAppTabScaffold extends StatefulWidget {
  const AboutAppTabScaffold({Key? key}) : super(key: key);

  @override
  _AboutAppTabScaffoldState createState() => _AboutAppTabScaffoldState();
}

class _AboutAppTabScaffoldState extends State<AboutAppTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: Text(context.l10n.aboutApplication),
        centerTitle: true,
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
