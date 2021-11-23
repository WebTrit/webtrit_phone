import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../features/contacts_local_tab/view/contacts_local_tab.dart';
import '../features/contacts_external_tab/view/contacts_external_tab.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          bottom: _TabBarSearch(
            tabBar: TabBar(
              tabs: [
                context.l10n.contactsSourceLocal,
                context.l10n.contactsSourceExternal,
              ].map((value) => Tab(child: Text(value, softWrap: false))).toList(),
            ),
            search: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {},
                ),
                border: InputBorder.none,
              ),
            ),
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

class _TabBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const _TabBarSearch({
    Key? key,
    required this.tabBar,
    required this.search,
  }) : super(key: key);

  final TabBar tabBar;
  final TextField search;

  static const _searchHeight = kMinInteractiveDimension;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tabBar,
        SizedBox(
          height: _searchHeight,
          child: search,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(tabBar.preferredSize.height + _searchHeight);
}
