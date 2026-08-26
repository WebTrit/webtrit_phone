import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../contacts.dart';

/// Mounts the list one selection stands for.
typedef ContactsListSelectionWidgetBuilder = Widget Function(BuildContext context, ContactsListSelection selection);

/// The contacts screen of a deployment where favourites live inside the
/// contacts section rather than in a section of their own.
///
/// Everything the list is drawn from is stated in one control on the line
/// under the title: each address book, and the favourites of all of them
/// together. One control rather than a chooser plus a switch, because the
/// question a person is answering is the same one either way - which list do I
/// want - and two controls asking it invite the combination nobody meant, the
/// favourites of one address book with the other one's hidden.
class ContactsFilterScreen extends StatefulWidget {
  const ContactsFilterScreen({
    super.key,
    required this.selections,
    required this.selectionWidgetBuilder,
    this.title,
    this.style,
  });

  /// What this deployment offers to pick between, in the order the control
  /// offers it.
  final List<ContactsListSelection> selections;

  final ContactsListSelectionWidgetBuilder selectionWidgetBuilder;

  final Widget? title;
  final ContactsScreenStyle? style;

  @override
  State<ContactsFilterScreen> createState() => _ContactsFilterScreenState();
}

class _ContactsFilterScreenState extends State<ContactsFilterScreen> {
  /// Whether favourites are the list being shown.
  ///
  /// Kept here rather than in [ContactsBloc]: the bloc remembers the address
  /// book across restarts, and favourites are not one - the star that used to
  /// carry this was a choice of the moment too, and making it outlive the
  /// screen is a separate decision from moving it.
  bool _favorites = false;

  bool _searching = false;

  static const _favoritesSelection = ContactsFavoritesSelection();

  /// Whether this deployment carries the favourites entry at all. It can turn
  /// them off inside this section, and then [_favorites] must never decide
  /// what the list shows.
  bool get _offersFavorites => widget.selections.contains(_favoritesSelection);

  /// The list actually shown for a remembered address book.
  ///
  /// What was remembered is not always on offer: the choice outlives a change
  /// of configuration, and it starts out as a default nobody picked. Falling
  /// back to the first configured entry keeps the list and the control saying
  /// the same thing.
  ContactsListSelection _shown(ContactSourceType remembered) {
    if (_favorites && _offersFavorites) return _favoritesSelection;

    final rememberedSelection = ContactsSourceSelection(remembered);
    return widget.selections.contains(rememberedSelection) ? rememberedSelection : widget.selections.first;
  }

  void _onSelected(ContactsListSelection selection) {
    setState(() => _favorites = selection is ContactsFavoritesSelection);

    // The address book is only re-stated when one was picked: a hop through
    // favourites and back must land on the address book left behind, not on
    // whatever the list happened to fall back to.
    final sourceType = selection.sourceType;
    if (sourceType != null) context.read<ContactsBloc>().add(ContactsSourceTypeChanged(sourceType));
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

    // One line under the title, not two: everything this screen offers to pick
    // between is in the chooser on that line, which is what lets the list
    // start this much sooner.
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
          flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(ContactsSearchRow.height),
            child: ContactsSearchRow(
              inset: titleInset,
              // Half the gap above, half below: the row is the whole header
              // here, and its controls would otherwise sit against the avatar
              // in the title row above them.
              gapAbove: kMainAppBarBottomPaddingGap / 2,
              searching: _searching,
              onSearchOpened: () => setState(() => _searching = true),
              onSearchClosed: () => setState(() => _searching = false),
              // With one list there is nothing to pick, so the search box
              // takes the whole line, exactly as on the tabbed screen.
              leading: widget.selections.length <= 1
                  ? null
                  : BlocBuilder<ContactsBloc, ContactsState>(
                      buildWhen: (previous, current) => previous.sourceType != current.sourceType,
                      builder: (context, state) => ContactsSourcePicker(
                        selections: widget.selections,
                        selected: _shown(state.sourceType),
                        onSelected: _onSelected,
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
            // Keyed by the selection: each one is fetched and watched by a
            // bloc of its own, so a different selection is a different list
            // and has to be mounted as one.
            builder: (context, state) {
              final selection = _shown(state.sourceType);

              return KeyedSubtree(key: ValueKey(selection), child: widget.selectionWidgetBuilder(context, selection));
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
