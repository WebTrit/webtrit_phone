import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../features/contacts_local_tab/view/contacts_local_tab.dart';
import '../features/contacts_external_tab/view/contacts_external_tab.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          bottom: TabBar(
            tabs: [
              context.l10n.contactsSourceLocal,
              context.l10n.contactsSourceExternal,
            ].map((value) => Tab(child: Text(value, softWrap: false))).toList(),
            labelColor: themeData.textTheme.caption!.color,
          ),
        ),
        body: const TabBarView(children: [
          ContactsLocalTab(),
          ContactsExternalTab(),
        ]),
      ),
    );
  }
}
