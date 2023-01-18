import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';

class ContactsScaffold extends StatelessWidget {
  const ContactsScaffold({
    super.key,
    required this.sourceTypes,
  });

  final List<ContactSourceType> sourceTypes;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final tabBar = sourceTypes.length <= 1
        ? null
        : Padding(
            padding: const EdgeInsets.only(
              bottom: kMainAppBarBottomPaddingGap,
            ),
            child: ExtTabBar(
              width: mediaQueryData.size.width * 0.6,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: [
                for (final sourceType in sourceTypes) Tab(text: sourceType.l10n(context)),
              ],
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
        length: sourceTypes.length,
        child: Scaffold(
          appBar: MainAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                (tabBar != null ? kMainAppBarBottomTabHeight : 0) + kMainAppBarBottomSearchHeight,
              ),
              child: Column(
                children: [
                  if (tabBar != null) tabBar,
                  search,
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              for (final sourceType in sourceTypes) sourceType.builder(context),
            ],
          ),
        ),
      ),
    );
  }
}
