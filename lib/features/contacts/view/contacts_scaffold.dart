import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';
import '../features/contacts_local_tab/view/contacts_local_tab.dart';
import '../features/contacts_external_tab/view/contacts_external_tab.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  static const _tabHeight = 42.0;
  static const _searchHeight = kMinInteractiveDimension;
  static const _paddingGap = 6.0;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);

    final tabBar = Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, _paddingGap),
      child: ExtTabBar(
        width: mediaQueryData.size.width * 0.6,
        height: _tabHeight - _paddingGap,
        tabs: [
          context.l10n.contactsSourceLocal,
          context.l10n.contactsSourceExternal,
        ].map((value) => Tab(text: value)).toList(),
      ),
    );

    final search = Padding(
      padding: const EdgeInsets.fromLTRB(_paddingGap, 0, _paddingGap, _paddingGap),
      child: Ink(
        decoration: BoxDecoration(
          color: themeData.colorScheme.background,
          borderRadius: BorderRadius.circular(_searchHeight / 2),
        ),
        child: IgnoreUnfocuser(
          child: BlocBuilder<ContactsSearchBloc, String>(
            builder: (context, state) {
              final contactsSearchBloc = context.read<ContactsSearchBloc>();
              return ClearedTextField(
                initialValue: state,
                onChanged: (value) => contactsSearchBloc.add(ContactsSearchChanged(value)),
                onSubmitted: (value) => contactsSearchBloc.add(ContactsSearchSubmitted(value)),
                iconConstraints: const BoxConstraints(
                  minWidth: _searchHeight,
                  minHeight: _searchHeight - _paddingGap,
                ),
              );
            },
          ),
        ),
      ),
    );

    return Unfocuser(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: MainAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(_tabHeight + _searchHeight),
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
