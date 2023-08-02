import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contacts.dart';

typedef ContactSourceTypeWidgetBuilder = Widget Function(BuildContext context, ContactSourceType sourceType);

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({
    super.key,
    required this.sourceTypes,
    required this.sourceTypeWidgetBuilder,
    required this.appPreferences,
  });

  final List<ContactSourceType> sourceTypes;
  final ContactSourceTypeWidgetBuilder sourceTypeWidgetBuilder;
  final AppPreferences appPreferences;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final defaultTabIndex = widget.appPreferences.getActiveIndex(MainRoute.contacts, defaultValue: 1);

    _tabController = TabController(
      initialIndex: defaultTabIndex,
      length: widget.sourceTypes.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      widget.appPreferences.setActiveIndex(MainRoute.contacts, _tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    final tabBar = widget.sourceTypes.length <= 1
        ? null
        : Padding(
            padding: const EdgeInsets.only(
              bottom: kMainAppBarBottomPaddingGap,
            ),
            child: ExtTabBar(
              controller: _tabController,
              width: mediaQueryData.size.width * 0.6,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: [
                for (final sourceType in widget.sourceTypes) Tab(text: sourceType.l10n(context)),
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
          controller: _tabController,
          children: [
            for (final sourceType in widget.sourceTypes) widget.sourceTypeWidgetBuilder(context, sourceType),
          ],
        ),
      ),
    );
  }
}
