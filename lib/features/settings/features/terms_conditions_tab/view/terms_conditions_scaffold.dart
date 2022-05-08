import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class TermsConditionsTabScaffold extends StatefulWidget {
  const TermsConditionsTabScaffold({Key? key}) : super(key: key);

  @override
  _TermsConditionsTabScaffoldState createState() => _TermsConditionsTabScaffoldState();
}

class _TermsConditionsTabScaffoldState extends State<TermsConditionsTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_termsAndConditions),
        leading: const ExtBackButton(),
      ),
      body: Text(context.l10n.underDevelopment),
    );
  }
}
