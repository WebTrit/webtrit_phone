import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
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
  });

  final List<ContactSourceType> sourceTypes;
  final ContactSourceTypeWidgetBuilder sourceTypeWidgetBuilder;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final activeSourceType = context.read<ContactsBloc>().state.sourceType;
    final initialSourceTypesIndex = widget.sourceTypes.indexOf(activeSourceType);

    _tabController = TabController(
      initialIndex: initialSourceTypesIndex == -1 ? 0 : initialSourceTypesIndex,
      length: widget.sourceTypes.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      final sourceType = widget.sourceTypes[_tabController.index];
      context.read<ContactsBloc>().add(ContactsSourceTypeChanged(sourceType));
    }
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
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            final contactsSearchBloc = context.read<ContactsBloc>();
            return ClearedTextField(
              initialValue: state.search,
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
