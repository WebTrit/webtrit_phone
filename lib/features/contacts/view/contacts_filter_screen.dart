import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../contacts.dart';

/// Which rows of the address book the list shows.
enum ContactsListFilter { all, favorites }

/// The contacts screen of a deployment where favourites are a filter rather
/// than a section of their own.
///
/// The two choices on this screen are not equals, and the layout says so: the
/// filter takes the wide control at the top because it is what a person
/// changes often, while the address book behind the list sits beside the
/// search box, where a word is enough. Both draw the same lists as the other
/// contacts screen, through the same search box - the rows, their order and
/// what they show are the other screen's, not this one's.
class ContactsFilterScreen extends StatefulWidget {
  const ContactsFilterScreen({
    super.key,
    required this.sourceTypes,
    required this.sourceTypeWidgetBuilder,
    this.title,
    this.style,
  });

  final List<ContactSourceType> sourceTypes;

  /// Mounts the list of one address book, narrowed to favourites when asked.
  final Widget Function(BuildContext context, ContactSourceType sourceType, {bool favoritesOnly})
  sourceTypeWidgetBuilder;

  final Widget? title;
  final ContactsScreenStyle? style;

  @override
  State<ContactsFilterScreen> createState() => _ContactsFilterScreenState();
}

class _ContactsFilterScreenState extends State<ContactsFilterScreen> with SingleTickerProviderStateMixin {
  late final TabController _filterController = TabController(length: ContactsListFilter.values.length, vsync: this)
    ..addListener(_filterChanged);

  ContactsListFilter _filter = ContactsListFilter.all;

  void _filterChanged() {
    // Follows the index itself rather than waiting for the animation to
    // finish: there is no page to swipe here, only the control, so the list
    // should change the moment the choice does.
    final picked = ContactsListFilter.values[_filterController.index];
    if (picked == _filter) return;
    setState(() => _filter = picked);
  }

  @override
  void dispose() {
    _filterController
      ..removeListener(_filterChanged)
      ..dispose();
    super.dispose();
  }

  /// The address book actually shown for a remembered choice.
  ///
  /// What was remembered is not always on offer: the choice outlives a change
  /// of configuration, and it starts out as a default nobody picked. Falling
  /// back to the first configured one keeps the list and the control saying
  /// the same thing.
  ContactSourceType _shown(ContactSourceType remembered) =>
      widget.sourceTypes.contains(remembered) ? remembered : widget.sourceTypes.first;

  ExtTab _filterTab(BuildContext context, ContactsListFilter filter) {
    final l10n = context.l10n;
    final (key, identifier, text) = switch (filter) {
      ContactsListFilter.all => (contactsFilterAllKey, contactsFilterAllId, l10n.contacts_ContactsScreen_filterAll),
      ContactsListFilter.favorites => (
        contactsFilterFavoritesKey,
        contactsFilterFavoritesId,
        l10n.contacts_ContactsScreen_filterFavorites,
      ),
    };

    // The chosen side carries a tick as well as its colour. Colour alone is
    // the one thing this control must not rely on - the two sides are the
    // same shape and the same words apart from it.
    return ExtTab.child(
      key: key,
      identifier: identifier,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          if (filter == _filter) const ExcludeSemantics(child: Icon(Icons.check_rounded, size: 18)),
          Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<ContactsScreenStyles>()?.primary;
    final mediaQueryData = MediaQuery.of(context);

    final filterBar = Padding(
      padding: const EdgeInsets.only(bottom: kMainAppBarBottomPaddingGap),
      child: ExtTabBar(
        controller: _filterController,
        width: mediaQueryData.size.width * 0.75,
        height: kMainAppBarBottomControlHeight,
        tabs: [for (final filter in ContactsListFilter.values) _filterTab(context, filter)],
      ),
    );

    final appBarBottomHeight = kMainAppBarBottomTabHeight + ContactsSearchRow.height;

    return Unfocuser(
      child: ThemedScaffold(
        background: effectiveStyle?.background,
        contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
        applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
        appBarTheme: effectiveStyle?.appBarTheme,
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          title: widget.title,
          context: context,
          flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(appBarBottomHeight),
            child: Column(
              children: [
                filterBar,
                // With one address book there is nothing to pick, so the
                // search box takes the whole line, exactly as on the screen
                // without the filter.
                ContactsSearchRow(
                  leading: widget.sourceTypes.length <= 1
                      ? null
                      : BlocBuilder<ContactsBloc, ContactsState>(
                          buildWhen: (previous, current) => previous.sourceType != current.sourceType,
                          builder: (context, state) => ContactsSourcePicker(
                            sourceTypes: widget.sourceTypes,
                            selected: _shown(state.sourceType),
                            onSelected: (sourceType) =>
                                context.read<ContactsBloc>().add(ContactsSourceTypeChanged(sourceType)),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        body: MediaQuery(
          data: mediaQueryData.copyWith(
            padding: mediaQueryData.padding.copyWith(
              top: mediaQueryData.padding.top + kToolbarHeight + appBarBottomHeight,
            ),
          ),
          child: BlocBuilder<ContactsBloc, ContactsState>(
            buildWhen: (previous, current) => previous.sourceType != current.sourceType,
            // Keyed by the address book alone. Its list is fetched and watched
            // per address book, so a different one is a different list; the
            // filter only decides how much of the same list is shown, and
            // keying on it as well would refetch and flash a spinner on every
            // tap of the control.
            builder: (context, state) {
              final sourceType = _shown(state.sourceType);

              return KeyedSubtree(
                key: ValueKey(sourceType),
                child: widget.sourceTypeWidgetBuilder(
                  context,
                  sourceType,
                  favoritesOnly: _filter == ContactsListFilter.favorites,
                ),
              );
            },
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
