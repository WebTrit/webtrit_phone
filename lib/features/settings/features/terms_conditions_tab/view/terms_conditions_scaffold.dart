import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import '../../../../../widgets/app_bar.dart';

class TermsConditionsTabScaffold extends StatefulWidget {
  const TermsConditionsTabScaffold({Key? key}) : super(key: key);

  @override
  _TermsConditionsTabScaffoldState createState() => _TermsConditionsTabScaffoldState();
}

class _TermsConditionsTabScaffoldState extends State<TermsConditionsTabScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_termsAndConditions),
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
