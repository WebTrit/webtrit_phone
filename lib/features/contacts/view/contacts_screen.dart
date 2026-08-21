import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../contacts.dart';

export 'contacts_screen_styles.dart';
export 'contacts_screen_style.dart';

typedef ContactSourceTypeWidgetBuilder = Widget Function(BuildContext context, ContactSourceType sourceType);

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({
    super.key,
    required this.sourceTypes,
    required this.sourceTypeWidgetBuilder,
    this.title,
    this.style,
  });

  final List<ContactSourceType> sourceTypes;
  final ContactSourceTypeWidgetBuilder sourceTypeWidgetBuilder;

  final Widget? title;
  final ContactsScreenStyle? style;

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

  /// Tab of one contact source, addressable by the id of that source.
  ExtTab _tab(BuildContext context, ContactSourceType sourceType) {
    final (key, identifier) = switch (sourceType) {
      ContactSourceType.local => (contactsTabLocalKey, contactsTabLocalId),
      ContactSourceType.external => (contactsTabExtKey, contactsTabExtId),
    };

    return ExtTab(key: key, identifier: identifier, text: sourceType.l10n(context));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<ContactsScreenStyles>()?.primary;
    final mediaQueryData = MediaQuery.of(context);

    final tabBar = widget.sourceTypes.length <= 1
        ? null
        : Padding(
            padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
            child: ExtTabBar(
              controller: _tabController,
              width: mediaQueryData.size.width * 0.75,
              height: kMainAppBarBottomControlHeight,
              tabs: [for (final sourceType in widget.sourceTypes) _tab(context, sourceType)],
            ),
          );

    const search = ContactsSearchRow();

    // What the bar below the title takes up. Stated once: the bar is built
    // from it and the body is inset by it, and the two drifting apart is how
    // a list ends up starting underneath the search field.
    final appBarBottomHeight = (tabBar != null ? kMainAppBarBottomTabHeight : 0) + ContactsSearchRow.height;
    final appBar = MainAppBar(
      title: widget.title,
      context: context,
      flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(appBarBottomHeight),
        child: Column(children: [?tabBar, search]),
      ),
    );

    return Unfocuser(
      child: ThemedScaffold(
        background: effectiveStyle?.background,
        contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
        applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
        appBarTheme: effectiveStyle?.appBarTheme,
        extendBodyBehindAppBar: true,
        appBar: appBar,
        body: MediaQuery(
          data: mediaQueryData.copyWith(
            padding: mediaQueryData.padding.copyWith(
              top: mediaQueryData.padding.top + kToolbarHeight + appBarBottomHeight,
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              for (final sourceType in widget.sourceTypes) widget.sourceTypeWidgetBuilder(context, sourceType),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<CallBloc, CallState>(
          buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
          builder: (context, callState) {
            if (callState.isBlingTransferInitiated) {
              return TransferBottomNavigationBar(context.l10n.contacts_Text_blingTransferInitiated);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
