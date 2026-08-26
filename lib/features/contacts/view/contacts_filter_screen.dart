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
  /// What someone picked, once they have picked anything.
  ///
  /// The screen decides this rather than reading it back from [ContactsBloc]:
  /// that bloc debounces the address book it is told about, so a screen that
  /// waited for it would keep drawing the previous list for a quarter of a
  /// second after every pick - a whole list mounted, watched and thrown away,
  /// and plainly the wrong one on the way out of favourites. The bloc is still
  /// told, because it is what remembers the address book across restarts.
  ///
  /// Only the address book is remembered that way, though. Favourites are a
  /// choice of the moment, exactly as the star this replaced was.
  ContactsListSelection? _picked;

  bool _searching = false;

  /// The list actually shown.
  ///
  /// [remembered] is what [ContactsBloc] restored, and it decides only until
  /// someone picks for themselves. Neither is always on offer: a pick is kept
  /// across a rebuild and the remembered book outlives a change of
  /// configuration, so both are checked against what this deployment offers.
  ContactsListSelection _shown(ContactSourceType remembered) {
    final picked = _picked;
    if (picked != null && widget.selections.contains(picked)) return picked;

    final rememberedSelection = ContactsSourceSelection(remembered);
    if (widget.selections.contains(rememberedSelection)) return rememberedSelection;

    // The first address book rather than simply the first entry: favourites
    // hold only the people someone has starred, so opening on them when
    // nothing was chosen would greet a new account with an empty screen.
    for (final selection in widget.selections) {
      if (selection is ContactsSourceSelection) return selection;
    }
    return widget.selections.first;
  }

  void _onSelected(ContactsListSelection selection) {
    setState(() => _picked = selection);

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
