import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../../favorites/favorites.dart';
import '../contacts.dart';

/// The contacts screen of a deployment where favourites live inside the
/// contacts section rather than in a section of their own.
///
/// Everything the list can be drawn from is stated in one control on the line
/// under the title: each address book, and the favourites. One control rather
/// than a chooser plus a switch on the title row, because the question a
/// person is answering is the same either way - which list do I want - and two
/// controls asking it invite the combination nobody meant: the favourites of
/// one address book, under a header still naming that book.
class ContactsFilterScreen extends StatefulWidget {
  const ContactsFilterScreen({
    super.key,
    required this.selections,
    required this.sourceTypeWidgetBuilder,
    required this.favoritesWidgetBuilder,
    this.title,
    this.style,
  });

  /// What this deployment offers to pick between, in the order it offers it.
  final List<ContactsListSelection> selections;

  /// Mounts the list of one address book.
  final Widget Function(BuildContext context, ContactSourceType sourceType, {bool markFavorites})
  sourceTypeWidgetBuilder;

  /// Mounts the favourites section's own list, rearrangeable when asked.
  final Widget Function(
    BuildContext context, {
    bool reorderMode,
    void Function(int index)? onReorderStart,
    void Function(int index)? onReorderEnd,
  })
  favoritesWidgetBuilder;

  final Widget? title;
  final ContactsScreenStyle? style;

  @override
  State<ContactsFilterScreen> createState() => _ContactsFilterScreenState();
}

class _ContactsFilterScreenState extends State<ContactsFilterScreen> {
  /// Whether the favourites entry is the one picked.
  ///
  /// Kept here rather than in [ContactsBloc]: that bloc remembers the address
  /// book across restarts, and favourites are not one - the star this replaced
  /// was a choice of the moment too.
  bool _favorites = false;

  bool _searching = false;

  final _reorder = FavoritesReorderController();

  @override
  void dispose() {
    _reorder.dispose();
    super.dispose();
  }

  /// Whether this deployment carries the favourites entry at all.
  bool get _offersFavorites => widget.selections.any((selection) => selection is ContactsFavoritesSelection);

  /// The address book the list is drawn from, or null where this deployment
  /// offers none.
  ///
  /// What [ContactsBloc] remembered is not always on offer: the choice
  /// outlives a change of configuration, and it starts out as a default nobody
  /// made.
  ContactSourceType? _shownSource(ContactSourceType remembered) {
    if (widget.selections.contains(ContactsSourceSelection(remembered))) return remembered;

    // The first address book rather than the first entry: favourites hold only
    // the people someone has starred, so opening on them when nothing was
    // chosen would greet a new account with an empty screen.
    for (final selection in widget.selections) {
      if (selection is ContactsSourceSelection) return selection.sourceType;
    }
    return null;
  }

  /// The list actually shown.
  ContactsListSelection _shown(ContactSourceType remembered) {
    if (_favorites && _offersFavorites) return const ContactsFavoritesSelection();

    final sourceType = _shownSource(remembered);
    if (sourceType != null) return ContactsSourceSelection(sourceType);

    // Favourites are all that is left. A tab configured with no lists at all
    // lands here too and shows an empty screen, exactly as the tabbed
    // arrangement does with no address books.
    return const ContactsFavoritesSelection();
  }

  void _onSelected(ContactsListSelection selection) {
    setState(() {
      _favorites = selection is ContactsFavoritesSelection;
      // Rearranging belongs to the favourites list; picking another one ends it
      // rather than leaving a mode on a list that cannot use it.
      if (!_favorites) _reorder.stop();
    });

    // Only an address book is worth remembering, and only when one was picked:
    // a hop through favourites and back must land on the book left behind.
    if (selection is ContactsSourceSelection) {
      context.read<ContactsBloc>().add(ContactsSourceTypeChanged(selection.sourceType));
    }
  }

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
        floatingActionButton: _favorites && _offersFavorites
            ? BlocBuilder<CallBloc, CallState>(
                buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
                // A transfer turns every row into a destination to pick, and
                // the bar announcing it takes the bottom of the screen.
                builder: (context, callState) => FavoritesReorderButton(
                  controller: _reorder,
                  identifier: contactsFavoritesReorderId,
                  bottomPadding: mediaQueryData.padding.bottom,
                  hidden: callState.isBlingTransferInitiated,
                ),
              )
            : null,
        appBar: MainAppBar(
          title: widget.title,
          context: context,
          flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(ContactsSearchRow.height),
            child: BlocBuilder<ContactsBloc, ContactsState>(
              buildWhen: (previous, current) => previous.sourceType != current.sourceType,
              builder: (context, state) {
                final selection = _shown(state.sourceType);

                return ContactsSearchRow(
                  inset: titleInset,
                  // Half the gap above, half below: the row is the whole
                  // header here, and its controls would otherwise sit against
                  // the avatar in the title row above them.
                  gapAbove: kMainAppBarBottomPaddingGap / 2,
                  searching: _searching,
                  // The favourites section has never offered a search, and a
                  // box that takes text and changes nothing is worse than none.
                  searchable: selection is! ContactsFavoritesSelection,
                  onSearchOpened: () => setState(() => _searching = true),
                  onSearchClosed: () => setState(() => _searching = false),
                  // With one list there is nothing to pick, so the search box
                  // takes the whole line, exactly as on the tabbed screen.
                  leading: widget.selections.length <= 1
                      ? null
                      : ContactsSourcePicker(
                          selections: widget.selections,
                          selected: selection,
                          onSelected: _onSelected,
                        ),
                );
              },
            ),
          ),
        ),
        // No inset of its own: the body runs behind the bar, and Scaffold
        // already hands it a MediaQuery whose top padding is the bar plus the
        // status bar. A list with no padding of its own takes that figure, and
        // so does the refresh indicator. Computing it here a second time is
        // what let the two disagree - it read kToolbarHeight where MainAppBar
        // is built from kMinInteractiveDimension, eight points apart.
        //
        // Favourites are not this screen's list narrowed down - they are the
        // favourites section's own list, drawn by the widget that section
        // draws it with. Deriving them a second time from the contacts table
        // is what made two answers to one question, and they disagree the
        // moment either side changes.
        //
        // Both are kept alive and only one is shown, because each is watched
        // by a bloc of its own: swapped in and out instead, every tap of the
        // control would tear a list down, build the other from nothing and
        // flash a spinner where a list already stood.
        body: BlocBuilder<ContactsBloc, ContactsState>(
          buildWhen: (previous, current) => previous.sourceType != current.sourceType,
          builder: (context, state) {
            // A tab can be configured with nothing to show at all.
            if (widget.selections.isEmpty) return const SizedBox.shrink();

            final shown = _shown(state.sourceType);

            // A slot per list, not one per kind of list. Sharing a slot
            // between the address books tears one down and builds the other
            // from nothing whenever someone changes book: a spinner where a
            // list already stood, and the place they had in it lost.
            return IndexedStack(
              index: widget.selections.indexOf(shown).clamp(0, widget.selections.length - 1),
              sizing: StackFit.expand,
              children: [
                for (final selection in widget.selections)
                  switch (selection) {
                    ContactsSourceSelection(:final sourceType) => widget.sourceTypeWidgetBuilder(
                      context,
                      sourceType,
                      markFavorites: true,
                    ),
                    // Listened to here as well as by the button: the two sit
                    // in different parts of the tree, and a button that
                    // changes its icon while the rows stay put is the whole
                    // thing not working.
                    ContactsFavoritesSelection() => ListenableBuilder(
                      listenable: _reorder,
                      builder: (context, _) => widget.favoritesWidgetBuilder(
                        context,
                        reorderMode: _reorder.active,
                        onReorderStart: _reorder.dragStarted,
                        onReorderEnd: _reorder.dragEnded,
                      ),
                    ),
                  },
              ],
            );
          },
        ),
      ),
    );
  }
}
