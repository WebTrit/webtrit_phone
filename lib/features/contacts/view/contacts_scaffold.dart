import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';
import '../features/contacts_local_tab/view/contacts_local_tab.dart';
import '../features/contacts_external_tab/view/contacts_external_tab.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppBar(
            bottom: TabBarSearch(
              tabBar: TabBar(
                tabs: [
                  context.l10n.contactsSourceLocal,
                  context.l10n.contactsSourceExternal,
                ].map((value) => Tab(child: Text(value, softWrap: false))).toList(),
              ),
              search: IgnoreUnfocuser(
                child: BlocBuilder<ContactsSearchBloc, String>(
                  builder: (context, state) {
                    final contactsSearchBloc = context.read<ContactsSearchBloc>();
                    return ClearedTextField(
                      initialValue: state,
                      onChanged: (value) => contactsSearchBloc.add(ContactsSearchChanged(value)),
                      onSubmitted: (value) => contactsSearchBloc.add(ContactsSearchSubmitted(value)),
                    );
                  },
                ),
              ),
            ),
          ),
          body: const TabBarView(children: [
            ContactsLocalTab(),
            ContactsExternalTab(),
          ]),
        ),
      ),
    );
  }
}
