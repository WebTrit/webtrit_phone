import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import '../../../../../widgets/app_bar.dart';

class LanguageTabScaffold extends StatefulWidget {
  const LanguageTabScaffold({Key? key}) : super(key: key);

  @override
  _LanguageTabScaffoldState createState() => _LanguageTabScaffoldState();
}

class _LanguageTabScaffoldState extends State<LanguageTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: Text(context.l10n.language),
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
