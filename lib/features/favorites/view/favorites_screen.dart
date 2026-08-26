import 'package:flutter/material.dart';
import 'package:webtrit_phone/app/keys.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../favorites.dart';
import 'favorites_screen_style.dart';
import 'favorites_screen_styles.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
    required this.cdrsEnabled,
    this.style,
  });

  final Widget? title;
  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;
  final bool cdrsEnabled;
  final FavoritesScreenStyle? style;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isReorderMode = false;
  int? draggingIndex;

  void toggleReorderMode() => setState(() => isReorderMode = !isReorderMode);

  void onReorderStart(int index) {
    draggingIndex = index;
  }

  /// Clears the drag marker. The move itself is sent from the list's
  /// `onReorder` callback, which fires for a finished drag and for the move
  /// actions the list offers to a screen reader alike, so both take one path.
  void onReorderEnd(int index) {
    draggingIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<FavoritesScreenStyles>()?.primary;
    final mediaQueryData = MediaQuery.of(context);
    final topPadding = kToolbarHeight + mediaQueryData.padding.top;

    return ThemedScaffold(
      background: effectiveStyle?.background,
      contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
      applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
      appBarTheme: effectiveStyle?.appBarTheme,
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        title: widget.title,
        context: context,
        flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null || favorites.length < FavoritesList.reorderMinimum) {
            return const SizedBox.shrink();
          }
          // The padding is what makes the button pressable at all: the tab bar
          // of the main screen floats over the page, and without it the button
          // is drawn underneath - invisible, and every tap goes to the bar.
          return Padding(
            // Exactly the room the bar takes, whatever the device: the shell
            // reports it to the page as bottom padding (its own height plus
            // the system inset underneath). Scaffold does not apply it to the
            // button, so the page does - adding the bar height on top of it
            // would push the button a bar's height too high.
            padding: EdgeInsets.only(bottom: mediaQueryData.padding.bottom),
            // Only the icon said what this does, and it says two different
            // things depending on whether rearranging is already under way.
            child: SemanticAction(
              label: isReorderMode
                  ? context.l10n.favorites_SemanticsLabel_reorderDone
                  : context.l10n.favorites_SemanticsLabel_reorder,
              identifier: favoritesReorderId,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: toggleReorderMode,
                child: Icon(isReorderMode ? Icons.check : Icons.edit_note_outlined),
              ),
            ),
          );
        },
      ),
      body: BlocListener<FavoritesBloc, FavoritesState>(
        listenWhen: (previous, current) => previous.favorites != current.favorites,
        listener: (context, state) {
          // Two reasons to leave the rearranging mode, both about a list that
          // changed underneath: a move that landed while a row was being
          // dragged, and a list that became too short to rearrange - the
          // button is the only way out of the mode and it is not offered
          // below the minimum, so the rows would stay locked.
          final tooShortToReorder = (state.favorites?.length ?? 0) < FavoritesList.reorderMinimum;
          if (draggingIndex != null || (isReorderMode && tooShortToReorder)) {
            setState(() {
              isReorderMode = false;
              draggingIndex = null;
            });
          }
        },
        child: FavoritesList(
          reorderMode: isReorderMode,
          onReorderStart: onReorderStart,
          onReorderEnd: onReorderEnd,
          topPadding: topPadding,
          transferEnabled: widget.transferEnabled,
          videoEnabled: widget.videoEnabled,
          chatsEnabled: widget.chatsEnabled,
          smssEnabled: widget.smssEnabled,
          cdrsEnabled: widget.cdrsEnabled,
        ),
      ),
      bottomNavigationBar: BlocBuilder<CallBloc, CallState>(
        buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
        builder: (context, callState) {
          if (callState.isBlingTransferInitiated) {
            return TransferBottomNavigationBar(context.l10n.favorites_Text_blingTransferInitiated);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
