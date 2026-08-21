import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
/// filter is a control of the screen and sits with the others on the title
/// row, while the address book behind the list is stated on the line below,
/// where the list's own controls are. Both draw the same lists as the other
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
  final Widget Function(BuildContext context, ContactSourceType sourceType, {bool favoritesOnly, bool markFavorites})
  sourceTypeWidgetBuilder;

  final Widget? title;
  final ContactsScreenStyle? style;

  @override
  State<ContactsFilterScreen> createState() => _ContactsFilterScreenState();
}

class _ContactsFilterScreenState extends State<ContactsFilterScreen> {
  ContactsListFilter _filter = ContactsListFilter.all;
  bool _searching = false;

  /// The address book actually shown for a remembered choice.
  ///
  /// What was remembered is not always on offer: the choice outlives a change
  /// of configuration, and it starts out as a default nobody picked. Falling
  /// back to the first configured one keeps the list and the control saying
  /// the same thing.
  ContactSourceType _shown(ContactSourceType remembered) =>
      widget.sourceTypes.contains(remembered) ? remembered : widget.sourceTypes.first;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<ContactsScreenStyles>()?.primary;
    final mediaQueryData = MediaQuery.of(context);

    // The line lines up with the title above it rather than with the screen
    // edge, and the figure is taken from the bar itself so the two cannot
    // drift apart.
    final titleInset = themeData.appBarTheme.titleSpacing ?? NavigationToolbar.kMiddleSpacing;

    // One line under the title, not two: the filter took a strip of its own
    // here and now sits on the title row, which is what lets the list start
    // this much sooner.
    //
    // The line takes exactly what a row of tabs takes on every other screen,
    // so a person moving between sections sees the list start in the same
    // place rather than a header that grows and shrinks under them.

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
          actions: [
            ContactsFavoritesAction(
              selected: _filter == ContactsListFilter.favorites,
              onTap: () => setState(
                () => _filter = _filter == ContactsListFilter.favorites
                    ? ContactsListFilter.all
                    : ContactsListFilter.favorites,
              ),
            ),
          ],
          flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(ContactsSearchRow.height),
            child: ContactsSearchRow(
              inset: titleInset,
              searching: _searching,
              onSearchOpened: () => setState(() => _searching = true),
              onSearchClosed: () => setState(() => _searching = false),
              // With one address book there is nothing to pick, so the search
              // box takes the whole line, exactly as on the screen without the
              // filter.
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
          ),
        ),
        body: MediaQuery(
          data: mediaQueryData.copyWith(
            padding: mediaQueryData.padding.copyWith(
              top: mediaQueryData.padding.top + kToolbarHeight + ContactsSearchRow.height,
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
                  markFavorites: true,
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
