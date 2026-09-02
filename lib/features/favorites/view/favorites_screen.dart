import 'package:flutter/material.dart';
import 'package:webtrit_phone/app/keys.dart';

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
  final _reorder = FavoritesReorderController();

  @override
  void dispose() {
    _reorder.dispose();
    super.dispose();
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
      floatingActionButton: FavoritesReorderButton(
        controller: _reorder,
        identifier: favoritesReorderId,
        bottomPadding: mediaQueryData.padding.bottom,
      ),
      body: ListenableBuilder(
        listenable: _reorder,
        builder: (context, _) => FavoritesList(
          reorderMode: _reorder.active,
          onReorderStart: _reorder.dragStarted,
          onReorderEnd: _reorder.dragEnded,
          topPadding: topPadding,
          transferEnabled: widget.transferEnabled,
          videoEnabled: widget.videoEnabled,
          chatsEnabled: widget.chatsEnabled,
          smssEnabled: widget.smssEnabled,
          cdrsEnabled: widget.cdrsEnabled,
        ),
      ),
    );
  }
}
