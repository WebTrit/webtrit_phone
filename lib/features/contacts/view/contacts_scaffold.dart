import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';
import '../features/contacts_local_tab/view/contacts_local_tab.dart';
import '../features/contacts_external_tab/view/contacts_external_tab.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final tabBar = Padding(
      padding: const EdgeInsets.only(
        bottom: kMainAppBarBottomPaddingGap,
      ),
      child: ExtTabBar(
        width: mediaQueryData.size.width * 0.6,
        height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
        tabs: [
          context.l10n.contactsSourceLocal,
          context.l10n.contactsSourceExternal,
        ].map((value) => Tab(text: value)).toList(),
      ),
    );

    final search = Padding(
      padding: const EdgeInsets.only(
        left: kMainAppBarBottomPaddingGap,
        right: kMainAppBarBottomPaddingGap,
        bottom: kMainAppBarBottomPaddingGap,
      ),
      child: IgnoreUnfocuser(
        child: BlocBuilder<ContactsSearchBloc, String>(
          builder: (context, state) {
            final contactsSearchBloc = context.read<ContactsSearchBloc>();
            return ClearedTextField(
              initialValue: state,
              onChanged: (value) => contactsSearchBloc.add(ContactsSearchChanged(value)),
              onSubmitted: (value) => contactsSearchBloc.add(ContactsSearchSubmitted(value)),
              iconConstraints: const BoxConstraints.expand(
                width: kMainAppBarBottomSearchHeight - kMainAppBarBottomPaddingGap,
                height: kMainAppBarBottomSearchHeight - kMainAppBarBottomPaddingGap,
              ),
            );
          },
        ),
      ),
    );

    return Unfocuser(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight + kMainAppBarBottomSearchHeight),
              child: Column(
                children: [
                  tabBar,
                  search,
                ],
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
