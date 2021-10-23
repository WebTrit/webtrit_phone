import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import 'contacts_local_tab.dart';
import 'contacts_external_tab.dart';

import '../contacts.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: ContactsSource.values.length,
      child: Scaffold(
        appBar: MainAppBar(
          bottom: TabBar(
            tabs: ContactsSource.values.map((value) => Tab(child: Text(value.l10n(context), softWrap: false))).toList(),
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
