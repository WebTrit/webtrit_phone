import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
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

  /// Whether the favourites rows can be dragged. The screen owns this because
  /// the button that turns it on is a slot of its scaffold, not part of the
  /// list.
  bool _reorderMode = false;

  /// Set while a row is under the finger, so a list that changes mid-drag can
  /// drop the mode rather than leave a half-finished move on screen.
  int? _draggingIndex;

  void _toggleReorderMode() => setState(() => _reorderMode = !_reorderMode);

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
      if (!_favorites) _reorderMode = false;
    });

    // Only an address book is worth remembering, and only when one was picked:
    // a hop through favourites and back must land on the book left behind.
    if (selection is ContactsSourceSelection) {
      context.read<ContactsBloc>().add(ContactsSourceTypeChanged(selection.sourceType));
    }
  }

  /// Leaves the rearranging mode when the list changed underneath it: a move
  /// that landed while a row was being dragged, and a list that became too
  /// short to rearrange - the button is the only way out and is not offered
  /// below the minimum, so the rows would stay locked.
  void _onFavoritesChanged(BuildContext context, FavoritesState state) {
    final tooShort = (state.favorites?.length ?? 0) < FavoritesList.reorderMinimum;
    if (_draggingIndex != null || (_reorderMode && tooShort)) {
      setState(() {
        _reorderMode = false;
        _draggingIndex = null;
      });
    }
  }

  /// The button that turns rearranging on, or nothing where there is too
  /// little to rearrange.
  Widget _reorderButton(MediaQueryData mediaQueryData) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favoritesState) {
        final favorites = favoritesState.favorites;
        if (favorites == null || favorites.length < FavoritesList.reorderMinimum) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<CallBloc, CallState>(
          buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
          builder: (context, callState) {
            // A transfer turns every row into a destination to pick, and the
            // bar announcing it takes the bottom of the screen. Rearranging is
            // neither wanted nor reachable there.
            if (callState.isBlingTransferInitiated) return const SizedBox.shrink();

            // The padding is what makes the button pressable at all: the tab
            // bar of the main screen floats over the page, and without it the
            // button is drawn underneath - invisible, and every tap goes to
            // the bar.
            return Padding(
              padding: EdgeInsets.only(bottom: mediaQueryData.padding.bottom),
              child: SemanticAction(
                label: _reorderMode
                    ? context.l10n.favorites_SemanticsLabel_reorderDone
                    : context.l10n.favorites_SemanticsLabel_reorder,
                identifier: contactsFavoritesReorderId,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: _toggleReorderMode,
                  child: Icon(_reorderMode ? Icons.check : Icons.edit_note_outlined),
                ),
              ),
            );
          },
        );
      },
    );
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
        floatingActionButton: _favorites && _offersFavorites ? _reorderButton(mediaQueryData) : null,
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
        body: MediaQuery(
          data: mediaQueryData.copyWith(
            padding: mediaQueryData.padding.copyWith(
              top: mediaQueryData.padding.top + kToolbarHeight + ContactsSearchRow.height,
            ),
          ),
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
          child: BlocListener<FavoritesBloc, FavoritesState>(
            listenWhen: (previous, current) => previous.favorites != current.favorites,
            listener: _onFavoritesChanged,
            child: BlocBuilder<ContactsBloc, ContactsState>(
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
                        ContactsFavoritesSelection() => widget.favoritesWidgetBuilder(
                          context,
                          reorderMode: _reorderMode,
                          onReorderStart: (index) => _draggingIndex = index,
                          onReorderEnd: (index) => _draggingIndex = null,
                        ),
                      },
                  ],
                );
              },
            ),
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
