import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../favorites.dart';

class FavoritesScaffold extends StatelessWidget {
  const FavoritesScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status == FavoritesStatus.initial || state.status == FavoritesStatus.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.favorites.isNotEmpty) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return FavoriteTile(
                  favorite: favorite,
                  onTap: () {
                    context.read<CallBloc>().add(CallOutgoingStarted(number: favorite.number, video: false));
                  },
                  onLongPress: () {
                    context.read<CallBloc>().add(CallOutgoingStarted(number: favorite.number, video: true));
                  },
                  onInfoPressed: () {
                    context.pushNamed('contact', extra: favorite.contact);
                  },
                  onDeleted: (favorite) {
                    context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.name));

                    context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
                  },
                );
              },
            );
          } else {
            late final List<Widget> children;
            if (state.status == FavoritesStatus.failure) {
              children = [
                Text(context.l10n.favorites_BodyCenter_failure),
              ];
            } else {
              children = [
                Icon(
                  Icons.star_outline,
                  size: 80,
                  color: themeData.textTheme.caption!.color,
                ),
                const SizedBox(height: 10),
                Text(
                  context.l10n.favorites_BodyCenter_empty,
                  style: themeData.textTheme.subtitle1,
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            );
          }
        },
      ),
    );
  }
}
